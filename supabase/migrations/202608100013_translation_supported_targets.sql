begin;

alter table public.translation_keys
  add column if not exists supported_targets text[] not null default '{}'::text[];

update public.translation_keys
set supported_targets = coalesce(supported_targets, '{}'::text[])
where supported_targets is null;

commit;
