import type { AppEnv } from '@/types/env';

function readEnv(value: string | undefined, fallback = '') {
  return value?.trim() || fallback;
}

export const env: AppEnv = {
  appName: readEnv(import.meta.env.VITE_APP_NAME, 'ChatTranslate Web'),
  supabaseUrl: readEnv(import.meta.env.VITE_SUPABASE_URL),
  supabaseAnonKey: readEnv(import.meta.env.VITE_SUPABASE_ANON_KEY),
  discordClientId: readEnv(import.meta.env.VITE_DISCORD_CLIENT_ID),
  discordRedirectUri: readEnv(import.meta.env.VITE_DISCORD_REDIRECT_URI),
  basePath: readEnv(import.meta.env.VITE_BASE_PATH, '/')
};

export const hasSupabase = Boolean(env.supabaseUrl && env.supabaseAnonKey);
export const hasDiscord = Boolean(env.discordClientId && env.discordRedirectUri);
