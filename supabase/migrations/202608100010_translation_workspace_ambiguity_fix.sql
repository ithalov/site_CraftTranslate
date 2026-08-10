begin;

create or replace function public.translation_workspace_detect_duplicate(
  _translation_key_id uuid,
  _target_language_code text,
  _suggestion_text text
)
returns table (
  suggestion_id uuid,
  version_number integer,
  status text,
  suggestion_text text,
  author_id uuid,
  author_name text,
  author_username text,
  created_at timestamptz,
  match_kind text
)
language sql
stable
security definer
set search_path = public, auth
as $$
  with target_language as (
    select
      l.id
    from public.languages l
    where l.is_active
      and lower(l.code) = lower(trim(coalesce(_target_language_code, '')))
      and public.can_translate_language(l.id)
    limit 1
  )
  select
    ts.id as suggestion_id,
    ts.version_number,
    ts.status::text as status,
    ts.suggestion_text,
    ts.author_id,
    p.display_name as author_name,
    p.username as author_username,
    ts.created_at,
    'equivalent'::text as match_kind
  from public.translation_suggestions ts
  join target_language tl on tl.id = ts.target_language_id
  left join public.profiles p on p.user_id = ts.author_id
  where ts.translation_key_id = _translation_key_id
    and public.normalize_translation_workspace_text(ts.suggestion_text) = public.normalize_translation_workspace_text(_suggestion_text)
  order by
    case ts.status
      when 'approved' then 0
      when 'pending' then 1
      when 'draft' then 2
      else 3
    end,
    ts.version_number desc,
    ts.created_at desc
  limit 1;
$$;

grant execute on function public.translation_workspace_detect_duplicate(uuid, text, text) to authenticated;

create or replace function public.translation_workspace_submit(
  _translation_key_id uuid,
  _target_language_code text,
  _suggestion_text text,
  _rationale text default null,
  _notes text default null,
  _supersedes_suggestion_id uuid default null
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
  v_duplicate record;
begin
  if auth.uid() is null then
    raise exception 'Authentication required';
  end if;

  v_clean_text := trim(coalesce(_suggestion_text, ''));

  if length(v_clean_text) = 0 then
    raise exception 'Suggestion text cannot be empty';
  end if;

  select l.id
    into v_target_language_id
  from public.languages l
  where l.is_active
    and lower(l.code) = lower(trim(coalesce(_target_language_code, '')))
    and public.can_translate_language(l.id)
  limit 1;

  if v_target_language_id is null then
    raise exception 'Target language not available';
  end if;

  if not exists (
    select 1
    from public.translation_keys tk
    where tk.id = _translation_key_id
      and tk.status = 'active'
  ) then
    raise exception 'Translation key not available';
  end if;

  select tk.original_text
    into v_source_text
  from public.translation_keys tk
  where tk.id = _translation_key_id;

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

  if _supersedes_suggestion_id is not null then
    if not exists (
      select 1
      from public.translation_suggestions ts
      where ts.id = _supersedes_suggestion_id
        and ts.translation_key_id = _translation_key_id
        and ts.target_language_id = v_target_language_id
    ) then
      raise exception 'Base suggestion is not valid for this translation key';
    end if;
  end if;

  select *
    into v_duplicate
  from public.translation_workspace_detect_duplicate(
    _translation_key_id,
    _target_language_code,
    v_clean_text
  )
  limit 1;

  if v_duplicate.suggestion_id is not null and _supersedes_suggestion_id is null then
    raise exception 'Equivalent translation already exists'
      using detail = format(
        'Use Agree on suggestion %s or submit as an improvement.',
        v_duplicate.suggestion_id
      ),
      hint = 'Choose Agree or Suggest Improvement instead of creating a duplicate.';
  end if;

  select coalesce(max(ts.version_number), 0) + 1
    into v_version_number
  from public.translation_suggestions ts
  where ts.translation_key_id = _translation_key_id
    and ts.target_language_id = v_target_language_id;

  insert into public.translation_suggestions (
    translation_key_id,
    target_language_id,
    author_id,
    version_number,
    suggestion_text,
    rationale,
    notes,
    supersedes_suggestion_id,
    status
  ) values (
    _translation_key_id,
    v_target_language_id,
    auth.uid(),
    v_version_number,
    v_clean_text,
    nullif(trim(coalesce(_rationale, '')), ''),
    nullif(trim(coalesce(_notes, '')), ''),
    _supersedes_suggestion_id,
    'pending'
  )
  returning id into v_suggestion_id;

  update public.translation_keys
  set
    current_suggestion_id = v_suggestion_id,
    updated_by = auth.uid(),
    updated_at = timezone('utc', now())
  where id = _translation_key_id;

  return query
  select
    v_suggestion_id,
    v_version_number,
    'pending'::text,
    timezone('utc', now());
end;
$$;

grant execute on function public.translation_workspace_submit(
  uuid,
  text,
  text,
  text,
  text,
  uuid
) to authenticated;

commit;
