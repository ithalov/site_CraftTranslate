begin;

alter type public.member_role add value if not exists 'user';
alter type public.member_role add value if not exists 'translator';
alter type public.member_role add value if not exists 'trusted_translator';
alter type public.member_role add value if not exists 'reviewer';
alter type public.member_role add value if not exists 'language_moderator';
alter type public.member_role add value if not exists 'owner';

create or replace function public.role_rank(role_name text)
returns integer
language sql
immutable
as $$
  select case role_name
    when 'user' then 10
    when 'member' then 10
    when 'translator' then 20
    when 'trusted_translator' then 30
    when 'reviewer' then 40
    when 'moderator' then 50
    when 'language_moderator' then 50
    when 'admin' then 90
    when 'owner' then 100
    else 0
  end;
$$;

create or replace function public.current_member_role()
returns text
language sql
stable
security definer
set search_path = public, auth
as $$
  select coalesce(
    (select p.role::text from public.profiles p where p.user_id = auth.uid()),
    coalesce(auth.jwt() -> 'app_metadata' ->> 'role', 'user')
  );
$$;

create or replace function public.current_role_rank()
returns integer
language sql
stable
security definer
set search_path = public, auth
as $$
  select public.role_rank(public.current_member_role());
$$;

create or replace function public.has_global_role_at_least(min_role text)
returns boolean
language sql
stable
security definer
set search_path = public, auth
as $$
  select public.current_role_rank() >= public.role_rank(min_role);
$$;

create or replace function public.is_admin_or_owner()
returns boolean
language sql
stable
security definer
set search_path = public, auth
as $$
  select public.has_global_role_at_least('admin');
$$;

create or replace function public.is_language_member(language_uuid uuid)
returns boolean
language sql
stable
security definer
set search_path = public, auth
as $$
  select exists (
    select 1
    from public.language_members lm
    where lm.language_id = language_uuid
      and lm.user_id = auth.uid()
      and lm.is_active
  ) or public.is_admin_or_owner();
$$;

create or replace function public.has_language_role(language_uuid uuid, min_role text)
returns boolean
language sql
stable
security definer
set search_path = public, auth
as $$
  select public.is_admin_or_owner()
    or exists (
      select 1
      from public.language_members lm
      where lm.language_id = language_uuid
        and lm.user_id = auth.uid()
        and lm.is_active
        and public.role_rank(lm.role::text) >= public.role_rank(min_role)
    );
$$;

create or replace function public.can_access_translation_key(key_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public, auth
as $$
  select public.is_admin_or_owner()
    or exists (
      select 1
      from public.translation_keys tk
      where tk.id = key_id
        and public.has_language_role(tk.source_language_id, 'translator')
    );
$$;

create or replace function public.can_access_translation_suggestion(suggestion_id uuid)
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
        and (
          public.has_language_role(ts.target_language_id, 'translator')
          or public.has_language_role(tk.source_language_id, 'translator')
          or ts.author_id = auth.uid()
          or ts.status in ('draft', 'pending')
        )
    );
$$;

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
        and (
          public.has_language_role(ts.target_language_id, 'reviewer')
          or public.has_language_role(ts.target_language_id, 'language_moderator')
          or public.has_language_role(tk.source_language_id, 'reviewer')
          or public.has_language_role(tk.source_language_id, 'language_moderator')
        )
    );
$$;

create or replace function public.can_moderate_language(language_uuid uuid)
returns boolean
language sql
stable
security definer
set search_path = public, auth
as $$
  select public.has_language_role(language_uuid, 'language_moderator');
$$;

drop policy if exists "Profiles are visible to owners and admins" on public.profiles;
create policy "Profiles are visible to owners and admins"
on public.profiles
for select
using (true);

drop policy if exists "Profiles can be updated by owners and admins" on public.profiles;
create policy "Profiles can be updated by owners and admins"
on public.profiles
for update
using (auth.uid() = user_id or public.is_admin_or_owner())
with check (auth.uid() = user_id or public.is_admin_or_owner());

drop policy if exists "Languages are publicly readable" on public.languages;
create policy "Languages are publicly readable"
on public.languages
for select
using (true);

drop policy if exists "Languages can be managed by moderators and admins" on public.languages;
create policy "Languages can be managed by moderators and admins"
on public.languages
for all
using (public.is_admin_or_owner())
with check (public.is_admin_or_owner());

drop policy if exists "User languages visible to owners and admins" on public.user_languages;
create policy "User languages visible to owners and admins"
on public.user_languages
for select
using (auth.uid() = user_id or public.is_admin_or_owner());

drop policy if exists "User languages editable by owners and admins" on public.user_languages;
create policy "User languages editable by owners and admins"
on public.user_languages
for all
using (auth.uid() = user_id or public.is_admin_or_owner())
with check (auth.uid() = user_id or public.is_admin_or_owner());

drop policy if exists "Language members visible to members and admins" on public.language_members;
create policy "Language members visible to members and admins"
on public.language_members
for select
using (
  auth.uid() = user_id
  or public.can_moderate_language(language_id)
  or public.is_admin_or_owner()
);

drop policy if exists "Language members editable by members and admins" on public.language_members;
create policy "Language members editable by members and admins"
on public.language_members
for all
using (
  auth.uid() = user_id
  or public.can_moderate_language(language_id)
  or public.is_admin_or_owner()
)
with check (
  auth.uid() = user_id
  or public.can_moderate_language(language_id)
  or public.is_admin_or_owner()
);

drop policy if exists "Translation keys readable" on public.translation_keys;
create policy "Translation keys readable"
on public.translation_keys
for select
using (
  auth.uid() is not null
  and (
    public.can_access_translation_key(id)
    or created_by = auth.uid()
    or updated_by = auth.uid()
  )
);

drop policy if exists "Translation keys created by authenticated users" on public.translation_keys;
create policy "Translation keys created by authenticated users"
on public.translation_keys
for insert
with check (
  auth.uid() is not null
  and created_by = auth.uid()
  and public.has_language_role(source_language_id, 'translator')
);

drop policy if exists "Translation keys editable by owners and admins" on public.translation_keys;
create policy "Translation keys editable by owners and admins"
on public.translation_keys
for update
using (
  created_by = auth.uid()
  or updated_by = auth.uid()
  or public.can_moderate_language(source_language_id)
  or public.is_admin_or_owner()
)
with check (
  created_by = auth.uid()
  or updated_by = auth.uid()
  or public.can_moderate_language(source_language_id)
  or public.is_admin_or_owner()
);

drop policy if exists "Suggestions readable" on public.translation_suggestions;
create policy "Suggestions readable"
on public.translation_suggestions
for select
using (
  auth.uid() is not null
  and (
    public.can_access_translation_suggestion(id)
    or author_id = auth.uid()
  )
);

drop policy if exists "Suggestions created by authors" on public.translation_suggestions;
create policy "Suggestions created by authors"
on public.translation_suggestions
for insert
with check (
  auth.uid() is not null
  and author_id = auth.uid()
  and public.has_language_role(target_language_id, 'translator')
  and public.can_access_translation_key(translation_key_id)
);

drop policy if exists "Suggestions editable by authors and admins" on public.translation_suggestions;
create policy "Suggestions editable by authors and admins"
on public.translation_suggestions
for update
using (
  author_id = auth.uid()
  or public.can_moderate_language(target_language_id)
  or public.is_admin_or_owner()
)
with check (
  author_id = auth.uid()
  or public.can_moderate_language(target_language_id)
  or public.is_admin_or_owner()
);

drop policy if exists "Reviews readable" on public.reviews;
create policy "Reviews readable"
on public.reviews
for select
using (
  auth.uid() is not null
  and (
    reviewer_id = auth.uid()
    or public.can_review_translation_suggestion(translation_suggestion_id)
    or public.is_admin_or_owner()
  )
);

drop policy if exists "Reviews created by reviewers" on public.reviews;
create policy "Reviews created by reviewers"
on public.reviews
for insert
with check (
  auth.uid() is not null
  and reviewer_id = auth.uid()
  and public.can_review_translation_suggestion(translation_suggestion_id)
  and public.has_language_role(
    (select ts.target_language_id from public.translation_suggestions ts where ts.id = translation_suggestion_id),
    'reviewer'
  )
);

drop policy if exists "Reviews editable by reviewers and admins" on public.reviews;
create policy "Reviews editable by reviewers and admins"
on public.reviews
for update
using (reviewer_id = auth.uid() or public.is_admin_or_owner())
with check (reviewer_id = auth.uid() or public.is_admin_or_owner());

drop policy if exists "Votes readable" on public.translation_votes;
create policy "Votes readable"
on public.translation_votes
for select
using (
  auth.uid() is not null
  and (
    voter_id = auth.uid()
    or public.can_access_translation_suggestion(translation_suggestion_id)
  )
);

drop policy if exists "Votes created by voters" on public.translation_votes;
create policy "Votes created by voters"
on public.translation_votes
for insert
with check (
  auth.uid() is not null
  and voter_id = auth.uid()
  and public.can_access_translation_suggestion(translation_suggestion_id)
);

drop policy if exists "Votes editable by voters and admins" on public.translation_votes;
create policy "Votes editable by voters and admins"
on public.translation_votes
for update
using (voter_id = auth.uid() or public.is_admin_or_owner())
with check (voter_id = auth.uid() or public.is_admin_or_owner());

drop policy if exists "Comments readable" on public.translation_comments;
create policy "Comments readable"
on public.translation_comments
for select
using (
  auth.uid() is not null
  and (
    author_id = auth.uid()
    or public.can_access_translation_suggestion(translation_suggestion_id)
  )
);

drop policy if exists "Comments created by authors" on public.translation_comments;
create policy "Comments created by authors"
on public.translation_comments
for insert
with check (
  auth.uid() is not null
  and author_id = auth.uid()
  and public.can_access_translation_suggestion(translation_suggestion_id)
);

drop policy if exists "Comments editable by authors and admins" on public.translation_comments;
create policy "Comments editable by authors and admins"
on public.translation_comments
for update
using (author_id = auth.uid() or public.is_admin_or_owner())
with check (author_id = auth.uid() or public.is_admin_or_owner());

drop policy if exists "Glossary readable" on public.glossary;
create policy "Glossary readable"
on public.glossary
for select
using (
  auth.uid() is not null
  and (
    public.has_language_role(language_id, 'translator')
    or public.is_admin_or_owner()
  )
);

drop policy if exists "Glossary managed by moderators and admins" on public.glossary;
create policy "Glossary managed by moderators and admins"
on public.glossary
for all
using (public.can_moderate_language(language_id) or public.is_admin_or_owner())
with check (public.can_moderate_language(language_id) or public.is_admin_or_owner());

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
  proposer_id = auth.uid()
  or public.can_moderate_language(language_id)
  or public.is_admin_or_owner()
)
with check (
  proposer_id = auth.uid()
  or public.can_moderate_language(language_id)
  or public.is_admin_or_owner()
);

drop policy if exists "Badges readable" on public.badges;
create policy "Badges readable"
on public.badges
for select
using (true);

drop policy if exists "Badges managed by admins" on public.badges;
create policy "Badges managed by admins"
on public.badges
for all
using (public.is_admin_or_owner())
with check (public.is_admin_or_owner());

drop policy if exists "User badges readable" on public.user_badges;
create policy "User badges readable"
on public.user_badges
for select
using (auth.uid() = user_id or public.is_admin_or_owner());

drop policy if exists "User badges managed by admins" on public.user_badges;
create policy "User badges managed by admins"
on public.user_badges
for all
using (public.is_admin_or_owner())
with check (public.is_admin_or_owner());

drop policy if exists "Reputation events readable by owners and admins" on public.reputation_events;
create policy "Reputation events readable by owners and admins"
on public.reputation_events
for select
using (auth.uid() = user_id or public.is_admin_or_owner());

drop policy if exists "Reputation events managed by admins" on public.reputation_events;
create policy "Reputation events managed by admins"
on public.reputation_events
for all
using (public.is_admin_or_owner())
with check (public.is_admin_or_owner());

drop policy if exists "XP events readable by owners and admins" on public.xp_events;
create policy "XP events readable by owners and admins"
on public.xp_events
for select
using (auth.uid() = user_id or public.is_admin_or_owner());

drop policy if exists "XP events managed by admins" on public.xp_events;
create policy "XP events managed by admins"
on public.xp_events
for all
using (public.is_admin_or_owner())
with check (public.is_admin_or_owner());

drop policy if exists "Reports readable by reporters and admins" on public.reports;
create policy "Reports readable by reporters and admins"
on public.reports
for select
using (
  auth.uid() = reporter_id
  or public.can_moderate_language(
    coalesce(
      (select tk.source_language_id from public.translation_keys tk where tk.id = translation_key_id),
      (select ts.target_language_id from public.translation_suggestions ts where ts.id = translation_suggestion_id),
      (select g.language_id from public.glossary g where g.id = glossary_id),
      (select gp.language_id from public.glossary_proposals gp where gp.id = glossary_proposal_id)
    )
  )
  or public.is_admin_or_owner()
);

drop policy if exists "Reports created by reporters" on public.reports;
create policy "Reports created by reporters"
on public.reports
for insert
with check (auth.uid() is not null and reporter_id = auth.uid());

drop policy if exists "Reports editable by admins" on public.reports;
create policy "Reports editable by admins"
on public.reports
for update
using (public.is_admin_or_owner())
with check (public.is_admin_or_owner());

drop policy if exists "Donations readable by owners and admins" on public.donations;
create policy "Donations readable by owners and admins"
on public.donations
for select
using (auth.uid() = user_id or public.is_admin_or_owner());

drop policy if exists "Donations created by owners" on public.donations;
create policy "Donations created by owners"
on public.donations
for insert
with check (auth.uid() is not null and user_id = auth.uid());

drop policy if exists "Donations editable by admins" on public.donations;
create policy "Donations editable by admins"
on public.donations
for update
using (public.is_admin_or_owner())
with check (public.is_admin_or_owner());

alter table public.profiles force row level security;
alter table public.languages force row level security;
alter table public.user_languages force row level security;
alter table public.language_members force row level security;
alter table public.translation_keys force row level security;
alter table public.translation_suggestions force row level security;
alter table public.reviews force row level security;
alter table public.translation_votes force row level security;
alter table public.translation_comments force row level security;
alter table public.glossary force row level security;
alter table public.glossary_proposals force row level security;
alter table public.badges force row level security;
alter table public.user_badges force row level security;
alter table public.reputation_events force row level security;
alter table public.xp_events force row level security;
alter table public.reports force row level security;
alter table public.donations force row level security;

commit;
