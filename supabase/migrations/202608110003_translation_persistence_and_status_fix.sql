begin;

drop function if exists public.translation_workspace_submit(uuid, text, text, text, text, uuid);

create function public.translation_workspace_submit(
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
  v_target_language_code text;
  v_version_number integer;
  v_suggestion_id uuid;
  v_clean_text text;
  v_source_text text;
  v_missing_tokens text[] := array[]::text[];
  v_extra_tokens text[] := array[]::text[];
  v_record record;
  v_duplicate record;
  v_supported_targets text[];
begin
  if auth.uid() is null then
    raise exception 'Authentication required';
  end if;

  v_clean_text := trim(coalesce(_suggestion_text, ''));

  if length(v_clean_text) = 0 then
    raise exception 'Suggestion text cannot be empty';
  end if;

  select l.id, l.code
    into v_target_language_id, v_target_language_code
  from public.languages l
  where l.is_active
    and lower(l.code) = lower(trim(coalesce(_target_language_code, '')))
    and public.can_translate_language(l.id)
  limit 1;

  if v_target_language_id is null then
    raise exception 'Target language not available';
  end if;

  select coalesce(tk.supported_targets, '{}'::text[])
    into v_supported_targets
  from public.translation_keys tk
  where tk.id = _translation_key_id;

  if coalesce(array_length(v_supported_targets, 1), 0) > 0
     and not exists (
       select 1
       from unnest(v_supported_targets) as supported_target(value)
       where lower(trim(supported_target.value)) = lower(v_target_language_code)
     ) then
    raise exception 'Translation key is not available for the selected target language';
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
    v_suggestion_id::uuid,
    v_version_number::integer,
    'pending'::text,
    timezone('utc', now())::timestamptz;
end;
$$;

grant execute on function public.translation_workspace_submit(uuid, text, text, text, text, uuid) to authenticated;

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
    )
  ),
  approved_total as (
    select count(distinct tk.id)::bigint as approved_strings
    from public.translation_keys tk
    where exists (
      select 1
      from public.translation_suggestions ts
      where ts.translation_key_id = tk.id
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
  with language_totals as (
    select
      l.id as language_id,
      count(distinct tk.id)::bigint as total_strings
    from public.languages l
    left join public.translation_keys tk
      on tk.status = 'active'
     and (
       coalesce(array_length(tk.supported_targets, 1), 0) = 0
       or exists (
         select 1
         from unnest(tk.supported_targets) as target_code(value)
         where lower(trim(target_code.value)) = lower(l.code)
       )
     )
    where l.is_active
    group by l.id
  ),
  translated_totals as (
    select
      ts.target_language_id as language_id,
      count(distinct ts.translation_key_id)::bigint as translated_count,
      count(distinct ts.translation_key_id) filter (where ts.status = 'approved')::bigint as official_count
    from public.translation_suggestions ts
    group by ts.target_language_id
  ),
  reviewed_totals as (
    select
      ts.target_language_id as language_id,
      count(distinct ts.translation_key_id) filter (where r.id is not null)::bigint as reviewed_count
    from public.translation_suggestions ts
    left join public.reviews r
      on r.translation_suggestion_id = ts.id
    group by ts.target_language_id
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
    coalesce(lt.total_strings, 0) as total_strings,
    coalesce(tt.translated_count, 0) as translated_count,
    coalesce(rt.reviewed_count, 0) as reviewed_count,
    coalesce(tt.official_count, 0) as official_count,
    case
      when coalesce(lt.total_strings, 0) = 0 then 0::numeric(5,2)
      else round((coalesce(tt.translated_count, 0)::numeric / lt.total_strings::numeric) * 100, 2)::numeric(5,2)
    end as translated_percent,
    case
      when coalesce(tt.translated_count, 0) = 0 then 0::numeric(5,2)
      else round((coalesce(rt.reviewed_count, 0)::numeric / greatest(tt.translated_count, 1)::numeric) * 100, 2)::numeric(5,2)
    end as reviewed_percent,
    case
      when coalesce(lt.total_strings, 0) = 0 then 0::numeric(5,2)
      else round((coalesce(tt.official_count, 0)::numeric / lt.total_strings::numeric) * 100, 2)::numeric(5,2)
    end as official_percent,
    coalesce(mt.active_translators, 0) as active_translators,
    coalesce(mt.active_reviewers, 0) as active_reviewers,
    coalesce(mt.active_moderators, 0) as active_moderators
  from public.languages l
  left join language_totals lt on lt.language_id = l.id
  left join translated_totals tt on tt.language_id = l.id
  left join reviewed_totals rt on rt.language_id = l.id
  left join membership_totals mt on mt.language_id = l.id
  where l.is_active
  order by l.sort_order asc, l.name asc;
$$;

grant execute on function public.public_status_language_coverage() to anon, authenticated;

commit;
