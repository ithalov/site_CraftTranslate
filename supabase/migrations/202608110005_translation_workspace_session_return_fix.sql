-- Replaces the queue RPC with explicit return casts.
-- This fixes PostgreSQL's "structure of query does not match function result type" error.

begin;

drop function if exists public.translation_workspace_session(text, text, integer, integer, uuid);

create function public.translation_workspace_session(
  p_target_language_code text default null,
  p_category_slug text default null,
  p_batch_size integer default 10,
  p_session_offset integer default 0,
  p_viewer_user_id uuid default null
)
returns table (
  session_id uuid,
  target_language_id uuid,
  target_language_code text,
  target_language_name text,
  target_language_native_name text,
  target_language_emoji text,
  category_slug text,
  total_available bigint,
  loaded_count bigint,
  batch_size integer,
  session_offset integer,
  has_more boolean,
  items json
)
language plpgsql
stable
security definer
set search_path = public, auth
as $$
declare
  v_target public.languages%rowtype;
  v_category_slug text := lower(trim(coalesce(p_category_slug, 'all')));
  v_batch_size integer := greatest(1, least(coalesce(p_batch_size, 10), 20));
  v_session_offset integer := greatest(0, coalesce(p_session_offset, 0));
  v_viewer_seed text := coalesce(p_viewer_user_id::text, auth.uid()::text, 'guest');
  v_total_available bigint := 0;
begin
  select * into v_target
  from public.languages l
  where l.is_active
    and lower(l.code) = lower(trim(coalesce(p_target_language_code, '')))
    and public.can_translate_language(l.id)
  limit 1;

  if v_target.id is null then
    return;
  end if;

  select count(*)::bigint into v_total_available
  from public.translation_keys tk
  where tk.status = 'active'
    and (
      v_category_slug in ('', 'all', 'general')
      or lower(regexp_replace(trim(tk.category), '\s+', '_', 'g')) = v_category_slug
    )
    and (
      coalesce(array_length(tk.supported_targets, 1), 0) = 0
      or exists (
        select 1
        from unnest(tk.supported_targets) as supported(value)
        where lower(trim(supported.value)) = lower(v_target.code)
      )
    )
    and not exists (
      select 1
      from public.translation_suggestions mine
      where mine.translation_key_id = tk.id
        and mine.target_language_id = v_target.id
        and mine.author_id = auth.uid()
        and mine.source_version = tk.source_version
        and mine.status in ('pending', 'reviewing', 'approved', 'official')
    )
    and not exists (
      select 1
      from public.translation_suggestions official
      where official.translation_key_id = tk.id
        and official.target_language_id = v_target.id
        and official.source_version = tk.source_version
        and official.status = 'official'
    );

  return query
  with candidates as (
    select
      tk.id,
      tk.key_name,
      tk.original_text,
      tk.category,
      tk.subcategory,
      tk.context,
      tk.protected_variables,
      tk.protected_terms,
      tk.source_language_id,
      tk.source_version,
      sl.code as source_language_code,
      sl.name as source_language_name,
      sl.native_name as source_language_native_name,
      sl.emoji as source_language_emoji,
      row_number() over (order by md5(v_viewer_seed || ':' || v_target.code || ':' || tk.id::text), tk.id) as queue_rank
    from public.translation_keys tk
    join public.languages sl on sl.id = tk.source_language_id
    where tk.status = 'active'
      and (
        v_category_slug in ('', 'all', 'general')
        or lower(regexp_replace(trim(tk.category), '\s+', '_', 'g')) = v_category_slug
      )
      and (
        coalesce(array_length(tk.supported_targets, 1), 0) = 0
        or exists (
          select 1
          from unnest(tk.supported_targets) as supported(value)
          where lower(trim(supported.value)) = lower(v_target.code)
        )
      )
      and not exists (
        select 1
        from public.translation_suggestions mine
        where mine.translation_key_id = tk.id
          and mine.target_language_id = v_target.id
          and mine.author_id = auth.uid()
          and mine.source_version = tk.source_version
          and mine.status in ('pending', 'reviewing', 'approved', 'official')
      )
      and not exists (
        select 1
        from public.translation_suggestions official
        where official.translation_key_id = tk.id
          and official.target_language_id = v_target.id
          and official.source_version = tk.source_version
          and official.status = 'official'
      )
  ), selected_items as (
    select *
    from candidates
    order by queue_rank
    limit v_batch_size
    offset v_session_offset
  )
  select
    gen_random_uuid()::uuid,
    v_target.id::uuid,
    v_target.code::text,
    v_target.name::text,
    v_target.native_name::text,
    v_target.emoji::text,
    v_category_slug::text,
    v_total_available::bigint,
    count(si.id)::bigint,
    v_batch_size::integer,
    v_session_offset::integer,
    (v_total_available > (v_session_offset::bigint + count(si.id)::bigint))::boolean,
    coalesce(
      jsonb_agg(
        jsonb_build_object(
          'translation_key_id', si.id,
          'key_name', si.key_name,
          'original_text', si.original_text,
          'category', si.category,
          'subcategory', si.subcategory,
          'context', si.context,
          'protected_variables', si.protected_variables,
          'protected_terms', si.protected_terms,
          'source_language_id', si.source_language_id,
          'source_language_code', si.source_language_code,
          'source_language_name', si.source_language_name,
          'source_language_native_name', si.source_language_native_name,
          'source_language_emoji', si.source_language_emoji,
          'target_language_id', v_target.id,
          'target_language_code', v_target.code,
          'target_language_name', v_target.name,
          'target_language_native_name', v_target.native_name,
          'target_language_emoji', v_target.emoji,
          'auto_suggestion', null,
          'my_suggestion', null,
          'glossary_terms', '[]'::jsonb
        )
        order by si.queue_rank
      ) filter (where si.id is not null),
      '[]'::jsonb
    )::json
  from selected_items si;
end;
$$;

grant execute on function public.translation_workspace_session(text, text, integer, integer, uuid) to authenticated;

commit;
