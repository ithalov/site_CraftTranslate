begin;

create extension if not exists pgcrypto;

do $$
begin
  create type public.member_role as enum ('member', 'moderator', 'admin');
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create type public.language_direction as enum ('ltr', 'rtl');
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create type public.translation_status as enum ('draft', 'in_review', 'published', 'archived');
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create type public.review_status as enum ('pending', 'needs_changes', 'approved', 'rejected');
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create type public.term_status as enum ('draft', 'approved', 'deprecated');
exception
  when duplicate_object then null;
end $$;

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = timezone('utc', now());
  return new;
end;
$$;

create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = public, auth
as $$
  select coalesce((auth.jwt() -> 'app_metadata' ->> 'role'), '') = 'admin';
$$;

create or replace function public.is_moderator_or_admin()
returns boolean
language sql
stable
security definer
set search_path = public, auth
as $$
  select coalesce((auth.jwt() -> 'app_metadata' ->> 'role'), '') in ('moderator', 'admin');
$$;

create table if not exists public.profiles (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null unique references auth.users (id) on delete cascade,
  username text,
  display_name text,
  avatar_url text,
  bio text,
  preferred_locale text not null default 'en-US',
  role public.member_role not null default 'member',
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

create table if not exists public.languages (
  code text primary key,
  name text not null,
  native_name text not null,
  direction public.language_direction not null default 'ltr',
  emoji text,
  is_active boolean not null default true,
  sort_order integer not null default 0,
  created_by uuid references public.profiles (user_id) on delete set null,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

create table if not exists public.translation_entries (
  id uuid primary key default gen_random_uuid(),
  source_language_code text not null references public.languages (code) on update cascade on delete restrict,
  target_language_code text not null references public.languages (code) on update cascade on delete restrict,
  source_text text not null,
  translated_text text,
  context text,
  metadata jsonb not null default '{}'::jsonb,
  status public.translation_status not null default 'draft',
  author_id uuid references auth.users (id) on delete set null,
  reviewer_id uuid references auth.users (id) on delete set null,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

create table if not exists public.review_assignments (
  id uuid primary key default gen_random_uuid(),
  translation_entry_id uuid not null references public.translation_entries (id) on delete cascade,
  assigned_to uuid references auth.users (id) on delete set null,
  reviewed_by uuid references auth.users (id) on delete set null,
  review_status public.review_status not null default 'pending',
  notes text,
  due_at timestamptz,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

create table if not exists public.glossary_terms (
  id uuid primary key default gen_random_uuid(),
  term text not null,
  definition text not null,
  language_code text references public.languages (code) on update cascade on delete set null,
  aliases text[] not null default '{}'::text[],
  examples text[] not null default '{}'::text[],
  tags text[] not null default '{}'::text[],
  status public.term_status not null default 'draft',
  created_by uuid references auth.users (id) on delete set null,
  updated_by uuid references auth.users (id) on delete set null,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

create table if not exists public.leaderboard_snapshots (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  snapshot_date date not null default current_date,
  translation_contributions integer not null default 0,
  review_contributions integer not null default 0,
  language_contributions integer not null default 0,
  points integer not null default 0,
  position integer not null,
  created_at timestamptz not null default timezone('utc', now()),
  unique (user_id, snapshot_date)
);

create index if not exists translation_entries_status_idx
  on public.translation_entries (status, created_at desc);

create index if not exists translation_entries_language_idx
  on public.translation_entries (source_language_code, target_language_code);

create index if not exists glossary_terms_language_status_idx
  on public.glossary_terms (language_code, status, term);

create index if not exists leaderboard_snapshots_date_position_idx
  on public.leaderboard_snapshots (snapshot_date desc, position asc);

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  profile_name text;
begin
  profile_name := nullif(
    coalesce(
      new.raw_user_meta_data ->> 'display_name',
      new.raw_user_meta_data ->> 'full_name',
      new.raw_user_meta_data ->> 'name',
      split_part(coalesce(new.email, ''), '@', 1)
    ),
    ''
  );

  insert into public.profiles (
    user_id,
    username,
    display_name,
    avatar_url,
    preferred_locale
  )
  values (
    new.id,
    nullif(coalesce(new.raw_user_meta_data ->> 'username', split_part(coalesce(new.email, ''), '@', 1)), ''),
    profile_name,
    nullif(new.raw_user_meta_data ->> 'avatar_url', ''),
    coalesce(nullif(new.raw_user_meta_data ->> 'locale', ''), 'en-US')
  )
  on conflict (user_id) do update
    set username = excluded.username,
        display_name = excluded.display_name,
        avatar_url = excluded.avatar_url,
        preferred_locale = excluded.preferred_locale,
        updated_at = timezone('utc', now());

  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;

create trigger on_auth_user_created
after insert on auth.users
for each row execute function public.handle_new_user();

drop trigger if exists set_profiles_updated_at on public.profiles;
create trigger set_profiles_updated_at
before update on public.profiles
for each row execute function public.set_updated_at();

drop trigger if exists set_languages_updated_at on public.languages;
create trigger set_languages_updated_at
before update on public.languages
for each row execute function public.set_updated_at();

drop trigger if exists set_translation_entries_updated_at on public.translation_entries;
create trigger set_translation_entries_updated_at
before update on public.translation_entries
for each row execute function public.set_updated_at();

drop trigger if exists set_review_assignments_updated_at on public.review_assignments;
create trigger set_review_assignments_updated_at
before update on public.review_assignments
for each row execute function public.set_updated_at();

drop trigger if exists set_glossary_terms_updated_at on public.glossary_terms;
create trigger set_glossary_terms_updated_at
before update on public.glossary_terms
for each row execute function public.set_updated_at();

alter table public.profiles enable row level security;
alter table public.languages enable row level security;
alter table public.translation_entries enable row level security;
alter table public.review_assignments enable row level security;
alter table public.glossary_terms enable row level security;
alter table public.leaderboard_snapshots enable row level security;

drop policy if exists "Profiles are visible to owners and admins" on public.profiles;
create policy "Profiles are visible to owners and admins"
on public.profiles
for select
using (user_id = auth.uid() or public.is_admin());

drop policy if exists "Profiles can be updated by owners and admins" on public.profiles;
create policy "Profiles can be updated by owners and admins"
on public.profiles
for update
using (user_id = auth.uid() or public.is_admin())
with check (user_id = auth.uid() or public.is_admin());

drop policy if exists "Languages are publicly readable" on public.languages;
create policy "Languages are publicly readable"
on public.languages
for select
using (true);

drop policy if exists "Languages can be managed by moderators and admins" on public.languages;
create policy "Languages can be managed by moderators and admins"
on public.languages
for all
using (public.is_moderator_or_admin())
with check (public.is_moderator_or_admin());

drop policy if exists "Translations are visible to collaborators" on public.translation_entries;
create policy "Translations are visible to collaborators"
on public.translation_entries
for select
using (author_id = auth.uid() or reviewer_id = auth.uid() or public.is_moderator_or_admin());

drop policy if exists "Translations can be created by authenticated users" on public.translation_entries;
create policy "Translations can be created by authenticated users"
on public.translation_entries
for insert
with check (author_id = auth.uid() or public.is_moderator_or_admin());

drop policy if exists "Translations can be edited by authors, reviewers and admins" on public.translation_entries;
create policy "Translations can be edited by authors, reviewers and admins"
on public.translation_entries
for update
using (author_id = auth.uid() or reviewer_id = auth.uid() or public.is_moderator_or_admin())
with check (author_id = auth.uid() or reviewer_id = auth.uid() or public.is_moderator_or_admin());

drop policy if exists "Review assignments are visible to assignees and admins" on public.review_assignments;
create policy "Review assignments are visible to assignees and admins"
on public.review_assignments
for select
using (assigned_to = auth.uid() or reviewed_by = auth.uid() or public.is_moderator_or_admin());

drop policy if exists "Review assignments are managed by moderators and admins" on public.review_assignments;
create policy "Review assignments are managed by moderators and admins"
on public.review_assignments
for all
using (public.is_moderator_or_admin())
with check (public.is_moderator_or_admin());

drop policy if exists "Glossary terms are publicly readable" on public.glossary_terms;
create policy "Glossary terms are publicly readable"
on public.glossary_terms
for select
using (true);

drop policy if exists "Glossary terms can be managed by moderators and admins" on public.glossary_terms;
create policy "Glossary terms can be managed by moderators and admins"
on public.glossary_terms
for all
using (public.is_moderator_or_admin())
with check (public.is_moderator_or_admin());

drop policy if exists "Leaderboard snapshots are publicly readable" on public.leaderboard_snapshots;
create policy "Leaderboard snapshots are publicly readable"
on public.leaderboard_snapshots
for select
using (true);

drop policy if exists "Leaderboard snapshots can be managed by moderators and admins" on public.leaderboard_snapshots;
create policy "Leaderboard snapshots can be managed by moderators and admins"
on public.leaderboard_snapshots
for all
using (public.is_moderator_or_admin())
with check (public.is_moderator_or_admin());

commit;
