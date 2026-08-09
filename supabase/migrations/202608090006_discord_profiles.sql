begin;

alter table public.profiles
  add column if not exists discord_id text;

create unique index if not exists profiles_discord_id_key
  on public.profiles (discord_id)
  where discord_id is not null;

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  profile_name text;
  discord_identifier text;
begin
  profile_name := nullif(
    coalesce(
      new.raw_user_meta_data ->> 'display_name',
      new.raw_user_meta_data ->> 'full_name',
      new.raw_user_meta_data ->> 'name',
      new.raw_user_meta_data ->> 'user_name',
      new.raw_user_meta_data ->> 'username',
      split_part(coalesce(new.email, ''), '@', 1)
    ),
    ''
  );

  discord_identifier := nullif(
    coalesce(
      new.raw_user_meta_data ->> 'provider_id',
      new.raw_user_meta_data ->> 'discord_id',
      new.raw_user_meta_data ->> 'sub',
      new.raw_user_meta_data ->> 'id'
    ),
    ''
  );

  insert into public.profiles (
    user_id,
    discord_id,
    username,
    display_name,
    avatar_url,
    preferred_locale
  )
  values (
    new.id,
    discord_identifier,
    nullif(
      coalesce(
        new.raw_user_meta_data ->> 'user_name',
        new.raw_user_meta_data ->> 'username',
        split_part(coalesce(new.email, ''), '@', 1)
      ),
      ''
    ),
    profile_name,
    nullif(new.raw_user_meta_data ->> 'avatar_url', ''),
    coalesce(nullif(new.raw_user_meta_data ->> 'locale', ''), 'en-US')
  )
  on conflict (user_id) do update
    set discord_id = coalesce(excluded.discord_id, public.profiles.discord_id),
        username = excluded.username,
        display_name = excluded.display_name,
        avatar_url = excluded.avatar_url,
        preferred_locale = excluded.preferred_locale,
        updated_at = timezone('utc', now());

  return new;
end;
$$;

commit;
