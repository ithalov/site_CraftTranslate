begin;

create or replace function public.public_profile_cards()
returns table (
  user_id uuid,
  display_name text,
  username text,
  avatar_url text,
  bio text,
  role text,
  preferred_locale text,
  total_xp bigint,
  reputation_score bigint,
  badges_count bigint,
  languages_count bigint,
  translations_count bigint,
  reviews_count bigint,
  rank bigint
)
language sql
stable
security definer
set search_path = public, auth
as $$
  with xp_totals as (
    select
      xe.user_id,
      coalesce(sum(xe.xp_delta), 0)::bigint as total_xp
    from public.xp_events xe
    group by xe.user_id
  ),
  reputation_totals as (
    select
      re.user_id,
      coalesce(sum(re.delta), 0)::bigint as reputation_score
    from public.reputation_events re
    group by re.user_id
  ),
  badge_totals as (
    select
      ub.user_id,
      count(*)::bigint as badges_count
    from public.user_badges ub
    group by ub.user_id
  ),
  language_totals as (
    select
      lm.user_id,
      count(distinct lm.language_id)::bigint as languages_count
    from public.language_members lm
    where lm.is_active
    group by lm.user_id
  ),
  translation_totals as (
    select
      tk.created_by as user_id,
      count(*)::bigint as translations_count
    from public.translation_keys tk
    where tk.created_by is not null
    group by tk.created_by
  ),
  review_totals as (
    select
      r.reviewer_id as user_id,
      count(*)::bigint as reviews_count
    from public.reviews r
    group by r.reviewer_id
  )
  select
    p.user_id,
    p.display_name,
    p.username,
    p.avatar_url,
    p.bio,
    p.role::text as role,
    p.preferred_locale,
    coalesce(x.total_xp, 0) as total_xp,
    coalesce(r.reputation_score, 0) as reputation_score,
    coalesce(b.badges_count, 0) as badges_count,
    coalesce(l.languages_count, 0) as languages_count,
    coalesce(t.translations_count, 0) as translations_count,
    coalesce(rv.reviews_count, 0) as reviews_count,
    dense_rank() over (
      order by
        coalesce(x.total_xp, 0) desc,
        coalesce(r.reputation_score, 0) desc,
        coalesce(t.translations_count, 0) desc,
        coalesce(rv.reviews_count, 0) desc,
        p.user_id
    ) as rank
  from public.profiles p
  left join xp_totals x on x.user_id = p.user_id
  left join reputation_totals r on r.user_id = p.user_id
  left join badge_totals b on b.user_id = p.user_id
  left join language_totals l on l.user_id = p.user_id
  left join translation_totals t on t.user_id = p.user_id
  left join review_totals rv on rv.user_id = p.user_id
  where p.display_name is not null or p.username is not null;
$$;

create or replace view public.public_profile_cards_view
with (security_invoker = false, security_barrier = true)
as
select * from public.public_profile_cards();

create or replace function public.public_leaderboard()
returns table (
  user_id uuid,
  display_name text,
  username text,
  avatar_url text,
  role text,
  total_xp bigint,
  reputation_score bigint,
  badges_count bigint,
  translations_count bigint,
  reviews_count bigint,
  rank bigint
)
language sql
stable
security definer
set search_path = public, auth
as $$
  select
    user_id,
    display_name,
    username,
    avatar_url,
    role,
    total_xp,
    reputation_score,
    badges_count,
    translations_count,
    reviews_count,
    rank
  from public.public_profile_cards()
  order by rank, display_name nulls last, username nulls last;
$$;

create or replace view public.public_leaderboard_view
with (security_invoker = false, security_barrier = true)
as
select * from public.public_leaderboard();

create or replace function public.public_language_progress()
returns table (
  language_id uuid,
  code text,
  name text,
  native_name text,
  direction text,
  emoji text,
  active_translators bigint,
  active_reviewers bigint,
  active_moderators bigint,
  translation_keys bigint,
  translation_suggestions bigint,
  approved_suggestions bigint,
  glossary_terms bigint,
  glossary_proposals bigint,
  progress_percent numeric(5,2)
)
language sql
stable
security definer
set search_path = public, auth
as $$
  with membership_totals as (
    select
      lm.language_id,
      count(*) filter (where lm.is_active and public.role_rank(lm.role::text) >= public.role_rank('translator'))::bigint as active_translators,
      count(*) filter (where lm.is_active and public.role_rank(lm.role::text) >= public.role_rank('reviewer'))::bigint as active_reviewers,
      count(*) filter (where lm.is_active and public.role_rank(lm.role::text) >= public.role_rank('language_moderator'))::bigint as active_moderators
    from public.language_members lm
    group by lm.language_id
  ),
  key_totals as (
    select
      tk.source_language_id as language_id,
      count(*)::bigint as translation_keys
    from public.translation_keys tk
    group by tk.source_language_id
  ),
  suggestion_totals as (
    select
      ts.target_language_id as language_id,
      count(*)::bigint as translation_suggestions,
      count(*) filter (where ts.status = 'approved')::bigint as approved_suggestions
    from public.translation_suggestions ts
    group by ts.target_language_id
  ),
  glossary_totals as (
    select
      g.language_id,
      count(*)::bigint as glossary_terms
    from public.glossary g
    group by g.language_id
  ),
  glossary_proposal_totals as (
    select
      gp.language_id,
      count(*)::bigint as glossary_proposals
    from public.glossary_proposals gp
    group by gp.language_id
  )
  select
    l.id as language_id,
    l.code,
    l.name,
    l.native_name,
    l.direction::text as direction,
    l.emoji,
    coalesce(m.active_translators, 0) as active_translators,
    coalesce(m.active_reviewers, 0) as active_reviewers,
    coalesce(m.active_moderators, 0) as active_moderators,
    coalesce(k.translation_keys, 0) as translation_keys,
    coalesce(s.translation_suggestions, 0) as translation_suggestions,
    coalesce(s.approved_suggestions, 0) as approved_suggestions,
    coalesce(g.glossary_terms, 0) as glossary_terms,
    coalesce(gp.glossary_proposals, 0) as glossary_proposals,
    case
      when coalesce(k.translation_keys, 0) = 0 then 0::numeric(5,2)
      else round(
        (coalesce(s.approved_suggestions, 0)::numeric / greatest(k.translation_keys, 1)::numeric) * 100,
        2
      )::numeric(5,2)
    end as progress_percent
  from public.languages l
  left join membership_totals m on m.language_id = l.id
  left join key_totals k on k.language_id = l.id
  left join suggestion_totals s on s.language_id = l.id
  left join glossary_totals g on g.language_id = l.id
  left join glossary_proposal_totals gp on gp.language_id = l.id
  where l.is_active
  order by l.sort_order asc, l.name asc;
$$;

create or replace view public.public_language_progress_view
with (security_invoker = false, security_barrier = true)
as
select * from public.public_language_progress();

grant select on public.public_profile_cards_view to anon, authenticated;
grant select on public.public_leaderboard_view to anon, authenticated;
grant select on public.public_language_progress_view to anon, authenticated;

commit;
