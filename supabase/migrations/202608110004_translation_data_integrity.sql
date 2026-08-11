-- ChatTranslate: persistent translations, unified progress, and export-ready data.
-- Safe to run after the previous workspace migrations. It never deletes translations.

begin;

alter table public.translation_keys
  add column if not exists source_version integer not null default 1;

update public.translation_keys
set source_version = greatest(coalesce(latest_version, 1), 1)
where source_version is null
   or source_version < 1
   or (source_version = 1 and coalesce(latest_version, 1) > 1);

alter table public.translation_keys
  drop constraint if exists translation_keys_source_version_positive;
alter table public.translation_keys
  add constraint translation_keys_source_version_positive check (source_version >= 1);

alter table public.translation_suggestions
  add column if not exists source_version integer not null default 1;

update public.translation_suggestions ts
set source_version = tk.source_version
from public.translation_keys tk
where tk.id = ts.translation_key_id
  and (ts.source_version is null or ts.source_version < 1);

alter table public.translation_suggestions
  drop constraint if exists translation_suggestions_source_version_positive;
alter table public.translation_suggestions
  add constraint translation_suggestions_source_version_positive check (source_version >= 1);

create index if not exists translation_suggestions_current_source_idx
  on public.translation_suggestions (translation_key_id, target_language_id, source_version, status, created_at desc);

-- A key/language/source version can have only one current official translation.
create unique index if not exists translation_suggestions_one_official_per_source_idx
  on public.translation_suggestions (translation_key_id, target_language_id, source_version)
  where status = 'official';

create or replace function public.bump_translation_key_source_version()
returns trigger
language plpgsql
set search_path = public
as $$
begin
  if new.original_text is distinct from old.original_text then
    new.source_version := greatest(coalesce(old.source_version, 1), 1) + 1;
    new.latest_version := greatest(coalesce(old.latest_version, 1), new.source_version);
    new.current_suggestion_id := null;
  end if;

  return new;
end;
$$;

drop trigger if exists bump_translation_key_source_version on public.translation_keys;
create trigger bump_translation_key_source_version
before update of original_text on public.translation_keys
for each row execute function public.bump_translation_key_source_version();

-- Shared, aggregate-only state for every key and target language.
create or replace view public.translation_progress
with (security_invoker = true)
as
with eligible_pairs as (
  select
    tk.id as translation_key_id,
    tk.source_version,
    tk.category,
    l.id as target_language_id
  from public.translation_keys tk
  cross join public.languages l
  where tk.status = 'active'
    and l.is_active
    and (
      coalesce(array_length(tk.supported_targets, 1), 0) = 0
      or exists (
        select 1
        from unnest(tk.supported_targets) as target(value)
        where lower(trim(target.value)) = lower(l.code)
      )
    )
), suggestion_state as (
  select
    ts.translation_key_id,
    ts.target_language_id,
    ts.source_version,
    bool_or(ts.status in ('pending', 'reviewing', 'needs_changes', 'approved', 'official')) as is_translated,
    bool_or(ts.status in ('approved', 'official')) as is_reviewed,
    bool_or(ts.status = 'official') as is_official,
    case
      when bool_or(ts.status = 'official') then 'official'
      when bool_or(ts.status = 'approved') then 'approved'
      when bool_or(ts.status = 'reviewing') then 'reviewing'
      when bool_or(ts.status = 'needs_changes') then 'needs_changes'
      when bool_or(ts.status = 'pending') then 'pending'
      else 'untranslated'
    end as translation_status
  from public.translation_suggestions ts
  group by ts.translation_key_id, ts.target_language_id, ts.source_version
)
select
  ep.translation_key_id,
  ep.target_language_id,
  ep.source_version,
  ep.category,
  coalesce(ss.translation_status, 'untranslated') as translation_status,
  coalesce(ss.is_translated, false) as is_translated,
  coalesce(ss.is_reviewed, false) as is_reviewed,
  coalesce(ss.is_official, false) as is_official
from eligible_pairs ep
left join suggestion_state ss
  on ss.translation_key_id = ep.translation_key_id
 and ss.target_language_id = ep.target_language_id
 and ss.source_version = ep.source_version;

create or replace view public.language_translation_stats
with (security_invoker = true)
as
select
  l.id as language_id,
  count(tp.translation_key_id)::bigint as total_strings,
  count(*) filter (where tp.is_translated)::bigint as translated_strings,
  count(*) filter (where tp.is_reviewed)::bigint as reviewed_strings,
  count(*) filter (where tp.is_official)::bigint as official_strings,
  count(*) filter (where not tp.is_translated)::bigint as untranslated_strings,
  case when count(*) = 0 then 0::numeric(5,2) else round(count(*) filter (where tp.is_translated)::numeric * 100 / count(*), 2)::numeric(5,2) end as translated_percent,
  case when count(*) = 0 then 0::numeric(5,2) else round(count(*) filter (where tp.is_reviewed)::numeric * 100 / count(*), 2)::numeric(5,2) end as reviewed_percent,
  case when count(*) = 0 then 0::numeric(5,2) else round(count(*) filter (where tp.is_official)::numeric * 100 / count(*), 2)::numeric(5,2) end as official_percent
from public.languages l
left join public.translation_progress tp on tp.target_language_id = l.id
where l.is_active
group by l.id;

create or replace view public.category_translation_stats
with (security_invoker = true)
as
select
  tp.target_language_id as language_id,
  lower(regexp_replace(trim(coalesce(tp.category, 'general')), '\\s+', '_', 'g')) as category,
  count(*)::bigint as total_strings,
  count(*) filter (where tp.is_translated)::bigint as translated_strings,
  count(*) filter (where tp.is_reviewed)::bigint as reviewed_strings,
  count(*) filter (where tp.is_official)::bigint as official_strings,
  case when count(*) = 0 then 0::numeric(5,2) else round(count(*) filter (where tp.is_translated)::numeric * 100 / count(*), 2)::numeric(5,2) end as translated_percent,
  case when count(*) = 0 then 0::numeric(5,2) else round(count(*) filter (where tp.is_reviewed)::numeric * 100 / count(*), 2)::numeric(5,2) end as reviewed_percent,
  case when count(*) = 0 then 0::numeric(5,2) else round(count(*) filter (where tp.is_official)::numeric * 100 / count(*), 2)::numeric(5,2) end as official_percent
from public.translation_progress tp
group by tp.target_language_id, lower(regexp_replace(trim(coalesce(tp.category, 'general')), '\\s+', '_', 'g'));

-- This view is intentionally not granted to anon. It is the future export source for the mod.
create or replace view public.official_translations
with (security_invoker = true)
as
select
  ts.translation_key_id,
  tk.key_name,
  tk.original_text as source_text,
  tk.source_version,
  l.code as target_language_code,
  ts.suggestion_text as translated_text,
  tk.category,
  tk.subcategory,
  tk.context,
  tk.protected_variables,
  tk.protected_terms,
  ts.updated_at as approved_at
from public.translation_suggestions ts
join public.translation_keys tk on tk.id = ts.translation_key_id
join public.languages l on l.id = ts.target_language_id
where ts.status = 'official'
  and ts.source_version = tk.source_version;

revoke all on public.translation_progress, public.language_translation_stats, public.category_translation_stats, public.official_translations from anon;
grant select on public.translation_progress, public.language_translation_stats, public.category_translation_stats to authenticated;

drop function if exists public.translation_workspace_submit(uuid, text, text, text, text, uuid);
create function public.translation_workspace_submit(
  p_translation_key_id uuid,
  p_target_language_code text,
  p_suggestion_text text,
  p_rationale text default null,
  p_notes text default null,
  p_supersedes_suggestion_id uuid default null
)
returns table (suggestion_id uuid, version_number integer, status text, created_at timestamptz)
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  v_target_language_id uuid;
  v_target_language_code text;
  v_source_version integer;
  v_version_number integer;
  v_suggestion_id uuid;
  v_clean_text text;
  v_source_text text;
  v_required_tokens text[];
  v_translation_tokens text[];
begin
  if auth.uid() is null then
    raise exception 'Authentication required';
  end if;

  v_clean_text := trim(coalesce(p_suggestion_text, ''));
  if v_clean_text = '' then
    raise exception 'Nao foi possivel salvar sua traducao: texto vazio.';
  end if;

  select l.id, l.code into v_target_language_id, v_target_language_code
  from public.languages l
  where l.is_active
    and lower(l.code) = lower(trim(coalesce(p_target_language_code, '')))
    and public.can_translate_language(l.id)
  limit 1;

  if v_target_language_id is null then
    raise exception 'Voce nao tem permissao para traduzir este idioma.';
  end if;

  select tk.original_text, tk.source_version
    into v_source_text, v_source_version
  from public.translation_keys tk
  where tk.id = p_translation_key_id
    and tk.status = 'active'
    and (
      coalesce(array_length(tk.supported_targets, 1), 0) = 0
      or exists (
        select 1 from unnest(tk.supported_targets) as target(value)
        where lower(trim(target.value)) = lower(v_target_language_code)
      )
    );

  if v_source_version is null then
    raise exception 'A string original foi alterada ou nao esta disponivel. Recarregue a fila.';
  end if;

  select coalesce(array_agg((match)[1] order by (match)[1]), '{}'::text[])
    into v_required_tokens
  from regexp_matches(v_source_text, '(\\{[A-Za-z0-9_]+\\}|%[sd])', 'g') as match;
  select coalesce(array_agg((match)[1] order by (match)[1]), '{}'::text[])
    into v_translation_tokens
  from regexp_matches(v_clean_text, '(\\{[A-Za-z0-9_]+\\}|%[sd])', 'g') as match;

  if v_required_tokens is distinct from v_translation_tokens then
    raise exception 'Um placeholder obrigatorio esta faltando ou foi alterado: esperado %.', v_required_tokens;
  end if;

  -- Serializes submissions for this key/language, including fast double clicks.
  perform pg_advisory_xact_lock(hashtext(p_translation_key_id::text || ':' || v_target_language_id::text));

  if exists (
    select 1
    from public.translation_suggestions ts
    where ts.translation_key_id = p_translation_key_id
      and ts.target_language_id = v_target_language_id
      and ts.author_id = auth.uid()
      and ts.source_version = v_source_version
      and ts.status in ('pending', 'reviewing', 'needs_changes', 'approved', 'official')
      and lower(regexp_replace(trim(ts.suggestion_text), '\\s+', ' ', 'g')) = lower(regexp_replace(v_clean_text, '\\s+', ' ', 'g'))
  ) then
    raise exception 'Essa string ja possui uma contribuicao identica sua.';
  end if;

  if p_supersedes_suggestion_id is not null and not exists (
    select 1 from public.translation_suggestions ts
    where ts.id = p_supersedes_suggestion_id
      and ts.translation_key_id = p_translation_key_id
      and ts.target_language_id = v_target_language_id
  ) then
    raise exception 'A sugestao base nao pertence a esta string.';
  end if;

  select coalesce(max(ts.version_number), 0) + 1 into v_version_number
  from public.translation_suggestions ts
  where ts.translation_key_id = p_translation_key_id
    and ts.target_language_id = v_target_language_id;

  insert into public.translation_suggestions (
    translation_key_id, target_language_id, author_id, source_version, version_number,
    suggestion_text, rationale, notes, supersedes_suggestion_id, status
  ) values (
    p_translation_key_id, v_target_language_id, auth.uid(), v_source_version, v_version_number,
    v_clean_text, nullif(trim(coalesce(p_rationale, '')), ''), nullif(trim(coalesce(p_notes, '')), ''),
    p_supersedes_suggestion_id, 'pending'
  ) returning id into v_suggestion_id;

  update public.translation_keys
  set current_suggestion_id = v_suggestion_id, updated_by = auth.uid(), updated_at = timezone('utc', now())
  where id = p_translation_key_id;

  insert into public.xp_events (user_id, actor_id, event_type, source_table, source_id, xp_delta, reason)
  values (auth.uid(), auth.uid(), 'translation_created', 'translation_suggestions', v_suggestion_id, 1, 'Translation submitted')
  on conflict do nothing;

  insert into public.reputation_events (user_id, actor_id, event_type, source_table, source_id, delta, reason)
  values (auth.uid(), auth.uid(), 'translation_created', 'translation_suggestions', v_suggestion_id, 1, 'Translation submitted')
  on conflict do nothing;

  return query select v_suggestion_id, v_version_number, 'pending'::text, timezone('utc', now());
end;
$$;
grant execute on function public.translation_workspace_submit(uuid, text, text, text, text, uuid) to authenticated;

drop function if exists public.translation_workspace_session(text, text, integer, integer, uuid);
create function public.translation_workspace_session(
  p_target_language_code text default null,
  p_category_slug text default null,
  p_batch_size integer default 10,
  p_session_offset integer default 0,
  p_viewer_user_id uuid default null
)
returns table (
  session_id uuid, target_language_id uuid, target_language_code text, target_language_name text,
  target_language_native_name text, target_language_emoji text, category_slug text,
  total_available bigint, loaded_count bigint, batch_size integer, session_offset integer,
  has_more boolean, items json
)
language sql
stable
security definer
set search_path = public, auth
as $$
  with params as (
    select greatest(1, least(coalesce(p_batch_size, 10), 20)) as batch_size,
      greatest(0, coalesce(p_session_offset, 0)) as session_offset,
      lower(trim(coalesce(p_category_slug, 'all'))) as category_slug,
      coalesce(p_viewer_user_id::text, auth.uid()::text, 'guest') as viewer_seed
  ), target as (
    select l.id, l.code, l.name, l.native_name, l.emoji
    from public.languages l
    where l.is_active and lower(l.code) = lower(trim(coalesce(p_target_language_code, '')))
      and public.can_translate_language(l.id)
    limit 1
  ), candidates as (
    select tk.id, tk.key_name, tk.original_text, tk.category, tk.subcategory, tk.context,
      tk.protected_variables, tk.protected_terms, tk.source_language_id, tk.source_version,
      sl.code as source_language_code, sl.name as source_language_name, sl.native_name as source_language_native_name, sl.emoji as source_language_emoji,
      t.id as target_language_id, t.code as target_language_code, t.name as target_language_name, t.native_name as target_language_native_name, t.emoji as target_language_emoji,
      row_number() over (order by md5(params.viewer_seed || ':' || t.code || ':' || tk.id::text), tk.id) as queue_rank
    from public.translation_keys tk
    join target t on true
    join public.languages sl on sl.id = tk.source_language_id
    cross join params
    where tk.status = 'active'
      and (params.category_slug in ('', 'all', 'general') or lower(regexp_replace(trim(tk.category), '\\s+', '_', 'g')) = params.category_slug)
      and (coalesce(array_length(tk.supported_targets, 1), 0) = 0 or exists (select 1 from unnest(tk.supported_targets) as supported(value) where lower(trim(supported.value)) = lower(t.code)))
      and not exists (
        select 1 from public.translation_suggestions mine
        where mine.translation_key_id = tk.id and mine.target_language_id = t.id
          and mine.author_id = auth.uid() and mine.source_version = tk.source_version
          and mine.status in ('pending', 'reviewing', 'approved', 'official')
      )
      and not exists (
        select 1 from public.translation_suggestions official
        where official.translation_key_id = tk.id and official.target_language_id = t.id
          and official.source_version = tk.source_version and official.status = 'official'
      )
  ), batch as (
    select c.* from candidates c cross join params order by c.queue_rank limit (select batch_size from params) offset (select session_offset from params)
  )
  select gen_random_uuid(), t.id, t.code, t.name, t.native_name, t.emoji, params.category_slug,
    (select count(*) from candidates)::bigint, count(b.id)::bigint, params.batch_size, params.session_offset,
    (select count(*) from candidates) > params.session_offset + count(b.id),
    coalesce(jsonb_agg(jsonb_build_object(
      'translation_key_id', b.id, 'key_name', b.key_name, 'original_text', b.original_text,
      'category', b.category, 'subcategory', b.subcategory, 'context', b.context,
      'protected_variables', b.protected_variables, 'protected_terms', b.protected_terms,
      'source_language_id', b.source_language_id, 'source_language_code', b.source_language_code,
      'source_language_name', b.source_language_name, 'source_language_native_name', b.source_language_native_name,
      'source_language_emoji', b.source_language_emoji, 'target_language_id', b.target_language_id,
      'target_language_code', b.target_language_code, 'target_language_name', b.target_language_name,
      'target_language_native_name', b.target_language_native_name, 'target_language_emoji', b.target_language_emoji,
      'auto_suggestion', null, 'my_suggestion', null, 'glossary_terms', '[]'::jsonb
    ) order by b.queue_rank) filter (where b.id is not null), '[]'::jsonb)::json
  from target t cross join params left join batch b on true
  group by t.id, t.code, t.name, t.native_name, t.emoji, params.category_slug, params.batch_size, params.session_offset;
$$;
grant execute on function public.translation_workspace_session(text, text, integer, integer, uuid) to authenticated;

create or replace function public.public_status_overview()
returns table (total_strings bigint, total_languages bigint, collaborators bigint, total_translations bigint, total_reviews bigint, translated_percent numeric(5,2), reviewed_percent numeric(5,2), official_percent numeric(5,2))
language sql stable security definer set search_path = public, auth
as $$
  with totals as (
    select coalesce(sum(total_strings), 0)::bigint as total_strings,
      coalesce(sum(translated_strings), 0)::bigint as translated_strings,
      coalesce(sum(reviewed_strings), 0)::bigint as reviewed_strings,
      coalesce(sum(official_strings), 0)::bigint as official_strings
    from public.language_translation_stats
  )
  select t.total_strings,
    (select count(*)::bigint from public.languages where is_active),
    (select count(*)::bigint from public.public_profile_cards_view),
    (select count(*)::bigint from public.translation_suggestions),
    (select count(*)::bigint from public.reviews),
    case when t.total_strings = 0 then 0::numeric(5,2) else round(t.translated_strings::numeric * 100 / t.total_strings, 2)::numeric(5,2) end,
    case when t.total_strings = 0 then 0::numeric(5,2) else round(t.reviewed_strings::numeric * 100 / t.total_strings, 2)::numeric(5,2) end,
    case when t.total_strings = 0 then 0::numeric(5,2) else round(t.official_strings::numeric * 100 / t.total_strings, 2)::numeric(5,2) end
  from totals t;
$$;

create or replace function public.public_status_language_coverage()
returns table (language_id uuid, code text, name text, native_name text, emoji text, direction text, total_strings bigint, translated_count bigint, reviewed_count bigint, official_count bigint, translated_percent numeric(5,2), reviewed_percent numeric(5,2), official_percent numeric(5,2), active_translators bigint, active_reviewers bigint, active_moderators bigint)
language sql stable security definer set search_path = public, auth
as $$
  select l.id, l.code, l.name, l.native_name, l.emoji, l.direction::text,
    coalesce(s.total_strings, 0), coalesce(s.translated_strings, 0), coalesce(s.reviewed_strings, 0), coalesce(s.official_strings, 0),
    coalesce(s.translated_percent, 0), coalesce(s.reviewed_percent, 0), coalesce(s.official_percent, 0),
    count(lm.user_id) filter (where lm.is_active and public.role_rank(lm.role::text) >= public.role_rank('translator'))::bigint,
    count(lm.user_id) filter (where lm.is_active and public.role_rank(lm.role::text) >= public.role_rank('reviewer'))::bigint,
    count(lm.user_id) filter (where lm.is_active and public.role_rank(lm.role::text) >= public.role_rank('language_moderator'))::bigint
  from public.languages l
  left join public.language_translation_stats s on s.language_id = l.id
  left join public.language_members lm on lm.language_id = l.id
  where l.is_active
  group by l.id, l.code, l.name, l.native_name, l.emoji, l.direction, s.total_strings, s.translated_strings, s.reviewed_strings, s.official_strings, s.translated_percent, s.reviewed_percent, s.official_percent
  order by l.sort_order, l.name;
$$;
grant execute on function public.public_status_overview() to anon, authenticated;
grant execute on function public.public_status_language_coverage() to anon, authenticated;

create or replace function public.public_language_category_stats(p_language_code text)
returns table (
  slug text, label text, total_strings bigint, translated_count bigint, reviewed_count bigint,
  official_count bigint, translated_percent numeric(5,2), reviewed_percent numeric(5,2),
  official_percent numeric(5,2), has_open_work boolean
)
language sql stable security definer set search_path = public, auth
as $$
  select
    cs.category,
    case cs.category
      when 'system_messages' then 'System Messages'
      else initcap(replace(cs.category, '_', ' '))
    end,
    cs.total_strings, cs.translated_strings, cs.reviewed_strings, cs.official_strings,
    cs.translated_percent, cs.reviewed_percent, cs.official_percent,
    cs.official_strings < cs.total_strings
  from public.category_translation_stats cs
  join public.languages l on l.id = cs.language_id
  where lower(l.code) = lower(trim(p_language_code))
  order by cs.category;
$$;
grant execute on function public.public_language_category_stats(text) to anon, authenticated;

create or replace function public.my_translation_contributions(p_limit integer default 20)
returns table (
  suggestion_id uuid, key_name text, source_text text, target_language_code text,
  translated_text text, status text, source_version integer, version_number integer,
  created_at timestamptz, updated_at timestamptz
)
language sql stable security definer set search_path = public, auth
as $$
  select ts.id, tk.key_name, tk.original_text, l.code, ts.suggestion_text, ts.status::text,
    ts.source_version, ts.version_number, ts.created_at, ts.updated_at
  from public.translation_suggestions ts
  join public.translation_keys tk on tk.id = ts.translation_key_id
  join public.languages l on l.id = ts.target_language_id
  where ts.author_id = auth.uid()
  order by ts.updated_at desc
  limit greatest(1, least(coalesce(p_limit, 20), 100));
$$;
grant execute on function public.my_translation_contributions(integer) to authenticated;

create or replace function public.data_integrity_check()
returns table (severity text, check_name text, affected_records bigint, details text)
language sql stable security definer set search_path = public, auth
as $$
  select 'critical', 'keys_without_name', count(*)::bigint, 'translation_keys without key_name' from public.translation_keys where nullif(trim(key_name), '') is null
  union all select 'critical', 'suggestions_without_author', count(*)::bigint, 'translation_suggestions without author' from public.translation_suggestions where author_id is null
  union all select 'warning', 'keys_without_category', count(*)::bigint, 'active keys without category' from public.translation_keys where status = 'active' and nullif(trim(category), '') is null
  union all select 'warning', 'empty_suggestions', count(*)::bigint, 'empty suggestion text' from public.translation_suggestions where nullif(trim(suggestion_text), '') is null
  union all select 'critical', 'duplicate_officials', count(*)::bigint, 'duplicate official translations per key/language/source version' from (select 1 from public.translation_suggestions where status = 'official' group by translation_key_id, target_language_id, source_version having count(*) > 1) duplicates;
$$;
revoke all on function public.data_integrity_check() from public;
grant execute on function public.data_integrity_check() to authenticated;

commit;
