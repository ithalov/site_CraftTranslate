begin;

create or replace function public.public_leaderboard_rankings(leaderboard_period text default 'all_time')
returns table (
  leaderboard_kind text,
  period text,
  user_id uuid,
  display_name text,
  username text,
  avatar_url text,
  primary_language_code text,
  primary_language_name text,
  primary_language_native_name text,
  primary_language_emoji text,
  role text,
  total_xp bigint,
  reputation_score bigint,
  contribution_points bigint,
  translations_count bigint,
  approved_suggestions_count bigint,
  reviews_count bigint,
  approved_reviews_count bigint,
  badges_count bigint,
  approval_rate numeric(5,2),
  ranking_score bigint,
  rank bigint,
  badges jsonb
)
language sql
stable
security definer
set search_path = public, auth
as $$
  with leaderboard_window as (
    select
      case lower(trim(coalesce(leaderboard_period, 'all_time')))
        when 'year' then date_trunc('year', now())
        when 'month' then date_trunc('month', now())
        when 'week' then date_trunc('week', now())
        else null
      end as window_start,
      case lower(trim(coalesce(leaderboard_period, 'all_time')))
        when 'year' then 'year'
        when 'month' then 'month'
        when 'week' then 'week'
        else 'all_time'
      end as period_key
  ),
  active_profiles as (
    select
      p.user_id,
      p.display_name,
      p.username,
      p.avatar_url,
      p.role::text as role
    from public.profiles p
    where p.display_name is not null or p.username is not null
  ),
  primary_languages as (
    select distinct on (ul.user_id)
      ul.user_id,
      l.code as primary_language_code,
      l.name as primary_language_name,
      l.native_name as primary_language_native_name,
      l.emoji as primary_language_emoji
    from public.user_languages ul
    join public.languages l on l.id = ul.language_id
    order by
      ul.user_id,
      ul.is_primary desc,
      ul.is_native desc,
      l.sort_order asc,
      l.name asc
  ),
  xp_rows as (
    select
      xe.user_id,
      coalesce(sum(xe.xp_delta), 0)::bigint as total_xp
    from public.xp_events xe
    cross join leaderboard_window lw
    where lw.window_start is null or xe.created_at >= lw.window_start
    group by xe.user_id
  ),
  reputation_rows as (
    select
      re.user_id,
      coalesce(sum(re.delta), 0)::bigint as reputation_score
    from public.reputation_events re
    cross join leaderboard_window lw
    where lw.window_start is null or re.created_at >= lw.window_start
    group by re.user_id
  ),
  translation_rows as (
    select
      ts.author_id as user_id,
      count(*)::bigint as translations_count,
      (count(*) filter (where ts.status = 'approved'))::bigint as approved_suggestions_count
    from public.translation_suggestions ts
    cross join leaderboard_window lw
    where lw.window_start is null or ts.created_at >= lw.window_start
    group by ts.author_id
  ),
  review_rows as (
    select
      r.reviewer_id as user_id,
      count(*)::bigint as reviews_count,
      (count(*) filter (where r.decision = 'approve'))::bigint as approved_reviews_count
    from public.reviews r
    cross join leaderboard_window lw
    where lw.window_start is null or r.created_at >= lw.window_start
    group by r.reviewer_id
  ),
  badge_source as (
    select
      ub.user_id,
      b.id as badge_id,
      b.slug,
      b.name,
      b.description,
      b.rarity::text as rarity,
      b.icon,
      ub.awarded_at,
      case b.rarity
        when 'legendary' then 4
        when 'epic' then 3
        when 'rare' then 2
        else 1
      end as rarity_rank,
      row_number() over (
        partition by ub.user_id
        order by
          case b.rarity
            when 'legendary' then 4
            when 'epic' then 3
            when 'rare' then 2
            else 1
          end desc,
          ub.awarded_at desc,
          b.name asc
      ) as badge_position
    from public.user_badges ub
    join public.badges b on b.id = ub.badge_id
    cross join leaderboard_window lw
    where lw.window_start is null or ub.awarded_at >= lw.window_start
  ),
  badge_rows as (
    select
      user_id,
      count(*)::bigint as badges_count,
      coalesce(
        jsonb_agg(
          jsonb_build_object(
            'badge_id', badge_id,
            'slug', slug,
            'name', name,
            'description', description,
            'rarity', rarity,
            'icon', icon,
            'awarded_at', awarded_at
          )
          order by rarity_rank desc, awarded_at desc, name asc
        ) filter (where badge_position <= 3),
        '[]'::jsonb
      ) as badges
    from badge_source
    group by user_id
  ),
  leaderboard_base as (
    select
      lw.period_key as period,
      ap.user_id,
      ap.display_name,
      ap.username,
      ap.avatar_url,
      pl.primary_language_code,
      pl.primary_language_name,
      pl.primary_language_native_name,
      pl.primary_language_emoji,
      ap.role,
      coalesce(x.total_xp, 0) as total_xp,
      coalesce(r.reputation_score, 0) as reputation_score,
      coalesce(t.translations_count, 0) as translations_count,
      coalesce(t.approved_suggestions_count, 0) as approved_suggestions_count,
      coalesce(rv.reviews_count, 0) as reviews_count,
      coalesce(rv.approved_reviews_count, 0) as approved_reviews_count,
      coalesce(b.badges_count, 0) as badges_count,
      coalesce(
        b.badges,
        '[]'::jsonb
      ) as badges,
      (
        coalesce(x.total_xp, 0)
        + (coalesce(r.reputation_score, 0) * 4)
        + (coalesce(t.translations_count, 0) * 25)
        + (coalesce(rv.reviews_count, 0) * 15)
        + (coalesce(b.badges_count, 0) * 30)
      )::bigint as contribution_points,
      case
        when coalesce(rv.reviews_count, 0) = 0 then 0::numeric(5,2)
        else round(
          (coalesce(rv.approved_reviews_count, 0)::numeric / greatest(rv.reviews_count, 1)::numeric) * 100,
          2
        )::numeric(5,2)
      end as approval_rate
    from active_profiles ap
    cross join leaderboard_window lw
    left join xp_rows x on x.user_id = ap.user_id
    left join reputation_rows r on r.user_id = ap.user_id
    left join translation_rows t on t.user_id = ap.user_id
    left join review_rows rv on rv.user_id = ap.user_id
    left join badge_rows b on b.user_id = ap.user_id
    left join primary_languages pl on pl.user_id = ap.user_id
  ),
  translator_candidates as (
    select
      lb.*,
      (
        (lb.contribution_points * 2)
        + (lb.reputation_score * 12)
        + (lb.approved_suggestions_count * 55)
        + (round(lb.approval_rate)::bigint * 4)
      )::bigint as ranking_score
    from leaderboard_base lb
    where public.role_rank(lb.role) >= public.role_rank('translator')
       or coalesce(lb.translations_count, 0) > 0
       or coalesce(lb.approved_suggestions_count, 0) > 0
  ),
  reviewer_candidates as (
    select
      lb.*,
      (
        (lb.contribution_points * 2)
        + (lb.reputation_score * 12)
        + (lb.approved_reviews_count * 60)
        + (round(lb.approval_rate)::bigint * 4)
      )::bigint as ranking_score
    from leaderboard_base lb
    where public.role_rank(lb.role) >= public.role_rank('reviewer')
       or coalesce(lb.reviews_count, 0) > 0
       or coalesce(lb.approved_reviews_count, 0) > 0
  ),
  supporter_candidates as (
    select
      lb.*,
      (
        (lb.contribution_points * 2)
        + (lb.reputation_score * 10)
        + (lb.badges_count * 80)
      )::bigint as ranking_score
    from leaderboard_base lb
    where coalesce(lb.badges_count, 0) > 0
  ),
  translator_ranked as (
    select
      'translators'::text as leaderboard_kind,
      c.period,
      c.user_id,
      c.display_name,
      c.username,
      c.avatar_url,
      c.primary_language_code,
      c.primary_language_name,
      c.primary_language_native_name,
      c.primary_language_emoji,
      c.role,
      c.total_xp,
      c.reputation_score,
      c.contribution_points,
      c.translations_count,
      c.approved_suggestions_count,
      c.reviews_count,
      c.approved_reviews_count,
      c.badges_count,
      c.approval_rate,
      c.ranking_score,
      dense_rank() over (
        order by
          c.ranking_score desc,
          c.contribution_points desc,
          c.reputation_score desc,
          c.approved_suggestions_count desc,
          c.translations_count desc,
          c.user_id
      ) as rank,
      c.badges
    from translator_candidates c
  ),
  reviewer_ranked as (
    select
      'reviewers'::text as leaderboard_kind,
      c.period,
      c.user_id,
      c.display_name,
      c.username,
      c.avatar_url,
      c.primary_language_code,
      c.primary_language_name,
      c.primary_language_native_name,
      c.primary_language_emoji,
      c.role,
      c.total_xp,
      c.reputation_score,
      c.contribution_points,
      c.translations_count,
      c.approved_suggestions_count,
      c.reviews_count,
      c.approved_reviews_count,
      c.badges_count,
      c.approval_rate,
      c.ranking_score,
      dense_rank() over (
        order by
          c.ranking_score desc,
          c.contribution_points desc,
          c.reputation_score desc,
          c.approved_reviews_count desc,
          c.reviews_count desc,
          c.user_id
      ) as rank,
      c.badges
    from reviewer_candidates c
  ),
  supporter_ranked as (
    select
      'supporters'::text as leaderboard_kind,
      c.period,
      c.user_id,
      c.display_name,
      c.username,
      c.avatar_url,
      c.primary_language_code,
      c.primary_language_name,
      c.primary_language_native_name,
      c.primary_language_emoji,
      c.role,
      c.total_xp,
      c.reputation_score,
      c.contribution_points,
      c.translations_count,
      c.approved_suggestions_count,
      c.reviews_count,
      c.approved_reviews_count,
      c.badges_count,
      c.approval_rate,
      c.ranking_score,
      dense_rank() over (
        order by
          c.ranking_score desc,
          c.badges_count desc,
          c.contribution_points desc,
          c.reputation_score desc,
          c.user_id
      ) as rank,
      c.badges
    from supporter_candidates c
  )
  select *
  from translator_ranked
  where rank <= 10

  union all

  select *
  from reviewer_ranked
  where rank <= 10

  union all

  select *
  from supporter_ranked
  where rank <= 10

  order by leaderboard_kind, rank, display_name nulls last, username nulls last;
$$;

grant execute on function public.public_leaderboard_rankings(text) to anon, authenticated;

commit;
