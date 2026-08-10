begin;

create or replace function public.language_proficiency_rank(proficiency text)
returns integer
language sql
stable
as $$
  select case lower(trim(coalesce(proficiency, '')))
    when 'native' then 3
    when 'fluent' then 2
    when 'advanced' then 2
    when 'intermediate' then 1
    else 0
  end;
$$;

grant execute on function public.language_proficiency_rank(text) to anon, authenticated;

create or replace function public.can_translate_language(language_uuid uuid)
returns boolean
language sql
stable
security definer
set search_path = public, auth
as $$
  select public.is_admin_or_owner()
    or exists (
      select 1
      from public.user_languages ul
      where ul.user_id = auth.uid()
        and ul.language_id = language_uuid
        and public.language_proficiency_rank(ul.proficiency::text) >= 1
    )
    or public.has_language_role(language_uuid, 'translator')
    or public.has_language_role(language_uuid, 'trusted_translator')
    or public.has_language_role(language_uuid, 'reviewer')
    or public.has_language_role(language_uuid, 'language_moderator');
$$;

grant execute on function public.can_translate_language(uuid) to anon, authenticated;

create or replace function public.translation_workspace_session(
  target_language_code text default null,
  category_slug text default null,
  batch_size integer default 10,
  session_offset integer default 0
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
  items jsonb
)
language sql
stable
security definer
set search_path = public, auth
as $$
  with normalized_params as (
    select
      case
        when lower(trim(coalesce(category_slug, ''))) in (
          'general',
          'minecraft',
          'pvp',
          'mmorpg',
          'economy',
          'trading',
          'commands',
          'system_messages',
          'mods'
        ) then lower(trim(coalesce(category_slug, '')))
        else 'all'
      end as normalized_category_slug,
      greatest(1, least(coalesce(batch_size, 10), 20)) as normalized_batch_size,
      greatest(0, coalesce(session_offset, 0)) as normalized_session_offset
  ),
  requested_target as (
    select
      l.id,
      l.code,
      l.name,
      l.native_name,
      l.emoji
    from public.languages l
    where l.is_active
      and lower(l.code) = lower(trim(coalesce(target_language_code, '')))
      and public.can_translate_language(l.id)
    limit 1
  ),
  fallback_target as (
    select
      l.id,
      l.code,
      l.name,
      l.native_name,
      l.emoji
    from public.languages l
    where l.is_active
      and public.can_translate_language(l.id)
    order by l.sort_order asc, l.name asc
    limit 1
  ),
  selected_target as (
    select * from requested_target
    union all
    select * from fallback_target
    where not exists (select 1 from requested_target)
    limit 1
  ),
  candidate_keys as (
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
      sl.code as source_language_code,
      sl.name as source_language_name,
      sl.native_name as source_language_native_name,
      sl.emoji as source_language_emoji,
      st.id as target_language_id,
      st.code as target_language_code,
      st.name as target_language_name,
      st.native_name as target_language_native_name,
      st.emoji as target_language_emoji,
      row_number() over (
        order by coalesce(tk.updated_at, tk.created_at) asc, tk.id asc
      ) as queue_rank
    from public.translation_keys tk
    join selected_target st on true
    join public.languages sl on sl.id = tk.source_language_id
    cross join normalized_params np
    where tk.status = 'active'
      and (
        np.normalized_category_slug = 'all'
        or lower(regexp_replace(trim(coalesce(tk.category, '')), '\s+', '_', 'g')) = np.normalized_category_slug
      )
      and not exists (
        select 1
        from public.translation_suggestions ts
        where ts.translation_key_id = tk.id
          and ts.target_language_id = st.id
          and ts.status = 'approved'
      )
      and not exists (
        select 1
        from public.translation_suggestions ts
        where ts.translation_key_id = tk.id
          and ts.target_language_id = st.id
          and ts.author_id = auth.uid()
          and ts.status in ('draft', 'pending')
      )
  ),
  totals as (
    select count(*)::bigint as total_available
    from candidate_keys
  ),
  batch_keys as (
    select *
    from candidate_keys
    cross join normalized_params np
    order by queue_rank asc
    limit (select np.normalized_batch_size from normalized_params np)
    offset (select np.normalized_session_offset from normalized_params np)
  ),
  item_rows as (
    select
      bk.id as translation_key_id,
      bk.key_name,
      bk.original_text,
      bk.category,
      bk.subcategory,
      bk.context,
      bk.protected_variables,
      bk.protected_terms,
      bk.source_language_id,
      bk.source_language_code,
      bk.source_language_name,
      bk.source_language_native_name,
      bk.source_language_emoji,
      bk.target_language_id,
      bk.target_language_code,
      bk.target_language_name,
      bk.target_language_native_name,
      bk.target_language_emoji,
      bk.queue_rank,
      coalesce(auto.auto_suggestion, null) as auto_suggestion,
      coalesce(my_suggestion.my_suggestion, null) as my_suggestion,
      coalesce(glossary_data.glossary_terms, '[]'::jsonb) as glossary_terms
    from batch_keys bk
    left join lateral (
      select jsonb_build_object(
        'suggestion_id', ts.id,
        'version_number', ts.version_number,
        'status', ts.status::text,
        'suggestion_text', ts.suggestion_text,
        'author_id', ts.author_id,
        'author_name', p.display_name,
        'author_username', p.username,
        'created_at', ts.created_at
      ) as auto_suggestion
      from public.translation_suggestions ts
      left join public.profiles p on p.user_id = ts.author_id
      where ts.translation_key_id = bk.id
        and ts.target_language_id = bk.target_language_id
      order by
        case ts.status
          when 'approved' then 0
          when 'pending' then 1
          when 'draft' then 2
          else 3
        end,
        ts.version_number desc,
        ts.created_at desc
      limit 1
    ) auto on true
    left join lateral (
      select jsonb_build_object(
        'suggestion_id', ts.id,
        'version_number', ts.version_number,
        'status', ts.status::text,
        'suggestion_text', ts.suggestion_text,
        'rationale', ts.rationale,
        'notes', ts.notes,
        'updated_at', ts.updated_at
      ) as my_suggestion
      from public.translation_suggestions ts
      where ts.translation_key_id = bk.id
        and ts.target_language_id = bk.target_language_id
        and ts.author_id = auth.uid()
      order by ts.version_number desc, ts.updated_at desc
      limit 1
    ) my_suggestion on true
    left join lateral (
      select coalesce(
        jsonb_agg(
          jsonb_build_object(
            'id', g.id,
            'term', g.term,
            'definition', g.definition,
            'category', g.category,
            'subcategory', g.subcategory,
            'aliases', g.aliases,
            'tags', g.tags
          )
          order by g.term asc
        ) filter (where g.id is not null),
        '[]'::jsonb
      ) as glossary_terms
      from public.glossary g
      where g.language_id = bk.target_language_id
        and g.status = 'approved'
        and (
          lower(regexp_replace(trim(coalesce(g.category, '')), '\s+', '_', 'g')) = lower(regexp_replace(trim(coalesce(bk.category, '')), '\s+', '_', 'g'))
          or lower(regexp_replace(trim(coalesce(g.subcategory, '')), '\s+', '_', 'g')) = lower(regexp_replace(trim(coalesce(bk.subcategory, '')), '\s+', '_', 'g'))
        )
      limit 5
    ) glossary_data on true
  )
  select
    gen_random_uuid() as session_id,
    st.id as target_language_id,
    st.code as target_language_code,
    st.name as target_language_name,
    st.native_name as target_language_native_name,
    st.emoji as target_language_emoji,
    np.normalized_category_slug as category_slug,
    coalesce(t.total_available, 0) as total_available,
    count(ir.translation_key_id)::bigint as loaded_count,
    np.normalized_batch_size as batch_size,
    np.normalized_session_offset as session_offset,
    coalesce(t.total_available, 0) > (np.normalized_session_offset + count(ir.translation_key_id)) as has_more,
    coalesce(
      jsonb_agg(
        jsonb_build_object(
          'translation_key_id', ir.translation_key_id,
          'key_name', ir.key_name,
          'original_text', ir.original_text,
          'category', ir.category,
          'subcategory', ir.subcategory,
          'context', ir.context,
          'protected_variables', ir.protected_variables,
          'protected_terms', ir.protected_terms,
          'source_language_id', ir.source_language_id,
          'source_language_code', ir.source_language_code,
          'source_language_name', ir.source_language_name,
          'source_language_native_name', ir.source_language_native_name,
          'source_language_emoji', ir.source_language_emoji,
          'target_language_id', ir.target_language_id,
          'target_language_code', ir.target_language_code,
          'target_language_name', ir.target_language_name,
          'target_language_native_name', ir.target_language_native_name,
          'target_language_emoji', ir.target_language_emoji,
          'auto_suggestion', ir.auto_suggestion,
          'my_suggestion', ir.my_suggestion,
          'glossary_terms', ir.glossary_terms
        )
        order by ir.queue_rank asc
      ) filter (where ir.translation_key_id is not null),
      '[]'::jsonb
    ) as items
  from selected_target st
  cross join normalized_params np
  left join totals t on true
  left join item_rows ir on true
  group by
    st.id,
    st.code,
    st.name,
    st.native_name,
    st.emoji,
    np.normalized_category_slug,
    t.total_available,
    np.normalized_batch_size,
    np.normalized_session_offset;
$$;

grant execute on function public.translation_workspace_session(text, text, integer, integer) to authenticated;

create or replace function public.translation_workspace_submit(
  translation_key_id uuid,
  target_language_code text,
  suggestion_text text,
  rationale text default null,
  notes text default null
)
returns table (
  suggestion_id uuid,
  version_number integer,
  status text,
  created_at timestamptz
)
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  v_target_language_id uuid;
  v_version_number integer;
  v_suggestion_id uuid;
  v_clean_text text;
  v_source_text text;
  v_missing_tokens text[] := array[]::text[];
  v_extra_tokens text[] := array[]::text[];
  v_record record;
begin
  if auth.uid() is null then
    raise exception 'Authentication required';
  end if;

  v_clean_text := trim(coalesce(suggestion_text, ''));

  if length(v_clean_text) = 0 then
    raise exception 'Suggestion text cannot be empty';
  end if;

  select l.id
    into v_target_language_id
  from public.languages l
  where l.is_active
    and lower(l.code) = lower(trim(coalesce(target_language_code, '')))
    and public.can_translate_language(l.id)
  limit 1;

  if v_target_language_id is null then
    raise exception 'Target language not available';
  end if;

  if not exists (
    select 1
    from public.translation_keys tk
    where tk.id = translation_key_id
      and tk.status = 'active'
  ) then
    raise exception 'Translation key not available';
  end if;

  select tk.original_text
    into v_source_text
  from public.translation_keys tk
  where tk.id = translation_key_id;

  for v_record in
    with source_tokens as (
      select token, count(*)::int as occurrence_count
      from (
        select (match)[1] as token
        from regexp_matches(coalesce(v_source_text, ''), '(\{[A-Za-z0-9_]+\}|%[sd])', 'g') as match
      ) tokens
      group by token
    ),
    translation_tokens as (
      select token, count(*)::int as occurrence_count
      from (
        select (match)[1] as token
        from regexp_matches(v_clean_text, '(\{[A-Za-z0-9_]+\}|%[sd])', 'g') as match
      ) tokens
      group by token
    )
    select
      coalesce(source_tokens.token, translation_tokens.token) as token,
      coalesce(source_tokens.occurrence_count, 0) as source_count,
      coalesce(translation_tokens.occurrence_count, 0) as translation_count
    from source_tokens
    full join translation_tokens on translation_tokens.token = source_tokens.token
  loop
    if v_record.translation_count < v_record.source_count then
      v_missing_tokens := array_append(v_missing_tokens, v_record.token);
    end if;

    if v_record.translation_count > v_record.source_count then
      v_extra_tokens := array_append(v_extra_tokens, v_record.token);
    end if;
  end loop;

  if coalesce(array_length(v_missing_tokens, 1), 0) > 0 or coalesce(array_length(v_extra_tokens, 1), 0) > 0 then
    raise exception 'Placeholder mismatch. Missing: %, extra: %', v_missing_tokens, v_extra_tokens;
  end if;

  select coalesce(max(ts.version_number), 0) + 1
    into v_version_number
  from public.translation_suggestions ts
  where ts.translation_key_id = translation_key_id
    and ts.target_language_id = v_target_language_id;

  insert into public.translation_suggestions (
    translation_key_id,
    target_language_id,
    author_id,
    version_number,
    suggestion_text,
    rationale,
    notes,
    status
  ) values (
    translation_key_id,
    v_target_language_id,
    auth.uid(),
    v_version_number,
    v_clean_text,
    nullif(trim(coalesce(rationale, '')), ''),
    nullif(trim(coalesce(notes, '')), ''),
    'pending'
  )
  returning id into v_suggestion_id;

  update public.translation_keys
  set
    current_suggestion_id = v_suggestion_id,
    updated_by = auth.uid(),
    updated_at = timezone('utc', now())
  where id = translation_key_id;

  return query
  select
    v_suggestion_id,
    v_version_number,
    'pending'::text,
    timezone('utc', now());
end;
$$;

grant execute on function public.translation_workspace_submit(uuid, text, text, text, text) to authenticated;

commit;
