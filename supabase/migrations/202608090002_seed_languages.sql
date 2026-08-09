begin;

insert into public.languages (code, name, native_name, direction, emoji, sort_order, is_active)
values
  ('en', 'English', 'English', 'ltr', 'US', 10, true),
  ('pt-BR', 'Portuguese (Brazil)', 'Portuguese (Brazil)', 'ltr', 'BR', 20, true),
  ('es', 'Spanish', 'Espanol', 'ltr', 'ES', 30, true),
  ('fr', 'French', 'Francais', 'ltr', 'FR', 40, true),
  ('de', 'German', 'Deutsch', 'ltr', 'DE', 50, true),
  ('ja', 'Japanese', 'Japanese', 'ltr', 'JP', 60, true),
  ('ko', 'Korean', 'Korean', 'ltr', 'KR', 70, true),
  ('ru', 'Russian', 'Russian', 'ltr', 'RU', 80, true)
on conflict (code) do update
set name = excluded.name,
    native_name = excluded.native_name,
    direction = excluded.direction,
    emoji = excluded.emoji,
    sort_order = excluded.sort_order,
    is_active = excluded.is_active;

commit;
