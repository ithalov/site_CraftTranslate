begin;

create or replace function public.public_profile_page(profile_handle text)
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
  contribution_points bigint,
  approval_rate numeric(5,2),
  badges_count bigint,
  languages_count bigint,
  translations_count bigint,
  reviews_count bigint,
  rank bigint,
  profile_state text,
  profile_level integer,
  functions jsonb,
  languages jsonb,
  badges jsonb
)
language sql
stable
security definer
set search_path = public, auth
as $$
  with profile_card as (
    select p.*
    from public.public_profile_cards() p
    where lower(coalesce(p.username, p.display_name, p.user_id::text)) = lower(profile_handle)
       or lower(regexp_replace(regexp_replace(coalesce(p.username, p.display_name, p.user_id::text), '[^a-zA-Z0-9]+', '-', 'g'), '^-+|-+$', '', 'g')) = lower(profile_handle)
       or p.user_id::text = profile_handle
    limit 1
  ),
  review_totals as (
    select
      r.reviewer_id as user_id,
      count(*)::bigint as reviews_count,
      count(*) filter (where r.decision = 'approve')::bigint as approved_reviews_count
    from public.reviews r
    group by r.reviewer_id
  ),
  language_rows as (
    select
      ul.user_id,
      jsonb_agg(
        jsonb_build_object(
          'language_id', ul.language_id,
          'code', l.code,
          'name', l.name,
          'native_name', l.native_name,
          'emoji', l.emoji,
          'proficiency', ul.proficiency::text,
          'is_primary', ul.is_primary,
          'is_native', ul.is_native,
          'is_learning', ul.is_learning
        )
        order by ul.is_primary desc, l.sort_order asc, l.name asc
      ) as languages
    from public.user_languages ul
    join public.languages l on l.id = ul.language_id
    where exists (
      select 1
      from profile_card pc
      where pc.user_id = ul.user_id
    )
    group by ul.user_id
  ),
  badge_rows as (
    select
      ub.user_id,
      jsonb_agg(
        jsonb_build_object(
          'badge_id', b.id,
          'slug', b.slug,
          'name', b.name,
          'description', b.description,
          'rarity', b.rarity::text,
          'icon', b.icon,
          'awarded_at', ub.awarded_at
        )
        order by ub.awarded_at desc, b.name asc
      ) as badges
    from public.user_badges ub
    join public.badges b on b.id = ub.badge_id
    where exists (
      select 1
      from profile_card pc
      where pc.user_id = ub.user_id
    )
    group by ub.user_id
  )
  select
    pc.user_id,
    pc.display_name,
    pc.username,
    pc.avatar_url,
    pc.bio,
    pc.role,
    pc.preferred_locale,
    pc.total_xp,
    pc.reputation_score,
    (
      pc.total_xp
      + (pc.reputation_score * 4)
      + (pc.translations_count * 25)
      + (pc.reviews_count * 15)
      + (pc.badges_count * 30)
    )::bigint as contribution_points,
    case
      when coalesce(rt.reviews_count, 0) = 0 then 0::numeric(5,2)
      else round(
        (coalesce(rt.approved_reviews_count, 0)::numeric / greatest(rt.reviews_count, 1)::numeric) * 100,
        2
      )::numeric(5,2)
    end as approval_rate,
    pc.badges_count,
    pc.languages_count,
    pc.translations_count,
    pc.reviews_count,
    pc.rank,
    case
      when public.role_rank(pc.role) >= public.role_rank('language_moderator') then 'moderator'
      when public.role_rank(pc.role) >= public.role_rank('reviewer') or coalesce(pc.reviews_count, 0) > 0 then 'reviewer'
      when public.role_rank(pc.role) >= public.role_rank('translator') or coalesce(pc.translations_count, 0) > 0 then 'translator'
      when coalesce(pc.badges_count, 0) > 0 then 'supporter'
      else 'new user'
    end as profile_state,
    greatest(
      1,
      floor(
        (
          pc.total_xp
          + (pc.reputation_score * 4)
          + (pc.translations_count * 25)
          + (pc.reviews_count * 15)
          + (pc.badges_count * 30)
        )::numeric / 250
      )::integer + 1
    ) as profile_level,
    to_jsonb(array_remove(array[
      case when public.role_rank(pc.role) >= public.role_rank('translator') or coalesce(pc.translations_count, 0) > 0 then 'translator' end,
      case when public.role_rank(pc.role) >= public.role_rank('reviewer') or coalesce(pc.reviews_count, 0) > 0 then 'reviewer' end,
      case when public.role_rank(pc.role) >= public.role_rank('language_moderator') then 'moderator' end,
      case when coalesce(pc.badges_count, 0) > 0 then 'supporter' end
    ], null)::text[]) as functions,
    coalesce(lr.languages, '[]'::jsonb) as languages,
    coalesce(br.badges, '[]'::jsonb) as badges
  from profile_card pc
  left join review_totals rt on rt.user_id = pc.user_id
  left join language_rows lr on lr.user_id = pc.user_id
  left join badge_rows br on br.user_id = pc.user_id;
$$;

grant execute on function public.public_profile_page(text) to anon, authenticated;

commit;
