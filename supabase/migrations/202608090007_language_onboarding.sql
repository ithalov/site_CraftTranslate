begin;

do $$
begin
  alter type public.language_proficiency add value if not exists 'fluent' after 'intermediate';
exception
  when duplicate_object then null;
end $$;

commit;
