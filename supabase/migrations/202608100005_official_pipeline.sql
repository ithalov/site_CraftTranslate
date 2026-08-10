begin;

drop function if exists public.review_workspace_session(text, integer, integer);
drop function if exists public.review_workspace_submit(uuid, text, text, text);

do $$
begin
  alter type public.translation_suggestion_status add value if not exists 'reviewing';
exception
  when duplicate_object then null;
end $$;

do $$
begin
  alter type public.translation_suggestion_status add value if not exists 'needs_changes';
exception
  when duplicate_object then null;
end $$;

do $$
begin
  alter type public.translation_suggestion_status add value if not exists 'reported';
exception
  when duplicate_object then null;
end $$;

do $$
begin
  alter type public.translation_suggestion_status add value if not exists 'official';
exception
  when duplicate_object then null;
end $$;

commit;
begin;

create or replace function public.review_workspace_session(
  target_language_code text default null,
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
      greatest(1, least(coalesce(batch_size, 10), 20)) as normalized_batch_size,
      greatest(0, coalesce(session_offset, 0)) as normalized_session_offset
  ),
  requested_target as (
    select l.id, l.code, l.name, l.native_name, l.emoji
    from public.languages l
    where l.is_active
      and lower(l.code) = lower(trim(coalesce(target_language_code, '')))
      and public.has_language_role(l.id, 'reviewer')
    limit 1
  ),
  fallback_target as (
    select l.id, l.code, l.name, l.native_name, l.emoji
    from public.languages l
    where l.is_active
      and public.has_language_role(l.id, 'reviewer')
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
  candidate_suggestions as (
    select
      ts.id as suggestion_id,
      ts.translation_key_id,
      ts.target_language_id,
      ts.suggestion_text,
      ts.rationale,
      ts.notes,
      ts.status,
      ts.version_number,
      ts.author_id,
      p.display_name as author_name,
      p.username as author_username,
      ts.created_at,
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
      tl.code as target_language_code,
      tl.name as target_language_name,
      tl.native_name as target_language_native_name,
      tl.emoji as target_language_emoji,
      row_number() over (
        order by coalesce(ts.updated_at, ts.created_at) asc, ts.id asc
      ) as queue_rank
    from public.translation_suggestions ts
    join selected_target tl on tl.id = ts.target_language_id
    join public.translation_keys tk on tk.id = ts.translation_key_id
    join public.languages sl on sl.id = tk.source_language_id
    left join public.profiles p on p.user_id = ts.author_id
    where ts.status in ('pending', 'reviewing')
      and ts.author_id <> auth.uid()
      and public.can_review_translation_suggestion(ts.id)
      and not exists (
        select 1
        from public.reviews r
        where r.translation_suggestion_id = ts.id
          and r.reviewer_id = auth.uid()
      )
  ),
  totals as (
    select count(*)::bigint as total_available
    from candidate_suggestions
  ),
  batch_suggestions as (
    select *
    from candidate_suggestions
    cross join normalized_params np
    order by queue_rank asc
    limit (select np.normalized_batch_size from normalized_params np)
    offset (select np.normalized_session_offset from normalized_params np)
  ),
  item_rows as (
    select
      bs.suggestion_id,
      bs.translation_key_id,
      bs.key_name,
      bs.original_text,
      bs.category,
      bs.subcategory,
      bs.context,
      bs.protected_variables,
      bs.protected_terms,
      bs.source_language_id,
      bs.source_language_code,
      bs.source_language_name,
      bs.source_language_native_name,
      bs.source_language_emoji,
      bs.target_language_id,
      bs.target_language_code,
      bs.target_language_name,
      bs.target_language_native_name,
      bs.target_language_emoji,
      bs.suggestion_text,
      bs.rationale,
      bs.notes,
      bs.status,
      bs.version_number,
      bs.author_id,
      bs.author_name,
      bs.author_username,
      bs.created_at,
      bs.queue_rank,
      coalesce(confidence_data.confidence_json, '{}'::jsonb) as confidence,
      coalesce(review_history.review_history, '[]'::jsonb) as review_history,
      coalesce(other_suggestions.other_suggestions, '[]'::jsonb) as other_suggestions,
      coalesce(glossary_data.glossary_terms, '[]'::jsonb) as glossary_terms
    from batch_suggestions bs
    left join lateral (
      select jsonb_build_object(
        'confidence_level', c.confidence_level,
        'confidence_score', c.confidence_score,
        'valid_reviews', c.valid_reviews,
        'distinct_reviewers', c.distinct_reviewers,
        'approved_reviews', c.approved_reviews,
        'request_changes_reviews', c.request_changes_reviews,
        'rejected_reviews', c.rejected_reviews,
        'agreement_rate', c.agreement_rate,
        'reviewer_trust_score', c.reviewer_trust_score,
        'open_reports', c.open_reports,
        'final_status', c.final_status,
        'verified_ready', c.verified_ready,
        'signals', c.signals
      ) as confidence_json
      from public.translation_confidence_for_suggestion(bs.suggestion_id) c
      limit 1
    ) confidence_data on true
    left join lateral (
      select coalesce(
        jsonb_agg(
          jsonb_build_object(
            'review_id', r.id,
            'reviewer_id', r.reviewer_id,
            'reviewer_name', rp.display_name,
            'reviewer_username', rp.username,
            'decision', r.decision::text,
            'score', r.score,
            'notes', r.notes,
            'reviewed_at', r.reviewed_at
          )
          order by r.reviewed_at desc
        ) filter (where r.id is not null),
        '[]'::jsonb
      ) as review_history
      from public.reviews r
      left join public.profiles rp on rp.user_id = r.reviewer_id
      where r.translation_suggestion_id = bs.suggestion_id
    ) review_history on true
    left join lateral (
      select coalesce(
        jsonb_agg(
          jsonb_build_object(
            'suggestion_id', ts.id,
            'version_number', ts.version_number,
            'status', ts.status::text,
            'suggestion_text', ts.suggestion_text,
            'author_id', ts.author_id,
            'author_name', p.display_name,
            'author_username', p.username,
            'created_at', ts.created_at,
            'supersedes_suggestion_id', ts.supersedes_suggestion_id
          )
          order by ts.version_number desc, ts.created_at desc
        ) filter (where ts.id is not null),
        '[]'::jsonb
      ) as other_suggestions
      from public.translation_suggestions ts
      left join public.profiles p on p.user_id = ts.author_id
      where ts.translation_key_id = bs.translation_key_id
        and ts.target_language_id = bs.target_language_id
        and ts.id <> bs.suggestion_id
    ) other_suggestions on true
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
      where g.language_id = bs.target_language_id
        and g.status = 'approved'
        and (
          lower(regexp_replace(trim(coalesce(g.category, '')), '\s+', '_', 'g')) = lower(regexp_replace(trim(coalesce(bs.category, '')), '\s+', '_', 'g'))
          or lower(regexp_replace(trim(coalesce(g.subcategory, '')), '\s+', '_', 'g')) = lower(regexp_replace(trim(coalesce(bs.subcategory, '')), '\s+', '_', 'g'))
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
    coalesce(t.total_available, 0) as total_available,
    count(ir.suggestion_id)::bigint as loaded_count,
    np.normalized_batch_size as batch_size,
    np.normalized_session_offset as session_offset,
    coalesce(t.total_available, 0) > (np.normalized_session_offset + count(ir.suggestion_id)) as has_more,
    coalesce(
      jsonb_agg(
        jsonb_build_object(
          'suggestion_id', ir.suggestion_id,
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
          'suggestion_text', ir.suggestion_text,
          'rationale', ir.rationale,
          'notes', ir.notes,
          'status', ir.status,
          'version_number', ir.version_number,
          'author_id', ir.author_id,
          'author_name', ir.author_name,
          'author_username', ir.author_username,
          'created_at', ir.created_at,
          'confidence', ir.confidence,
          'review_history', ir.review_history,
          'other_suggestions', ir.other_suggestions,
          'glossary_terms', ir.glossary_terms
        )
        order by ir.queue_rank asc
      ) filter (where ir.suggestion_id is not null),
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
    t.total_available,
    np.normalized_batch_size,
    np.normalized_session_offset;
$$;

grant execute on function public.review_workspace_session(text, integer, integer) to authenticated;

create or replace function public.review_workspace_submit(
  suggestion_id uuid,
  review_decision text,
  notes text default null,
  correction_text text default null
)
returns table (
  review_id uuid,
  reviewed_suggestion_id uuid,
  decision text,
  correction_suggestion_id uuid,
  created_at timestamptz
)
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  v_suggestion record;
  v_review_id uuid;
  v_correction_id uuid;
  v_notes text;
  v_correction_text text;
  v_version_number integer;
  v_decision text;
  v_confidence record;
  v_next_status public.translation_suggestion_status;
  v_report_id uuid;
begin
  if auth.uid() is null then
    raise exception 'Authentication required';
  end if;

  v_decision := lower(trim(coalesce(review_decision, '')));
  v_notes := nullif(trim(coalesce(notes, '')), '');
  v_correction_text := nullif(trim(coalesce(correction_text, '')), '');

  if v_decision not in ('approve', 'request_changes', 'reject', 'flag') then
    raise exception 'Invalid review decision';
  end if;

  select
    ts.id,
    ts.translation_key_id,
    ts.target_language_id,
    ts.status,
    ts.suggestion_text,
    ts.author_id
  into v_suggestion
  from public.translation_suggestions ts
  where ts.id = suggestion_id
  for update;

  if v_suggestion.id is null then
    raise exception 'Suggestion not found';
  end if;

  if v_suggestion.author_id = auth.uid() then
    raise exception 'You cannot review your own translation';
  end if;

  if not public.can_review_translation_suggestion(suggestion_id) then
    raise exception 'Not authorized to review this suggestion';
  end if;

  if v_decision in ('request_changes', 'reject') and v_notes is null then
    raise exception 'A review comment is required for this decision';
  end if;

  if v_decision = 'flag' and v_correction_text is null then
    raise exception 'Correction text is required for suggest correction';
  end if;

  insert into public.reviews (
    translation_suggestion_id,
    reviewer_id,
    decision,
    score,
    notes
  ) values (
    suggestion_id,
    auth.uid(),
    v_decision::public.review_decision,
    case
      when v_decision = 'approve' then 5
      when v_decision = 'request_changes' then -1
      when v_decision = 'reject' then -3
      else 0
    end,
    v_notes
  )
  returning id into v_review_id;

  update public.translation_suggestions
  set
    status = case
      when status in ('draft', 'pending') then 'reviewing'
      else status
    end,
    updated_by = auth.uid(),
    updated_at = timezone('utc', now())
  where id = suggestion_id;

  if v_decision = 'approve' then
    select * into v_confidence
    from public.translation_confidence_for_suggestion(suggestion_id);

    if coalesce(v_confidence.verified_ready, false) then
      v_next_status := 'official';
    elsif coalesce(v_confidence.confidence_score, 0) >= 70 then
      v_next_status := 'approved';
    else
      v_next_status := 'reviewing';
    end if;

    update public.translation_suggestions
    set
      status = v_next_status,
      updated_by = auth.uid(),
      updated_at = timezone('utc', now())
    where id = suggestion_id;

    update public.translation_keys
    set
      current_suggestion_id = suggestion_id,
      updated_by = auth.uid(),
      updated_at = timezone('utc', now())
    where id = v_suggestion.translation_key_id;
  elsif v_decision = 'request_changes' then
    update public.translation_suggestions
    set
      status = 'needs_changes',
      updated_by = auth.uid(),
      updated_at = timezone('utc', now())
    where id = suggestion_id;
  elsif v_decision = 'reject' then
    update public.translation_suggestions
    set
      status = 'rejected',
      updated_by = auth.uid(),
      updated_at = timezone('utc', now())
    where id = suggestion_id;
  else
    select coalesce(max(ts.version_number), 0) + 1
      into v_version_number
    from public.translation_suggestions ts
    where ts.translation_key_id = v_suggestion.translation_key_id
      and ts.target_language_id = v_suggestion.target_language_id;

    insert into public.translation_suggestions (
      translation_key_id,
      target_language_id,
      author_id,
      supersedes_suggestion_id,
      version_number,
      suggestion_text,
      rationale,
      notes,
      status
    ) values (
      v_suggestion.translation_key_id,
      v_suggestion.target_language_id,
      auth.uid(),
      suggestion_id,
      v_version_number,
      v_correction_text,
      v_notes,
      null,
      'pending'
    )
    returning id into v_correction_id;

    update public.translation_suggestions
    set
      status = 'reported',
      updated_by = auth.uid(),
      updated_at = timezone('utc', now())
    where id = suggestion_id;

    insert into public.reports (
      reporter_id,
      report_target_type,
      translation_suggestion_id,
      reported_user_id,
      details,
      status
    ) values (
      auth.uid(),
      'translation_suggestion',
      suggestion_id,
      v_suggestion.author_id,
      coalesce(v_notes, 'Reported during review'),
      'open'
    )
    returning id into v_report_id;

    update public.translation_keys
    set
      current_suggestion_id = v_correction_id,
      updated_by = auth.uid(),
      updated_at = timezone('utc', now())
    where id = v_suggestion.translation_key_id;
  end if;

  return query
  select
    v_review_id,
    suggestion_id,
    v_decision,
    v_correction_id,
    timezone('utc', now());
end;
$$;

grant execute on function public.review_workspace_submit(uuid, text, text, text) to authenticated;

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
        and ts.status <> 'draft'
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
        and ts.status in ('reviewing', 'approved', 'official', 'needs_changes', 'rejected', 'reported')
    )
  ),
  official_total as (
    select count(distinct tk.id)::bigint as official_strings
    from public.translation_keys tk
    where exists (
      select 1
      from public.translation_suggestions ts
      where ts.translation_key_id = tk.id
        and ts.target_language_id = tk.source_language_id
        and ts.status = 'official'
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
        else round((ot.official_strings::numeric / st.total_strings::numeric) * 100, 2)::numeric(5,2)
      end as official_percent
    from strings_total st
    cross join official_total ot
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
      count(distinct tk.id) filter (where ts.status = 'official')::bigint as official_count
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
    select l.id, l.code, l.name, l.native_name, l.emoji, l.direction
    from public.languages l
    where l.is_active
      and lower(l.code) = lower(trim(coalesce(language_code, '')))
    limit 1
  ),
  coverage as (
    select c.*
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
          and ts.status = 'official'
      ) as has_official
    from public.translation_keys tk
    join selected_language sl on sl.id = tk.source_language_id
  ),
  category_definitions as (
    select * from (
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
    select coalesce(
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
    select coalesce(jsonb_agg(mr.member_payload order by mr.contribution_score desc, mr.joined_at asc, mr.member_rank asc), '[]'::jsonb) as members,
           count(*)::bigint as member_count
    from member_rows mr
    where mr.role = 'translator'
  ),
  trusted_translator_members as (
    select coalesce(jsonb_agg(mr.member_payload order by mr.contribution_score desc, mr.joined_at asc, mr.member_rank asc), '[]'::jsonb) as members,
           count(*)::bigint as member_count
    from member_rows mr
    where mr.role = 'trusted_translator'
  ),
  reviewer_members as (
    select coalesce(jsonb_agg(mr.member_payload order by mr.contribution_score desc, mr.joined_at asc, mr.member_rank asc), '[]'::jsonb) as members,
           count(*)::bigint as member_count
    from member_rows mr
    where mr.role = 'reviewer'
  ),
  moderator_members as (
    select coalesce(jsonb_agg(mr.member_payload order by mr.contribution_score desc, mr.joined_at asc, mr.member_rank asc), '[]'::jsonb) as members,
           count(*)::bigint as member_count
    from member_rows mr
    where mr.role = 'language_moderator'
  ),
  team_sections as (
    select jsonb_build_array(
      jsonb_build_object('role', 'translator', 'count', tm.member_count, 'members', tm.members),
      jsonb_build_object('role', 'trusted_translator', 'count', ttm.member_count, 'members', ttm.members),
      jsonb_build_object('role', 'reviewer', 'count', rm.member_count, 'members', rm.members),
      jsonb_build_object('role', 'language_moderator', 'count', mm.member_count, 'members', mm.members)
    ) as team_sections
    from translator_members tm
    cross join trusted_translator_members ttm
    cross join reviewer_members rm
    cross join moderator_members mm
  ),
  team_members as (
    select coalesce(jsonb_agg(mr.member_payload order by mr.member_rank asc) filter (where mr.member_rank <= 12), '[]'::jsonb) as team_members
    from member_rows mr
  ),
  top_contributors as (
    select coalesce(jsonb_agg(mr.member_payload order by mr.contribution_score desc, mr.member_rank asc) filter (where mr.member_rank <= 5), '[]'::jsonb) as top_contributors
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
      jsonb_build_object('slug', 'translations', 'label', 'Translations', 'value', c.translation_keys, 'hint', 'Source strings tracked'),
      jsonb_build_object('slug', 'suggestions', 'label', 'Suggestions', 'value', c.translation_suggestions, 'hint', 'Community proposals'),
      jsonb_build_object('slug', 'reviewed', 'label', 'Reviewed', 'value', c.reviewed_count, 'hint', 'Quality checks completed'),
      jsonb_build_object('slug', 'official', 'label', 'Official', 'value', c.official_count, 'hint', 'Finalized translations'),
      jsonb_build_object('slug', 'glossary', 'label', 'Glossary', 'value', c.glossary_terms + c.glossary_proposals, 'hint', 'Terminology coverage')
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

create or replace function public.public_language_progress()
returns table (
  language_id uuid,
  code text,
  name text,
  native_name text,
  direction text,
  emoji text,
  active_translators bigint,
  active_reviewers bigint,
  active_moderators bigint,
  translation_keys bigint,
  translation_suggestions bigint,
  approved_suggestions bigint,
  glossary_terms bigint,
  glossary_proposals bigint,
  progress_percent numeric(5,2)
)
language sql
stable
security definer
set search_path = public, auth
as $$
  with membership_totals as (
    select
      lm.language_id,
      count(*) filter (where lm.is_active and public.role_rank(lm.role::text) >= public.role_rank('translator'))::bigint as active_translators,
      count(*) filter (where lm.is_active and public.role_rank(lm.role::text) >= public.role_rank('reviewer'))::bigint as active_reviewers,
      count(*) filter (where lm.is_active and public.role_rank(lm.role::text) >= public.role_rank('language_moderator'))::bigint as active_moderators
    from public.language_members lm
    group by lm.language_id
  ),
  key_totals as (
    select
      tk.source_language_id as language_id,
      count(*)::bigint as translation_keys
    from public.translation_keys tk
    group by tk.source_language_id
  ),
  suggestion_totals as (
    select
      ts.target_language_id as language_id,
      count(*)::bigint as translation_suggestions,
      count(*) filter (where ts.status = 'official')::bigint as approved_suggestions
    from public.translation_suggestions ts
    group by ts.target_language_id
  ),
  glossary_totals as (
    select
      g.language_id,
      count(*)::bigint as glossary_terms
    from public.glossary g
    group by g.language_id
  ),
  glossary_proposal_totals as (
    select
      gp.language_id,
      count(*)::bigint as glossary_proposals
    from public.glossary_proposals gp
    group by gp.language_id
  )
  select
    l.id as language_id,
    l.code,
    l.name,
    l.native_name,
    l.direction::text as direction,
    l.emoji,
    coalesce(m.active_translators, 0) as active_translators,
    coalesce(m.active_reviewers, 0) as active_reviewers,
    coalesce(m.active_moderators, 0) as active_moderators,
    coalesce(k.translation_keys, 0) as translation_keys,
    coalesce(s.translation_suggestions, 0) as translation_suggestions,
    coalesce(s.approved_suggestions, 0) as approved_suggestions,
    coalesce(g.glossary_terms, 0) as glossary_terms,
    coalesce(gp.glossary_proposals, 0) as glossary_proposals,
    case
      when coalesce(k.translation_keys, 0) = 0 then 0::numeric(5,2)
      else round(
        (coalesce(s.approved_suggestions, 0)::numeric / greatest(k.translation_keys, 1)::numeric) * 100,
        2
      )::numeric(5,2)
    end as progress_percent
  from public.languages l
  left join membership_totals m on m.language_id = l.id
  left join key_totals k on k.language_id = l.id
  left join suggestion_totals s on s.language_id = l.id
  left join glossary_totals g on g.language_id = l.id
  left join glossary_proposal_totals gp on gp.language_id = l.id
  where l.is_active
  order by l.sort_order asc, l.name asc;
$$;

grant execute on function public.public_language_progress() to anon, authenticated;

commit;
