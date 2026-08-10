begin;

-- Supports projects created before the language onboarding flow. New rows
-- receive their UUID from PostgreSQL when the frontend omits the id column.
alter table public.user_languages
  alter column id set default gen_random_uuid();

commit;
