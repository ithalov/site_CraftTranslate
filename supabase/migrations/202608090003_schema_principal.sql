begin;

create extension if not exists pgcrypto;

do $$
begin
  create type public.language_proficiency as enum ('beginner', 'intermediate', 'advanced', 'native');
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create type public.translation_key_status as enum ('draft', 'active', 'archived');
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create type public.translation_suggestion_status as enum ('draft', 'pending', 'approved', 'rejected', 'archived');
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create type public.review_decision as enum ('approve', 'request_changes', 'reject', 'flag');
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create type public.vote_kind as enum ('upvote', 'downvote', 'helpful', 'not_helpful');
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create type public.glossary_status as enum ('draft', 'pending', 'approved', 'deprecated');
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create type public.glossary_proposal_status as enum ('pending', 'approved', 'rejected', 'superseded');
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create type public.badge_rarity as enum ('common', 'rare', 'epic', 'legendary');
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create type public.report_status as enum ('open', 'under_review', 'resolved', 'dismissed');
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create type public.donation_status as enum ('pending', 'completed', 'failed', 'refunded');
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create type public.reputation_event_type as enum (
    'translation_created',
    'translation_approved',
    'translation_rejected',
    'review_completed',
    'report_resolved',
    'badge_awarded',
    'manual_adjustment'
  );
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create type public.xp_event_type as enum (
    'translation_created',
    'translation_approved',
    'translation_rejected',
    'review_completed',
    'report_resolved',
    'badge_awarded',
    'manual_adjustment'
  );
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create type public.report_target_type as enum (
    'profile',
    'translation_key',
    'translation_suggestion',
    'review',
    'translation_comment',
    'glossary',
    'glossary_proposal'
  );
exception
  when duplicate_object then null;
end $$;

do $$
begin
  alter table public.languages add column if not exists id uuid;
exception
  when duplicate_column then null;
end $$;

update public.languages
set id = coalesce(id, gen_random_uuid())
where id is null;

alter table public.languages
  alter column id set default gen_random_uuid();

alter table public.languages
  alter column id set not null;

do $$
begin
  alter table public.languages add constraint languages_id_key unique (id);
exception
  when duplicate_object then null;
end $$;

create table if not exists public.user_languages (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  language_id uuid not null references public.languages (id) on delete cascade,
  proficiency public.language_proficiency not null default 'intermediate',
  is_primary boolean not null default false,
  is_native boolean not null default false,
  is_learning boolean not null default true,
  notes text,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now()),
  unique (user_id, language_id)
);

create table if not exists public.language_members (
  id uuid primary key default gen_random_uuid(),
  language_id uuid not null references public.languages (id) on delete cascade,
  user_id uuid not null references auth.users (id) on delete cascade,
  role public.member_role not null default 'member',
  contribution_score integer not null default 0,
  is_active boolean not null default true,
  joined_at timestamptz not null default timezone('utc', now()),
  invited_by uuid references auth.users (id) on delete set null,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now()),
  unique (language_id, user_id)
);

create table if not exists public.translation_keys (
  id uuid primary key default gen_random_uuid(),
  key_name text not null unique,
  source_language_id uuid not null references public.languages (id) on delete restrict,
  original_text text not null,
  category text not null,
  subcategory text,
  context text,
  protected_variables text[] not null default '{}'::text[],
  protected_terms text[] not null default '{}'::text[],
  notes text,
  status public.translation_key_status not null default 'draft',
  latest_version integer not null default 1,
  current_suggestion_id uuid,
  created_by uuid references auth.users (id) on delete set null,
  updated_by uuid references auth.users (id) on delete set null,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now()),
  constraint translation_keys_original_text_not_empty check (length(trim(original_text)) > 0),
  constraint translation_keys_key_name_not_empty check (length(trim(key_name)) > 0),
  constraint translation_keys_category_not_empty check (length(trim(category)) > 0)
);

create table if not exists public.translation_suggestions (
  id uuid primary key default gen_random_uuid(),
  translation_key_id uuid not null references public.translation_keys (id) on delete cascade,
  target_language_id uuid not null references public.languages (id) on delete cascade,
  author_id uuid not null references auth.users (id) on delete cascade,
  supersedes_suggestion_id uuid references public.translation_suggestions (id) on delete set null,
  version_number integer not null default 1,
  suggestion_text text not null,
  rationale text,
  notes text,
  status public.translation_suggestion_status not null default 'draft',
  source_hash text,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now()),
  constraint translation_suggestions_text_not_empty check (length(trim(suggestion_text)) > 0),
  unique (translation_key_id, target_language_id, version_number)
);

alter table public.translation_keys
  add constraint translation_keys_current_suggestion_fk
  foreign key (current_suggestion_id) references public.translation_suggestions (id) on delete set null;

create table if not exists public.reviews (
  id uuid primary key default gen_random_uuid(),
  translation_suggestion_id uuid not null references public.translation_suggestions (id) on delete cascade,
  reviewer_id uuid not null references auth.users (id) on delete cascade,
  decision public.review_decision not null,
  score integer not null default 0,
  notes text,
  reviewed_at timestamptz not null default timezone('utc', now()),
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now()),
  constraint reviews_score_range check (score between -5 and 5),
  unique (translation_suggestion_id, reviewer_id)
);

create table if not exists public.translation_votes (
  id uuid primary key default gen_random_uuid(),
  translation_suggestion_id uuid not null references public.translation_suggestions (id) on delete cascade,
  voter_id uuid not null references auth.users (id) on delete cascade,
  vote public.vote_kind not null default 'upvote',
  weight integer not null default 1,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now()),
  constraint translation_votes_weight_positive check (weight > 0),
  unique (translation_suggestion_id, voter_id)
);

create table if not exists public.translation_comments (
  id uuid primary key default gen_random_uuid(),
  translation_suggestion_id uuid not null references public.translation_suggestions (id) on delete cascade,
  author_id uuid not null references auth.users (id) on delete cascade,
  parent_comment_id uuid references public.translation_comments (id) on delete cascade,
  body text not null,
  anchor_start integer,
  anchor_end integer,
  is_resolved boolean not null default false,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now()),
  constraint translation_comments_body_not_empty check (length(trim(body)) > 0),
  constraint translation_comments_anchor_range check (
    anchor_start is null
    or anchor_start >= 0
  ),
  constraint translation_comments_anchor_end_range check (
    anchor_end is null
    or anchor_end >= 0
  ),
  constraint translation_comments_anchor_order check (
    anchor_start is null
    or anchor_end is null
    or anchor_end >= anchor_start
  )
);

create table if not exists public.glossary (
  id uuid primary key default gen_random_uuid(),
  language_id uuid not null references public.languages (id) on delete cascade,
  term text not null,
  definition text not null,
  category text not null,
  subcategory text,
  aliases text[] not null default '{}'::text[],
  tags text[] not null default '{}'::text[],
  source_translation_key_id uuid references public.translation_keys (id) on delete set null,
  status public.glossary_status not null default 'draft',
  created_by uuid references auth.users (id) on delete set null,
  updated_by uuid references auth.users (id) on delete set null,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now()),
  constraint glossary_term_not_empty check (length(trim(term)) > 0),
  constraint glossary_definition_not_empty check (length(trim(definition)) > 0),
  constraint glossary_category_not_empty check (length(trim(category)) > 0),
  unique (language_id, term)
);

create table if not exists public.glossary_proposals (
  id uuid primary key default gen_random_uuid(),
  glossary_id uuid references public.glossary (id) on delete set null,
  language_id uuid not null references public.languages (id) on delete cascade,
  proposed_term text not null,
  proposed_definition text not null,
  proposer_id uuid not null references auth.users (id) on delete cascade,
  reviewer_id uuid references auth.users (id) on delete set null,
  source_translation_key_id uuid references public.translation_keys (id) on delete set null,
  rationale text,
  status public.glossary_proposal_status not null default 'pending',
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now()),
  constraint glossary_proposals_term_not_empty check (length(trim(proposed_term)) > 0),
  constraint glossary_proposals_definition_not_empty check (length(trim(proposed_definition)) > 0)
);

create table if not exists public.badges (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  name text not null,
  description text not null,
  icon text,
  rarity public.badge_rarity not null default 'common',
  category text not null default 'community',
  criteria jsonb not null default '{}'::jsonb,
  xp_reward integer not null default 0,
  active boolean not null default true,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now()),
  constraint badges_slug_not_empty check (length(trim(slug)) > 0),
  constraint badges_name_not_empty check (length(trim(name)) > 0),
  constraint badges_description_not_empty check (length(trim(description)) > 0),
  constraint badges_xp_reward_nonnegative check (xp_reward >= 0)
);

create table if not exists public.user_badges (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  badge_id uuid not null references public.badges (id) on delete cascade,
  awarded_by uuid references auth.users (id) on delete set null,
  reason text,
  metadata jsonb not null default '{}'::jsonb,
  awarded_at timestamptz not null default timezone('utc', now()),
  unique (user_id, badge_id)
);

create table if not exists public.reputation_events (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  actor_id uuid references auth.users (id) on delete set null,
  event_type public.reputation_event_type not null,
  source_table text,
  source_id uuid,
  delta integer not null,
  reason text,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default timezone('utc', now()),
  constraint reputation_events_reason_not_empty check (reason is null or length(trim(reason)) > 0)
);

create table if not exists public.xp_events (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  actor_id uuid references auth.users (id) on delete set null,
  event_type public.xp_event_type not null,
  source_table text,
  source_id uuid,
  xp_delta integer not null,
  reason text,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default timezone('utc', now()),
  constraint xp_events_reason_not_empty check (reason is null or length(trim(reason)) > 0)
);

create table if not exists public.reports (
  id uuid primary key default gen_random_uuid(),
  reporter_id uuid not null references auth.users (id) on delete cascade,
  reported_user_id uuid references auth.users (id) on delete cascade,
  report_target_type public.report_target_type not null,
  translation_key_id uuid references public.translation_keys (id) on delete cascade,
  translation_suggestion_id uuid references public.translation_suggestions (id) on delete cascade,
  review_id uuid references public.reviews (id) on delete cascade,
  translation_comment_id uuid references public.translation_comments (id) on delete cascade,
  glossary_id uuid references public.glossary (id) on delete cascade,
  glossary_proposal_id uuid references public.glossary_proposals (id) on delete cascade,
  details text not null,
  status public.report_status not null default 'open',
  resolution text,
  resolved_by uuid references auth.users (id) on delete set null,
  resolved_at timestamptz,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now()),
  constraint reports_details_not_empty check (length(trim(details)) > 0),
  constraint reports_has_target check (
    reported_user_id is not null
    or translation_key_id is not null
    or translation_suggestion_id is not null
    or review_id is not null
    or translation_comment_id is not null
    or glossary_id is not null
    or glossary_proposal_id is not null
  )
);

create table if not exists public.donations (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  provider text not null,
  provider_reference text not null unique,
  amount numeric(12,2) not null,
  currency char(3) not null default 'USD',
  status public.donation_status not null default 'pending',
  donated_at timestamptz,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now()),
  constraint donations_amount_positive check (amount > 0),
  constraint donations_provider_not_empty check (length(trim(provider)) > 0),
  constraint donations_reference_not_empty check (length(trim(provider_reference)) > 0)
);

create index if not exists languages_id_idx
  on public.languages (id);

create index if not exists user_languages_user_id_idx
  on public.user_languages (user_id);

create index if not exists user_languages_language_id_idx
  on public.user_languages (language_id);

create index if not exists language_members_language_id_idx
  on public.language_members (language_id);

create index if not exists language_members_user_id_idx
  on public.language_members (user_id);

create index if not exists translation_keys_source_language_id_idx
  on public.translation_keys (source_language_id, category, subcategory);

create index if not exists translation_suggestions_translation_key_id_idx
  on public.translation_suggestions (translation_key_id, target_language_id, version_number desc);

create index if not exists reviews_translation_suggestion_id_idx
  on public.reviews (translation_suggestion_id, created_at desc);

create index if not exists translation_votes_translation_suggestion_id_idx
  on public.translation_votes (translation_suggestion_id, vote);

create index if not exists translation_comments_translation_suggestion_id_idx
  on public.translation_comments (translation_suggestion_id, parent_comment_id, created_at asc);

create index if not exists glossary_language_id_idx
  on public.glossary (language_id, status, term);

create index if not exists glossary_proposals_language_id_idx
  on public.glossary_proposals (language_id, status, created_at desc);

create index if not exists user_badges_user_id_idx
  on public.user_badges (user_id, awarded_at desc);

create index if not exists reputation_events_user_id_idx
  on public.reputation_events (user_id, created_at desc);

create index if not exists xp_events_user_id_idx
  on public.xp_events (user_id, created_at desc);

create index if not exists reports_status_idx
  on public.reports (status, created_at desc);

create index if not exists donations_user_id_idx
  on public.donations (user_id, created_at desc);

drop trigger if exists set_user_languages_updated_at on public.user_languages;
create trigger set_user_languages_updated_at
before update on public.user_languages
for each row execute function public.set_updated_at();

drop trigger if exists set_language_members_updated_at on public.language_members;
create trigger set_language_members_updated_at
before update on public.language_members
for each row execute function public.set_updated_at();

drop trigger if exists set_translation_keys_updated_at on public.translation_keys;
create trigger set_translation_keys_updated_at
before update on public.translation_keys
for each row execute function public.set_updated_at();

drop trigger if exists set_translation_suggestions_updated_at on public.translation_suggestions;
create trigger set_translation_suggestions_updated_at
before update on public.translation_suggestions
for each row execute function public.set_updated_at();

drop trigger if exists set_reviews_updated_at on public.reviews;
create trigger set_reviews_updated_at
before update on public.reviews
for each row execute function public.set_updated_at();

drop trigger if exists set_translation_votes_updated_at on public.translation_votes;
create trigger set_translation_votes_updated_at
before update on public.translation_votes
for each row execute function public.set_updated_at();

drop trigger if exists set_translation_comments_updated_at on public.translation_comments;
create trigger set_translation_comments_updated_at
before update on public.translation_comments
for each row execute function public.set_updated_at();

drop trigger if exists set_glossary_updated_at on public.glossary;
create trigger set_glossary_updated_at
before update on public.glossary
for each row execute function public.set_updated_at();

drop trigger if exists set_glossary_proposals_updated_at on public.glossary_proposals;
create trigger set_glossary_proposals_updated_at
before update on public.glossary_proposals
for each row execute function public.set_updated_at();

drop trigger if exists set_badges_updated_at on public.badges;
create trigger set_badges_updated_at
before update on public.badges
for each row execute function public.set_updated_at();

drop trigger if exists set_reports_updated_at on public.reports;
create trigger set_reports_updated_at
before update on public.reports
for each row execute function public.set_updated_at();

drop trigger if exists set_donations_updated_at on public.donations;
create trigger set_donations_updated_at
before update on public.donations
for each row execute function public.set_updated_at();

alter table public.user_languages enable row level security;
alter table public.language_members enable row level security;
alter table public.translation_keys enable row level security;
alter table public.translation_suggestions enable row level security;
alter table public.reviews enable row level security;
alter table public.translation_votes enable row level security;
alter table public.translation_comments enable row level security;
alter table public.glossary enable row level security;
alter table public.glossary_proposals enable row level security;
alter table public.badges enable row level security;
alter table public.user_badges enable row level security;
alter table public.reputation_events enable row level security;
alter table public.xp_events enable row level security;
alter table public.reports enable row level security;
alter table public.donations enable row level security;

drop policy if exists "Languages remain readable" on public.languages;
create policy "Languages remain readable"
on public.languages
for select
using (true);

drop policy if exists "Languages managed by moderators and admins" on public.languages;
create policy "Languages managed by moderators and admins"
on public.languages
for all
using (public.is_moderator_or_admin())
with check (public.is_moderator_or_admin());

drop policy if exists "User languages visible to owners and admins" on public.user_languages;
create policy "User languages visible to owners and admins"
on public.user_languages
for select
using (auth.uid() = user_id or public.is_admin());

drop policy if exists "User languages editable by owners and admins" on public.user_languages;
create policy "User languages editable by owners and admins"
on public.user_languages
for all
using (auth.uid() = user_id or public.is_admin())
with check (auth.uid() = user_id or public.is_admin());

drop policy if exists "Language members visible to members and admins" on public.language_members;
create policy "Language members visible to members and admins"
on public.language_members
for select
using (auth.uid() = user_id or public.is_moderator_or_admin());

drop policy if exists "Language members editable by members and admins" on public.language_members;
create policy "Language members editable by members and admins"
on public.language_members
for all
using (auth.uid() = user_id or public.is_moderator_or_admin())
with check (auth.uid() = user_id or public.is_moderator_or_admin());

drop policy if exists "Translation keys readable" on public.translation_keys;
create policy "Translation keys readable"
on public.translation_keys
for select
using (true);

drop policy if exists "Translation keys created by authenticated users" on public.translation_keys;
create policy "Translation keys created by authenticated users"
on public.translation_keys
for insert
with check (auth.uid() is not null and created_by = auth.uid());

drop policy if exists "Translation keys editable by owners and admins" on public.translation_keys;
create policy "Translation keys editable by owners and admins"
on public.translation_keys
for update
using (created_by = auth.uid() or public.is_moderator_or_admin())
with check (created_by = auth.uid() or public.is_moderator_or_admin());

drop policy if exists "Suggestions readable" on public.translation_suggestions;
create policy "Suggestions readable"
on public.translation_suggestions
for select
using (true);

drop policy if exists "Suggestions created by authors" on public.translation_suggestions;
create policy "Suggestions created by authors"
on public.translation_suggestions
for insert
with check (auth.uid() is not null and author_id = auth.uid());

drop policy if exists "Suggestions editable by authors and admins" on public.translation_suggestions;
create policy "Suggestions editable by authors and admins"
on public.translation_suggestions
for update
using (author_id = auth.uid() or public.is_moderator_or_admin())
with check (author_id = auth.uid() or public.is_moderator_or_admin());

drop policy if exists "Reviews readable" on public.reviews;
create policy "Reviews readable"
on public.reviews
for select
using (true);

drop policy if exists "Reviews created by reviewers" on public.reviews;
create policy "Reviews created by reviewers"
on public.reviews
for insert
with check (auth.uid() is not null and reviewer_id = auth.uid());

drop policy if exists "Reviews editable by reviewers and admins" on public.reviews;
create policy "Reviews editable by reviewers and admins"
on public.reviews
for update
using (reviewer_id = auth.uid() or public.is_moderator_or_admin())
with check (reviewer_id = auth.uid() or public.is_moderator_or_admin());

drop policy if exists "Votes readable" on public.translation_votes;
create policy "Votes readable"
on public.translation_votes
for select
using (true);

drop policy if exists "Votes created by voters" on public.translation_votes;
create policy "Votes created by voters"
on public.translation_votes
for insert
with check (auth.uid() is not null and voter_id = auth.uid());

drop policy if exists "Votes editable by voters and admins" on public.translation_votes;
create policy "Votes editable by voters and admins"
on public.translation_votes
for update
using (voter_id = auth.uid() or public.is_moderator_or_admin())
with check (voter_id = auth.uid() or public.is_moderator_or_admin());

drop policy if exists "Comments readable" on public.translation_comments;
create policy "Comments readable"
on public.translation_comments
for select
using (true);

drop policy if exists "Comments created by authors" on public.translation_comments;
create policy "Comments created by authors"
on public.translation_comments
for insert
with check (auth.uid() is not null and author_id = auth.uid());

drop policy if exists "Comments editable by authors and admins" on public.translation_comments;
create policy "Comments editable by authors and admins"
on public.translation_comments
for update
using (author_id = auth.uid() or public.is_moderator_or_admin())
with check (author_id = auth.uid() or public.is_moderator_or_admin());

drop policy if exists "Glossary readable" on public.glossary;
create policy "Glossary readable"
on public.glossary
for select
using (true);

drop policy if exists "Glossary managed by moderators and admins" on public.glossary;
create policy "Glossary managed by moderators and admins"
on public.glossary
for all
using (public.is_moderator_or_admin())
with check (public.is_moderator_or_admin());

drop policy if exists "Glossary proposals readable" on public.glossary_proposals;
create policy "Glossary proposals readable"
on public.glossary_proposals
for select
using (auth.uid() = proposer_id or public.is_moderator_or_admin());

drop policy if exists "Glossary proposals created by proposers" on public.glossary_proposals;
create policy "Glossary proposals created by proposers"
on public.glossary_proposals
for insert
with check (auth.uid() is not null and proposer_id = auth.uid());

drop policy if exists "Glossary proposals editable by proposers and admins" on public.glossary_proposals;
create policy "Glossary proposals editable by proposers and admins"
on public.glossary_proposals
for update
using (proposer_id = auth.uid() or public.is_moderator_or_admin())
with check (proposer_id = auth.uid() or public.is_moderator_or_admin());

drop policy if exists "Badges readable" on public.badges;
create policy "Badges readable"
on public.badges
for select
using (true);

drop policy if exists "Badges managed by admins" on public.badges;
create policy "Badges managed by admins"
on public.badges
for all
using (public.is_admin())
with check (public.is_admin());

drop policy if exists "User badges readable" on public.user_badges;
create policy "User badges readable"
on public.user_badges
for select
using (auth.uid() = user_id or public.is_admin());

drop policy if exists "User badges managed by admins" on public.user_badges;
create policy "User badges managed by admins"
on public.user_badges
for all
using (public.is_admin())
with check (public.is_admin());

drop policy if exists "Reputation events readable by owners and admins" on public.reputation_events;
create policy "Reputation events readable by owners and admins"
on public.reputation_events
for select
using (auth.uid() = user_id or public.is_admin());

drop policy if exists "Reputation events managed by admins" on public.reputation_events;
create policy "Reputation events managed by admins"
on public.reputation_events
for all
using (public.is_admin())
with check (public.is_admin());

drop policy if exists "XP events readable by owners and admins" on public.xp_events;
create policy "XP events readable by owners and admins"
on public.xp_events
for select
using (auth.uid() = user_id or public.is_admin());

drop policy if exists "XP events managed by admins" on public.xp_events;
create policy "XP events managed by admins"
on public.xp_events
for all
using (public.is_admin())
with check (public.is_admin());

drop policy if exists "Reports readable by reporters and admins" on public.reports;
create policy "Reports readable by reporters and admins"
on public.reports
for select
using (auth.uid() = reporter_id or public.is_admin());

drop policy if exists "Reports created by reporters" on public.reports;
create policy "Reports created by reporters"
on public.reports
for insert
with check (auth.uid() is not null and reporter_id = auth.uid());

drop policy if exists "Reports editable by admins" on public.reports;
create policy "Reports editable by admins"
on public.reports
for update
using (public.is_admin())
with check (public.is_admin());

drop policy if exists "Donations readable by owners and admins" on public.donations;
create policy "Donations readable by owners and admins"
on public.donations
for select
using (auth.uid() = user_id or public.is_admin());

drop policy if exists "Donations created by owners" on public.donations;
create policy "Donations created by owners"
on public.donations
for insert
with check (auth.uid() is not null and user_id = auth.uid());

drop policy if exists "Donations editable by admins" on public.donations;
create policy "Donations editable by admins"
on public.donations
for update
using (public.is_admin())
with check (public.is_admin());

commit;
