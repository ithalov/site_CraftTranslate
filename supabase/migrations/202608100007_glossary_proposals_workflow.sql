begin;

drop function if exists public.submit_glossary_proposal(text, text, text, text, text, text, text, text, boolean, uuid, uuid);
drop function if exists public.review_glossary_proposal(uuid, text, text);
drop function if exists public.glossary_proposal_history(uuid);

alter type public.glossary_proposal_status add value if not exists 'needs_changes';

commit;
begin;

alter table public.glossary_proposals
  add column if not exists proposed_original_term text,
  add column if not exists proposed_recommended_translation text,
  add column if not exists proposed_category text,
  add column if not exists proposed_subcategory text,
  add column if not exists proposed_rule text,
  add column if not exists proposed_notes text,
  add column if not exists proposed_do_not_translate boolean not null default false,
  add column if not exists decision_notes text,
  add column if not exists decision_at timestamptz,
  add column if not exists decision_by uuid references auth.users (id) on delete set null;

update public.glossary_proposals
set
  proposed_original_term = coalesce(nullif(trim(proposed_original_term), ''), nullif(trim(proposed_term), '')),
  proposed_recommended_translation = coalesce(nullif(trim(proposed_recommended_translation), ''), nullif(trim(proposed_definition), '')),
  proposed_category = coalesce(nullif(trim(proposed_category), ''), 'general'),
  proposed_subcategory = nullif(trim(proposed_subcategory), ''),
  proposed_rule = nullif(trim(proposed_rule), ''),
  proposed_notes = coalesce(nullif(trim(proposed_notes), ''), nullif(trim(rationale), '')),
  proposed_do_not_translate = coalesce(proposed_do_not_translate, false)
where
  proposed_original_term is null
  or proposed_recommended_translation is null
  or proposed_category is null
  or proposed_subcategory is null
  or proposed_rule is null
  or proposed_notes is null;

create table if not exists public.glossary_proposal_events (
  id uuid primary key default gen_random_uuid(),
  glossary_proposal_id uuid not null references public.glossary_proposals (id) on delete cascade,
  actor_id uuid references auth.users (id) on delete set null,
  action text not null,
  previous_status public.glossary_proposal_status not null,
  new_status public.glossary_proposal_status not null,
  notes text,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default timezone('utc', now()),
  constraint glossary_proposal_events_action_check check (
    action in ('submitted', 'approved', 'rejected', 'needs_changes', 'updated')
  ),
  constraint glossary_proposal_events_notes_not_empty check (notes is null or length(trim(notes)) > 0)
);

alter table public.glossary_proposal_events enable row level security;

create index if not exists glossary_proposal_events_proposal_created_at_idx
  on public.glossary_proposal_events (glossary_proposal_id, created_at desc);

drop trigger if exists set_glossary_proposal_defaults on public.glossary_proposals;
create or replace function public.set_glossary_proposal_defaults()
returns trigger
language plpgsql
as $$
begin
  new.proposed_original_term := coalesce(nullif(trim(new.proposed_original_term), ''), nullif(trim(new.proposed_term), ''));
  new.proposed_recommended_translation := coalesce(nullif(trim(new.proposed_recommended_translation), ''), nullif(trim(new.proposed_definition), ''));
  new.proposed_category := coalesce(nullif(trim(new.proposed_category), ''), 'general');
  new.proposed_subcategory := nullif(trim(new.proposed_subcategory), '');
  new.proposed_rule := nullif(trim(new.proposed_rule), '');
  new.proposed_notes := coalesce(nullif(trim(new.proposed_notes), ''), nullif(trim(new.rationale), ''));
  new.proposed_do_not_translate := coalesce(new.proposed_do_not_translate, false);
  new.proposed_term := coalesce(nullif(trim(new.proposed_term), ''), new.proposed_original_term);
  new.proposed_definition := coalesce(nullif(trim(new.proposed_definition), ''), new.proposed_recommended_translation);
  return new;
end;
$$;

drop trigger if exists sync_glossary_proposal_columns on public.glossary_proposals;
create trigger sync_glossary_proposal_columns
before insert or update on public.glossary_proposals
for each row
execute function public.set_glossary_proposal_defaults();

create or replace function public.submit_glossary_proposal(
  language_code text,
  p_proposed_original_term text,
  p_proposed_recommended_translation text,
  p_proposed_category text,
  rationale text default null,
  p_proposed_subcategory text default null,
  p_proposed_rule text default null,
  p_proposed_notes text default null,
  p_proposed_do_not_translate boolean default false,
  glossary_id uuid default null,
  source_translation_key_id uuid default null
)
returns table (
  id uuid,
  language_id uuid,
  status public.glossary_proposal_status,
  proposed_original_term text,
  proposed_recommended_translation text,
  proposed_category text,
  created_at timestamptz
)
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  v_user_id uuid := auth.uid();
  v_language_id uuid;
  v_proposal public.glossary_proposals%rowtype;
begin
  if v_user_id is null then
    raise exception 'Not authenticated';
  end if;

  select l.id
  into v_language_id
  from public.languages l
  where l.is_active
    and lower(l.code) = lower(trim(coalesce(language_code, '')))
  limit 1;

  if v_language_id is null then
    raise exception 'Language not found';
  end if;

  insert into public.glossary_proposals (
    glossary_id,
    language_id,
    proposed_term,
    proposed_definition,
    proposed_original_term,
    proposed_recommended_translation,
    proposed_category,
    proposed_subcategory,
    proposed_rule,
    proposed_notes,
    proposed_do_not_translate,
    proposer_id,
    reviewer_id,
    source_translation_key_id,
    rationale,
    status
  )
  values (
    glossary_id,
    v_language_id,
    coalesce(nullif(trim(p_proposed_original_term), ''), nullif(trim(p_proposed_recommended_translation), '')),
    coalesce(nullif(trim(p_proposed_recommended_translation), ''), nullif(trim(p_proposed_original_term), '')),
    coalesce(nullif(trim(p_proposed_original_term), ''), nullif(trim(p_proposed_recommended_translation), '')),
    coalesce(nullif(trim(p_proposed_recommended_translation), ''), nullif(trim(p_proposed_original_term), '')),
    coalesce(nullif(trim(p_proposed_category), ''), 'general'),
    nullif(trim(p_proposed_subcategory), ''),
    nullif(trim(p_proposed_rule), ''),
    coalesce(nullif(trim(p_proposed_notes), ''), nullif(trim(rationale), '')),
    coalesce(p_proposed_do_not_translate, false),
    v_user_id,
    null,
    source_translation_key_id,
    nullif(trim(rationale), ''),
    'pending'
  )
  returning * into v_proposal;

  insert into public.glossary_proposal_events (
    glossary_proposal_id,
    actor_id,
    action,
    previous_status,
    new_status,
    notes
  )
  values (
    v_proposal.id,
    v_user_id,
    'submitted',
    'pending',
    'pending',
    coalesce(nullif(trim(rationale), ''), nullif(trim(p_proposed_notes), ''))
  );

  return query
  select
    v_proposal.id,
    v_proposal.language_id,
    v_proposal.status,
    v_proposal.proposed_original_term,
    v_proposal.proposed_recommended_translation,
    v_proposal.proposed_category,
    v_proposal.created_at;
end;
$$;

create or replace function public.review_glossary_proposal(
  proposal_id uuid,
  decision text,
  notes text default null
)
returns table (
  id uuid,
  status public.glossary_proposal_status,
  reviewer_id uuid,
  decision_at timestamptz,
  glossary_id uuid
)
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  v_user_id uuid := auth.uid();
  v_proposal public.glossary_proposals%rowtype;
  v_previous_status public.glossary_proposal_status;
  v_new_status public.glossary_proposal_status;
  v_glossary_id uuid;
  v_decision text := lower(trim(coalesce(decision, '')));
begin
  if v_user_id is null then
    raise exception 'Not authenticated';
  end if;

  select *
  into v_proposal
  from public.glossary_proposals
  where id = proposal_id
  limit 1;

  if not found then
    raise exception 'Glossary proposal not found';
  end if;

  if not (public.can_moderate_language(v_proposal.language_id) or public.is_admin_or_owner()) then
    raise exception 'Not allowed';
  end if;

  v_previous_status := v_proposal.status;

  if v_decision = 'approve' then
    v_new_status := 'approved';

    if v_proposal.glossary_id is not null then
      update public.glossary
      set
        term = v_proposal.proposed_original_term,
        original_term = v_proposal.proposed_original_term,
        recommended_translation = v_proposal.proposed_recommended_translation,
        definition = coalesce(v_proposal.proposed_notes, v_proposal.proposed_rule, v_proposal.proposed_recommended_translation),
        category = v_proposal.proposed_category,
        subcategory = v_proposal.proposed_subcategory,
        rule = v_proposal.proposed_rule,
        notes = v_proposal.proposed_notes,
        do_not_translate = coalesce(v_proposal.proposed_do_not_translate, false),
        updated_by = v_user_id,
        updated_at = timezone('utc', now())
      where id = v_proposal.glossary_id
      returning id into v_glossary_id;
    else
      insert into public.glossary (
        language_id,
        term,
        original_term,
        definition,
        recommended_translation,
        category,
        subcategory,
        rule,
        notes,
        do_not_translate,
        status,
        created_by,
        updated_by
      )
      values (
        v_proposal.language_id,
        v_proposal.proposed_original_term,
        v_proposal.proposed_original_term,
        coalesce(v_proposal.proposed_notes, v_proposal.proposed_rule, v_proposal.proposed_recommended_translation),
        v_proposal.proposed_recommended_translation,
        v_proposal.proposed_category,
        v_proposal.proposed_subcategory,
        v_proposal.proposed_rule,
        v_proposal.proposed_notes,
        coalesce(v_proposal.proposed_do_not_translate, false),
        'approved',
        v_user_id,
        v_user_id
      )
      returning id into v_glossary_id;
    end if;
  elsif v_decision = 'reject' then
    v_new_status := 'rejected';
  elsif v_decision = 'request_changes' then
    v_new_status := 'needs_changes';
  else
    raise exception 'Invalid decision';
  end if;

  update public.glossary_proposals
  set
    status = v_new_status,
    reviewer_id = v_user_id,
    decision_by = v_user_id,
    decision_at = timezone('utc', now()),
    decision_notes = nullif(trim(notes), ''),
    glossary_id = coalesce(v_glossary_id, glossary_id),
    updated_at = timezone('utc', now())
  where id = proposal_id
  returning glossary_id into v_glossary_id;

  insert into public.glossary_proposal_events (
    glossary_proposal_id,
    actor_id,
    action,
    previous_status,
    new_status,
    notes
  )
  values (
    proposal_id,
    v_user_id,
    case
      when v_decision = 'approve' then 'approved'
      when v_decision = 'reject' then 'rejected'
      else 'needs_changes'
    end,
    v_previous_status,
    v_new_status,
    nullif(trim(notes), '')
  );

  return query
  select
    proposal_id,
    v_new_status,
    v_user_id,
    timezone('utc', now()),
    v_glossary_id;
end;
$$;

create or replace function public.glossary_proposal_history(proposal_id uuid)
returns table (
  event_id uuid,
  glossary_proposal_id uuid,
  action text,
  previous_status public.glossary_proposal_status,
  new_status public.glossary_proposal_status,
  notes text,
  actor_id uuid,
  actor_name text,
  actor_username text,
  actor_avatar_url text,
  created_at timestamptz
)
language sql
stable
security definer
set search_path = public, auth
as $$
  select
    e.id as event_id,
    e.glossary_proposal_id,
    e.action,
    e.previous_status,
    e.new_status,
    e.notes,
    e.actor_id,
    coalesce(p.display_name, p.username, u.email) as actor_name,
    p.username as actor_username,
    p.avatar_url as actor_avatar_url,
    e.created_at
  from public.glossary_proposal_events e
  left join public.profiles p on p.user_id = e.actor_id
  left join auth.users u on u.id = e.actor_id
  where e.glossary_proposal_id = proposal_id
  order by e.created_at asc;
$$;

grant execute on function public.submit_glossary_proposal(text, text, text, text, text, text, text, text, boolean, uuid, uuid) to authenticated;
grant execute on function public.review_glossary_proposal(uuid, text, text) to authenticated;
grant execute on function public.glossary_proposal_history(uuid) to authenticated;

drop policy if exists "Glossary managed by moderators and admins" on public.glossary;
create policy "Glossary managed by admins"
on public.glossary
for all
using (public.is_admin_or_owner())
with check (public.is_admin_or_owner());

drop policy if exists "Glossary proposals readable" on public.glossary_proposals;
create policy "Glossary proposals readable"
on public.glossary_proposals
for select
using (
  auth.uid() is not null
  and (
    proposer_id = auth.uid()
    or reviewer_id = auth.uid()
    or public.can_moderate_language(language_id)
    or public.is_admin_or_owner()
  )
);

drop policy if exists "Glossary proposals created by proposers" on public.glossary_proposals;
create policy "Glossary proposals created by proposers"
on public.glossary_proposals
for insert
with check (
  auth.uid() is not null
  and proposer_id = auth.uid()
  and public.has_language_role(language_id, 'translator')
);

drop policy if exists "Glossary proposals editable by proposers and admins" on public.glossary_proposals;
create policy "Glossary proposals editable by proposers and admins"
on public.glossary_proposals
for update
using (
  (
    proposer_id = auth.uid()
    and status in ('pending', 'needs_changes')
  )
  or public.is_admin_or_owner()
)
with check (
  (
    proposer_id = auth.uid()
    and status in ('pending', 'needs_changes')
  )
  or public.is_admin_or_owner()
);

drop policy if exists "Glossary proposal events readable" on public.glossary_proposal_events;
create policy "Glossary proposal events readable"
on public.glossary_proposal_events
for select
using (
  auth.uid() is not null
  and exists (
    select 1
    from public.glossary_proposals gp
    where gp.id = glossary_proposal_id
      and (
        gp.proposer_id = auth.uid()
        or public.can_moderate_language(gp.language_id)
        or public.is_admin_or_owner()
      )
  )
);

alter table public.glossary force row level security;
alter table public.glossary_proposals force row level security;
alter table public.glossary_proposal_events force row level security;

commit;
