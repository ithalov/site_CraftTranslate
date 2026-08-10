begin;

drop function if exists public.public_language_page(text);

create or replace function public.public_language_page(language_code text)
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
  collaborators_count bigint,
  active_translators bigint,
  active_reviewers bigint,
  active_moderators bigint,
  translation_keys bigint,
  translation_suggestions bigint,
  approved_suggestions bigint,
  glossary_terms bigint,
  glossary_proposals bigint,
  lead_member jsonb,
  team_sections jsonb,
  reviewers jsonb,
  team_members jsonb,
  top_contributors jsonb,
  categories jsonb
)
language sql
stable
security definer
set search_path = public, auth
as $$
  with selected_language as (
    select
      l.id,
      l.code,
      l.name,
      l.native_name,
      l.emoji,
      l.direction
    from public.languages l
    where l.is_active
      and lower(l.code) = lower(trim(coalesce(language_code, '')))
    limit 1
  ),
  coverage as (
    select
      c.*
    from public.public_language_catalog() c
    join selected_language sl on sl.id = c.language_id
  ),
  collaborators as (
    select
      lm.language_id,
      count(distinct lm.user_id)::bigint as collaborators_count
    from public.language_members lm
    join selected_language sl on sl.id = lm.language_id
    where lm.is_active
    group by lm.language_id
  ),
  member_rows as (
    select
      lm.language_id,
      lm.user_id,
      lm.role::text as role,
      lm.contribution_score,
      lm.joined_at,
      p.display_name,
      p.username,
      p.avatar_url,
      p.bio,
      coalesce(ul.proficiency::text, 'beginner') as proficiency,
      coalesce(ul.is_primary, false) as is_primary,
      coalesce(ul.is_native, false) as is_native,
      coalesce(ul.is_learning, false) as is_learning,
      jsonb_build_object(
        'user_id', lm.user_id,
        'display_name', p.display_name,
        'username', p.username,
        'avatar_url', p.avatar_url,
        'bio', p.bio,
        'role', lm.role::text,
        'contribution_score', lm.contribution_score,
        'joined_at', lm.joined_at,
        'proficiency', coalesce(ul.proficiency::text, 'beginner'),
        'is_primary', coalesce(ul.is_primary, false),
        'is_native', coalesce(ul.is_native, false),
        'is_learning', coalesce(ul.is_learning, false)
      ) as member_payload,
      row_number() over (
        order by
          case
            when lm.role = 'language_moderator' then 5
            when lm.role = 'reviewer' then 4
            when lm.role = 'trusted_translator' then 3
            when lm.role = 'translator' then 2
            else 1
          end desc,
          lm.contribution_score desc,
          lm.joined_at asc,
          coalesce(p.display_name, p.username, p.user_id::text) asc
      ) as member_rank
    from public.language_members lm
    join selected_language sl on sl.id = lm.language_id
    join public.profiles p on p.user_id = lm.user_id
    left join public.user_languages ul
      on ul.user_id = lm.user_id
     and ul.language_id = lm.language_id
    where lm.is_active
  ),
  lead_member as (
    select mr.member_payload as lead_member
    from member_rows mr
    where mr.member_rank = 1
    limit 1
  ),
  translator_members as (
    select
      coalesce(
        jsonb_agg(mr.member_payload order by mr.contribution_score desc, mr.joined_at asc, mr.member_rank asc),
        '[]'::jsonb
      ) as members,
      count(*)::bigint as member_count
    from member_rows mr
    where mr.role = 'translator'
  ),
  trusted_translator_members as (
    select
      coalesce(
        jsonb_agg(mr.member_payload order by mr.contribution_score desc, mr.joined_at asc, mr.member_rank asc),
        '[]'::jsonb
      ) as members,
      count(*)::bigint as member_count
    from member_rows mr
    where mr.role = 'trusted_translator'
  ),
  reviewer_members as (
    select
      coalesce(
        jsonb_agg(mr.member_payload order by mr.contribution_score desc, mr.joined_at asc, mr.member_rank asc),
        '[]'::jsonb
      ) as members,
      count(*)::bigint as member_count
    from member_rows mr
    where mr.role = 'reviewer'
  ),
  moderator_members as (
    select
      coalesce(
        jsonb_agg(mr.member_payload order by mr.contribution_score desc, mr.joined_at asc, mr.member_rank asc),
        '[]'::jsonb
      ) as members,
      count(*)::bigint as member_count
    from member_rows mr
    where mr.role = 'language_moderator'
  ),
  team_sections as (
    select jsonb_build_array(
      jsonb_build_object(
        'role', 'translator',
        'count', tm.member_count,
        'members', tm.members
      ),
      jsonb_build_object(
        'role', 'trusted_translator',
        'count', ttm.member_count,
        'members', ttm.members
      ),
      jsonb_build_object(
        'role', 'reviewer',
        'count', rm.member_count,
        'members', rm.members
      ),
      jsonb_build_object(
        'role', 'language_moderator',
        'count', mm.member_count,
        'members', mm.members
      )
    ) as team_sections
    from translator_members tm
    cross join trusted_translator_members ttm
    cross join reviewer_members rm
    cross join moderator_members mm
  ),
  team_members as (
    select
      coalesce(
        jsonb_agg(
          mr.member_payload
          order by mr.member_rank asc
        ) filter (where mr.member_rank <= 12),
        '[]'::jsonb
      ) as team_members
    from member_rows mr
  ),
  top_contributors as (
    select
      coalesce(
        jsonb_agg(
          mr.member_payload
          order by mr.contribution_score desc, mr.member_rank asc
        ) filter (where mr.member_rank <= 5),
        '[]'::jsonb
      ) as top_contributors
    from member_rows mr
  )
  select
    c.language_id,
    c.code,
    c.name,
    c.native_name,
    c.emoji,
    c.direction,
    c.total_strings,
    c.translated_count,
    c.reviewed_count,
    c.official_count,
    c.translated_percent,
    c.reviewed_percent,
    c.official_percent,
    coalesce(col.collaborators_count, 0) as collaborators_count,
    c.active_translators,
    c.active_reviewers,
    c.active_moderators,
    c.translation_keys,
    c.translation_suggestions,
    c.approved_suggestions,
    c.glossary_terms,
    c.glossary_proposals,
    lm.lead_member,
    ts.team_sections,
    rv.members as reviewers,
    tm.team_members,
    tc.top_contributors,
    jsonb_build_array(
      jsonb_build_object(
        'slug', 'translations',
        'label', 'Translations',
        'value', c.translation_keys,
        'hint', 'Source strings tracked'
      ),
      jsonb_build_object(
        'slug', 'suggestions',
        'label', 'Suggestions',
        'value', c.translation_suggestions,
        'hint', 'Community proposals'
      ),
      jsonb_build_object(
        'slug', 'reviewed',
        'label', 'Reviewed',
        'value', c.reviewed_count,
        'hint', 'Quality checks completed'
      ),
      jsonb_build_object(
        'slug', 'glossary',
        'label', 'Glossary',
        'value', c.glossary_terms + c.glossary_proposals,
        'hint', 'Terminology coverage'
      )
    ) as categories
  from coverage c
  left join collaborators col on col.language_id = c.language_id
  left join lead_member lm on true
  left join team_sections ts on true
  left join reviewer_members rv on true
  left join team_members tm on true
  left join top_contributors tc on true;
$$;

grant execute on function public.public_language_page(text) to anon, authenticated;

commit;
