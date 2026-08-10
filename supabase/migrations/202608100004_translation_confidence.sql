begin;

drop function if exists public.translation_confidence_for_suggestion(uuid);
drop function if exists public.review_workspace_session(text, integer, integer);
drop function if exists public.review_workspace_submit(uuid, text, text, text);

create or replace function public.translation_confidence_for_suggestion(
  suggestion_uuid uuid
)
returns table (
  confidence_level text,
  confidence_score numeric(5,2),
  valid_reviews bigint,
  distinct_reviewers bigint,
  approved_reviews bigint,
  request_changes_reviews bigint,
  rejected_reviews bigint,
  agreement_rate numeric(5,2),
  reviewer_trust_score numeric(5,2),
  open_reports bigint,
  final_status text,
  verified_ready boolean,
  signals jsonb
)
language sql
stable
security definer
set search_path = public, auth
as $$
  with suggestion as (
    select
      ts.id as suggestion_id,
      ts.translation_key_id,
      ts.author_id,
      ts.status::text as final_status
    from public.translation_suggestions ts
    where ts.id = suggestion_uuid
    limit 1
  ),
  review_stats as (
    select
      count(*) filter (where r.decision in ('approve', 'request_changes', 'reject'))::bigint as valid_reviews,
      count(distinct r.reviewer_id) filter (where r.decision in ('approve', 'request_changes', 'reject'))::bigint as distinct_reviewers,
      count(*) filter (where r.decision = 'approve')::bigint as approved_reviews,
      count(*) filter (where r.decision = 'request_changes')::bigint as request_changes_reviews,
      count(*) filter (where r.decision = 'reject')::bigint as rejected_reviews
    from public.reviews r
    join suggestion s on s.suggestion_id = r.translation_suggestion_id
    where r.reviewer_id <> s.author_id
  ),
  reviewer_reputation as (
    select
      coalesce(
        avg(
          greatest(
            least(
              (coalesce(rep.reputation_score, 0) + 100)::numeric / 200::numeric * 100,
              100
            ),
            0
          )
        ),
        0
      )::numeric(5,2) as reviewer_trust_score
    from (
      select distinct r.reviewer_id
      from public.reviews r
      join suggestion s on s.suggestion_id = r.translation_suggestion_id
      where r.decision in ('approve', 'request_changes', 'reject')
        and r.reviewer_id <> s.author_id
    ) reviewers
    left join lateral (
      select coalesce(sum(re.delta), 0)::bigint as reputation_score
      from public.reputation_events re
      where re.user_id = reviewers.reviewer_id
    ) rep on true
  ),
  report_stats as (
    select count(*)::bigint as open_reports
    from public.reports rp
    join suggestion s on true
    where rp.status in ('open', 'under_review')
      and (
        rp.translation_suggestion_id = s.suggestion_id
        or rp.translation_key_id = s.translation_key_id
      )
  ),
  aggregates as (
    select
      s.final_status,
      coalesce(rs.valid_reviews, 0) as valid_reviews,
      coalesce(rs.distinct_reviewers, 0) as distinct_reviewers,
      coalesce(rs.approved_reviews, 0) as approved_reviews,
      coalesce(rs.request_changes_reviews, 0) as request_changes_reviews,
      coalesce(rs.rejected_reviews, 0) as rejected_reviews,
      case
        when coalesce(rs.valid_reviews, 0) = 0 then 0::numeric(5,2)
        else round((coalesce(rs.approved_reviews, 0)::numeric / greatest(rs.valid_reviews, 1)::numeric) * 100, 2)::numeric(5,2)
      end as agreement_rate,
      coalesce(rr.reviewer_trust_score, 0)::numeric(5,2) as reviewer_trust_score,
      coalesce(rp.open_reports, 0) as open_reports
    from suggestion s
    left join review_stats rs on true
    left join reviewer_reputation rr on true
    left join report_stats rp on true
  ),
  score_parts as (
    select
      *,
      least(valid_reviews * 15, 45) as review_volume_component,
      round(agreement_rate * 0.25, 2) as agreement_component,
      round(reviewer_trust_score * 0.18, 2) as reviewer_component,
      case
        when final_status = 'approved' then 12
        when final_status = 'rejected' then -30
        when final_status = 'archived' then -10
        else 0
      end as status_component,
      least(open_reports * 20, 40) as report_penalty
    from aggregates
  )
  select
    case
      when final_status = 'approved'
        and valid_reviews >= 2
        and distinct_reviewers >= 2
        and approved_reviews >= 2
        and open_reports = 0
        and agreement_rate >= 80
        and reviewer_trust_score >= 60
        and greatest(0, least(100, review_volume_component + agreement_component + reviewer_component + status_component - report_penalty)) >= 90
      then 'VERIFIED'
      when greatest(0, least(100, review_volume_component + agreement_component + reviewer_component + status_component - report_penalty)) >= 70
      then 'HIGH'
      when greatest(0, least(100, review_volume_component + agreement_component + reviewer_component + status_component - report_penalty)) >= 40
      then 'MEDIUM'
      else 'LOW'
    end as confidence_level,
    greatest(0, least(100, review_volume_component + agreement_component + reviewer_component + status_component - report_penalty))::numeric(5,2) as confidence_score,
    valid_reviews,
    distinct_reviewers,
    approved_reviews,
    request_changes_reviews,
    rejected_reviews,
    agreement_rate,
    reviewer_trust_score,
    open_reports,
    final_status,
    (
      final_status = 'approved'
      and valid_reviews >= 2
      and distinct_reviewers >= 2
      and approved_reviews >= 2
      and open_reports = 0
      and agreement_rate >= 80
      and reviewer_trust_score >= 60
      and greatest(0, least(100, review_volume_component + agreement_component + reviewer_component + status_component - report_penalty)) >= 90
    ) as verified_ready,
    jsonb_build_object(
      'formula', 'volume + agreement + reviewer reputation + final status - reports',
      'review_volume_component', review_volume_component,
      'agreement_component', agreement_component,
      'reviewer_component', reviewer_component,
      'status_component', status_component,
      'report_penalty', report_penalty,
      'valid_reviews', valid_reviews,
      'distinct_reviewers', distinct_reviewers,
      'approved_reviews', approved_reviews,
      'request_changes_reviews', request_changes_reviews,
      'rejected_reviews', rejected_reviews,
      'agreement_rate', agreement_rate,
      'reviewer_trust_score', reviewer_trust_score,
      'open_reports', open_reports,
      'final_status', final_status,
      'verified_ready', (
        final_status = 'approved'
        and valid_reviews >= 2
        and distinct_reviewers >= 2
        and approved_reviews >= 2
        and open_reports = 0
        and agreement_rate >= 80
        and reviewer_trust_score >= 60
        and greatest(0, least(100, review_volume_component + agreement_component + reviewer_component + status_component - report_penalty)) >= 90
      )
    ) as signals
  from score_parts;
$$;

grant execute on function public.translation_confidence_for_suggestion(uuid) to authenticated;

create or replace function public.can_review_translation_suggestion(suggestion_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public, auth
as $$
  select public.is_admin_or_owner()
    or exists (
      select 1
      from public.translation_suggestions ts
      join public.translation_keys tk on tk.id = ts.translation_key_id
      where ts.id = suggestion_id
        and ts.author_id <> auth.uid()
        and (
          public.has_language_role(ts.target_language_id, 'reviewer')
          or public.has_language_role(ts.target_language_id, 'language_moderator')
          or public.has_language_role(tk.source_language_id, 'reviewer')
          or public.has_language_role(tk.source_language_id, 'language_moderator')
        )
    );
$$;

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
    select
      l.id,
      l.code,
      l.name,
      l.native_name,
      l.emoji
    from public.languages l
    where l.is_active
      and lower(l.code) = lower(trim(coalesce(target_language_code, '')))
      and public.has_language_role(l.id, 'reviewer')
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
    where ts.status = 'pending'
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
      coalesce(conf.confidence_json, '{}'::jsonb) as confidence,
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
    ) conf on true
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

  if v_decision = 'approve' then
    update public.translation_suggestions
    set
      status = 'approved',
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
      status = 'draft',
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
      status = 'archived',
      updated_by = auth.uid(),
      updated_at = timezone('utc', now())
    where id = suggestion_id;

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

drop policy if exists "Reviews created by reviewers" on public.reviews;
create policy "Reviews created by reviewers"
on public.reviews
for insert
with check (
  auth.uid() is not null
  and reviewer_id = auth.uid()
  and reviewer_id <> (
    select ts.author_id
    from public.translation_suggestions ts
    where ts.id = translation_suggestion_id
  )
  and public.can_review_translation_suggestion(translation_suggestion_id)
  and public.has_language_role(
    (select ts.target_language_id from public.translation_suggestions ts where ts.id = translation_suggestion_id),
    'reviewer'
  )
);

commit;
