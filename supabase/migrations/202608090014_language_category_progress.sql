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
  category_progress jsonb,
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
  key_base as (
    select
      tk.id,
      case
        when lower(regexp_replace(trim(coalesce(tk.category, '')), '\s+', '_', 'g')) in (
          'general',
          'minecraft',
          'pvp',
          'mmorpg',
          'economy',
          'trading',
          'commands',
          'system_messages',
          'mods'
        ) then lower(regexp_replace(trim(coalesce(tk.category, '')), '\s+', '_', 'g'))
        else 'other'
      end as category_slug,
      exists (
        select 1
        from public.translation_suggestions ts
        where ts.translation_key_id = tk.id
          and ts.target_language_id = tk.source_language_id
          and ts.status <> 'draft'
      ) as has_translation,
      exists (
        select 1
        from public.translation_suggestions ts
        join public.reviews r on r.translation_suggestion_id = ts.id
        where ts.translation_key_id = tk.id
          and ts.target_language_id = tk.source_language_id
      ) as has_review,
      exists (
        select 1
        from public.translation_suggestions ts
        where ts.translation_key_id = tk.id
          and ts.target_language_id = tk.source_language_id
          and ts.status = 'approved'
      ) as has_official
    from public.translation_keys tk
    join selected_language sl on sl.id = tk.source_language_id
  ),
  category_definitions as (
    select *
    from (
      values
        ('general'::text, 'General'::text, 1),
        ('minecraft'::text, 'Minecraft'::text, 2),
        ('pvp'::text, 'PvP'::text, 3),
        ('mmorpg'::text, 'MMORPG'::text, 4),
        ('economy'::text, 'Economy'::text, 5),
        ('trading'::text, 'Trading'::text, 6),
        ('commands'::text, 'Commands'::text, 7),
        ('system_messages'::text, 'System Messages'::text, 8),
        ('mods'::text, 'Mods'::text, 9),
        ('other'::text, 'Other'::text, 10)
    ) as category_definitions(slug, label, sort_order)
  ),
  category_progress as (
    select
      coalesce(
        jsonb_agg(
          jsonb_build_object(
            'slug', stats.slug,
            'label', stats.label,
            'total_strings', stats.total_strings,
            'translated_count', stats.translated_count,
            'reviewed_count', stats.reviewed_count,
            'official_count', stats.official_count,
            'translated_percent', stats.translated_percent,
            'reviewed_percent', stats.reviewed_percent,
            'official_percent', stats.official_percent,
            'has_open_work', stats.has_open_work
          )
          order by stats.sort_order asc
        ),
        '[]'::jsonb
      ) as category_progress
    from (
      select
        cd.slug,
        cd.label,
        cd.sort_order,
        count(kb.id)::bigint as total_strings,
        count(kb.id) filter (where kb.has_translation)::bigint as translated_count,
        count(kb.id) filter (where kb.has_review)::bigint as reviewed_count,
        count(kb.id) filter (where kb.has_official)::bigint as official_count,
        case
          when count(kb.id) = 0 then 0::numeric(5,2)
          else round((count(kb.id) filter (where kb.has_translation)::numeric / count(kb.id)::numeric) * 100, 2)::numeric(5,2)
        end as translated_percent,
        case
          when count(kb.id) = 0 then 0::numeric(5,2)
          else round((count(kb.id) filter (where kb.has_review)::numeric / count(kb.id)::numeric) * 100, 2)::numeric(5,2)
        end as reviewed_percent,
        case
          when count(kb.id) = 0 then 0::numeric(5,2)
          else round((count(kb.id) filter (where kb.has_official)::numeric / count(kb.id)::numeric) * 100, 2)::numeric(5,2)
        end as official_percent,
        case
          when count(kb.id) = 0 then false
          else count(kb.id) filter (where not kb.has_official)::int > 0
        end as has_open_work
      from category_definitions cd
      left join key_base kb on kb.category_slug = cd.slug
      group by cd.slug, cd.label, cd.sort_order
    ) stats
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
    cp.category_progress,
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
  left join category_progress cp on true
  left join team_sections ts on true
  left join reviewer_members rv on true
  left join team_members tm on true
  left join top_contributors tc on true;
$$;

grant execute on function public.public_language_page(text) to anon, authenticated;

commit;
