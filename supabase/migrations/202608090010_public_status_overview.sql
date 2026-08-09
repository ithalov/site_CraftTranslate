begin;

create or replace function public.public_status_overview()
returns table (
  total_strings bigint,
  total_languages bigint,
  collaborators bigint,
  total_translations bigint,
  total_reviews bigint,
  translated_percent numeric(5,2),
  reviewed_percent numeric(5,2),
  official_percent numeric(5,2)
)
language sql
stable
security definer
set search_path = public, auth
as $$
  with strings_total as (
    select count(*)::bigint as total_strings
    from public.translation_keys tk
  ),
  languages_total as (
    select count(*)::bigint as total_languages
    from public.languages l
    where l.is_active
  ),
  collaborators_total as (
    select count(*)::bigint as collaborators
    from public.public_profile_cards_view
  ),
  translation_total as (
    select count(*)::bigint as total_translations
    from public.translation_suggestions ts
  ),
  review_total as (
    select count(*)::bigint as total_reviews
    from public.reviews r
  ),
  translated_strings_total as (
    select count(distinct tk.id)::bigint as translated_strings
    from public.translation_keys tk
    where exists (
      select 1
      from public.translation_suggestions ts
      where ts.translation_key_id = tk.id
        and ts.target_language_id = tk.source_language_id
    )
  ),
  reviewed_strings_total as (
    select count(distinct tk.id)::bigint as reviewed_strings
    from public.translation_keys tk
    where exists (
      select 1
      from public.translation_suggestions ts
      join public.reviews r on r.translation_suggestion_id = ts.id
      where ts.translation_key_id = tk.id
        and ts.target_language_id = tk.source_language_id
    )
  ),
  approved_total as (
    select count(distinct tk.id)::bigint as approved_strings
    from public.translation_keys tk
    where exists (
      select 1
      from public.translation_suggestions ts
      where ts.translation_key_id = tk.id
        and ts.target_language_id = tk.source_language_id
        and ts.status = 'approved'
    )
  ),
  translated_pct as (
    select
      case
        when st.total_strings = 0 then 0::numeric(5,2)
        else round((ts.translated_strings::numeric / st.total_strings::numeric) * 100, 2)::numeric(5,2)
      end as translated_percent
    from strings_total st
    cross join translated_strings_total ts
  ),
  reviewed_pct as (
    select
      case
        when ts.translated_strings = 0 then 0::numeric(5,2)
        else round((rs.reviewed_strings::numeric / ts.translated_strings::numeric) * 100, 2)::numeric(5,2)
      end as reviewed_percent
    from translated_strings_total ts
    cross join reviewed_strings_total rs
  ),
  official_pct as (
    select
      case
        when st.total_strings = 0 then 0::numeric(5,2)
        else round((at.approved_strings::numeric / st.total_strings::numeric) * 100, 2)::numeric(5,2)
      end as official_percent
    from strings_total st
    cross join approved_total at
  )
  select
    st.total_strings,
    lt.total_languages,
    ct.collaborators,
    tt.total_translations,
    rt.total_reviews,
    tp.translated_percent,
    rp.reviewed_percent,
    op.official_percent
  from strings_total st
  cross join languages_total lt
  cross join collaborators_total ct
  cross join translation_total tt
  cross join review_total rt
  cross join translated_pct tp
  cross join reviewed_pct rp
  cross join official_pct op;
$$;

grant execute on function public.public_status_overview() to anon, authenticated;

create or replace function public.public_status_language_coverage()
returns table (
  language_id uuid,
  code text,
  name text,
  native_name text,
  emoji text,
  direction text,
  total_strings bigint,
  translated_count bigint,
  reviewed_count bigint,
  official_count bigint,
  translated_percent numeric(5,2),
  reviewed_percent numeric(5,2),
  official_percent numeric(5,2),
  active_translators bigint,
  active_reviewers bigint,
  active_moderators bigint
)
language sql
stable
security definer
set search_path = public, auth
as $$
  with translated_totals as (
    select
      tk.source_language_id as language_id,
      count(distinct tk.id) filter (where ts.id is not null)::bigint as translated_count,
      count(distinct tk.id) filter (where ts.status = 'approved')::bigint as official_count
    from public.translation_keys tk
    left join public.translation_suggestions ts
      on ts.translation_key_id = tk.id
     and ts.target_language_id = tk.source_language_id
    group by tk.source_language_id
  ),
  reviewed_totals as (
    select
      tk.source_language_id as language_id,
      count(distinct tk.id) filter (where r.id is not null)::bigint as reviewed_count
    from public.translation_keys tk
    left join public.translation_suggestions ts
      on ts.translation_key_id = tk.id
     and ts.target_language_id = tk.source_language_id
    left join public.reviews r
      on r.translation_suggestion_id = ts.id
    group by tk.source_language_id
  ),
  membership_totals as (
    select
      lm.language_id,
      count(*) filter (where lm.is_active and public.role_rank(lm.role::text) >= public.role_rank('translator'))::bigint as active_translators,
      count(*) filter (where lm.is_active and public.role_rank(lm.role::text) >= public.role_rank('reviewer'))::bigint as active_reviewers,
      count(*) filter (where lm.is_active and public.role_rank(lm.role::text) >= public.role_rank('language_moderator'))::bigint as active_moderators
    from public.language_members lm
    group by lm.language_id
  )
  select
    l.id as language_id,
    l.code,
    l.name,
    l.native_name,
    l.emoji,
    l.direction::text as direction,
    count(distinct tk.id)::bigint as total_strings,
    coalesce(tt.translated_count, 0) as translated_count,
    coalesce(rt.reviewed_count, 0) as reviewed_count,
    coalesce(tt.official_count, 0) as official_count,
    case
      when count(distinct tk.id) = 0 then 0::numeric(5,2)
      else round((coalesce(tt.translated_count, 0)::numeric / count(distinct tk.id)::numeric) * 100, 2)::numeric(5,2)
    end as translated_percent,
    case
      when coalesce(tt.translated_count, 0) = 0 then 0::numeric(5,2)
      else round((coalesce(rt.reviewed_count, 0)::numeric / greatest(tt.translated_count, 1)::numeric) * 100, 2)::numeric(5,2)
    end as reviewed_percent,
    case
      when count(distinct tk.id) = 0 then 0::numeric(5,2)
      else round((coalesce(tt.official_count, 0)::numeric / count(distinct tk.id)::numeric) * 100, 2)::numeric(5,2)
    end as official_percent,
    coalesce(mt.active_translators, 0) as active_translators,
    coalesce(mt.active_reviewers, 0) as active_reviewers,
    coalesce(mt.active_moderators, 0) as active_moderators
  from public.languages l
  left join public.translation_keys tk on tk.source_language_id = l.id
  left join translated_totals tt on tt.language_id = l.id
  left join reviewed_totals rt on rt.language_id = l.id
  left join membership_totals mt on mt.language_id = l.id
  where l.is_active
  group by
    l.id,
    l.code,
    l.name,
    l.native_name,
    l.emoji,
    l.direction,
    tt.translated_count,
    tt.official_count,
    rt.reviewed_count,
    mt.active_translators,
    mt.active_reviewers,
    mt.active_moderators
  order by l.sort_order asc, l.name asc;
$$;

grant execute on function public.public_status_language_coverage() to anon, authenticated;

commit;
