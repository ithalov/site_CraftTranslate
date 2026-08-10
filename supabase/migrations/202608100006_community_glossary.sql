begin;

drop function if exists public.public_language_glossary(text);

alter table public.glossary
  add column if not exists original_term text,
  add column if not exists recommended_translation text,
  add column if not exists rule text,
  add column if not exists notes text,
  add column if not exists do_not_translate boolean not null default false;

update public.glossary
set
  original_term = coalesce(nullif(trim(original_term), ''), term),
  recommended_translation = coalesce(nullif(trim(recommended_translation), ''), definition),
  rule = nullif(trim(rule), ''),
  notes = nullif(trim(notes), '')
where original_term is null
   or recommended_translation is null
   or rule is null
   or notes is null;

create or replace function public.public_language_glossary(language_code text)
returns table (
  language_id uuid,
  code text,
  name text,
  native_name text,
  id uuid,
  term text,
  original_term text,
  recommended_translation text,
  category text,
  subcategory text,
  rule text,
  notes text,
  do_not_translate boolean,
  aliases text[],
  tags text[],
  definition text,
  status text,
  created_at timestamptz,
  updated_at timestamptz
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
      l.native_name
    from public.languages l
    where l.is_active
      and lower(l.code) = lower(trim(coalesce(language_code, '')))
    limit 1
  )
  select
    g.language_id,
    sl.code,
    sl.name,
    sl.native_name,
    g.id,
    g.term,
    coalesce(nullif(trim(g.original_term), ''), g.term) as original_term,
    coalesce(nullif(trim(g.recommended_translation), ''), g.definition) as recommended_translation,
    g.category,
    g.subcategory,
    nullif(trim(g.rule), '') as rule,
    nullif(trim(g.notes), '') as notes,
    coalesce(g.do_not_translate, false) as do_not_translate,
    coalesce(g.aliases, '{}'::text[]) as aliases,
    coalesce(g.tags, '{}'::text[]) as tags,
    g.definition,
    g.status::text as status,
    g.created_at,
    g.updated_at
  from public.glossary g
  join selected_language sl on sl.id = g.language_id
  where g.status = 'approved'
  order by
    g.do_not_translate desc,
    g.category asc,
    g.subcategory asc nulls last,
    g.term asc;
$$;

grant execute on function public.public_language_glossary(text) to authenticated;

insert into public.glossary (
  language_id,
  term,
  original_term,
  definition,
  recommended_translation,
  category,
  rule,
  notes,
  do_not_translate,
  aliases,
  tags,
  status
)
select
  l.id,
  seed.term,
  seed.original_term,
  seed.recommended_translation,
  seed.recommended_translation,
  seed.category,
  seed.rule,
  seed.notes,
  seed.do_not_translate,
  seed.aliases,
  seed.tags,
  'approved'
from public.languages l
join (
  values
    ('pt-BR', 'Party', 'Party', 'Grupo', 'community', 'Use when the term refers to a party or player group.', 'Social gameplay term. Preserve the group meaning.', false, array['party', 'party group']::text[], array['community']::text[]),
    ('pt-BR', 'Guild', 'Guild', 'Guilda', 'community', 'Use when the term refers to a guild or player organization.', 'Social gameplay term. Preserve the organization name.', false, array['guild', 'clan']::text[], array['community']::text[]),
    ('pt-BR', 'XP', 'XP', 'XP', 'system_messages', 'Do not translate experience abbreviations.', 'Technical progression term. Preserve exactly as XP.', true, array['experience', 'exp']::text[], array['system_messages', 'progression']::text[]),
    ('pt-BR', 'TPS', 'TPS', 'TPS', 'system_messages', 'Do not translate server performance abbreviations.', 'Technical term. Preserve exactly as TPS.', true, array['ticks per second']::text[], array['system_messages', 'server']::text[])
) as seed(
  language_code,
  term,
  original_term,
  recommended_translation,
  category,
  rule,
  notes,
  do_not_translate,
  aliases,
  tags
) on seed.language_code = l.code
where not exists (
  select 1
  from public.glossary g
  where g.language_id = l.id
    and g.term = seed.term
);

commit;
