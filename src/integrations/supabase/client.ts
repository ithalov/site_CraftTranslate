import { createClient } from '@supabase/supabase-js';
import { env, hasSupabase } from '@/services/environment';
import type { Database } from './database.types';

export const supabaseConfig = {
  auth: {
    autoRefreshToken: true,
    // AuthCallbackPage owns the PKCE exchange. Handling it here too can
    // consume the same one-time code twice when React mounts in StrictMode.
    detectSessionInUrl: false,
    persistSession: true,
    flowType: 'pkce' as const
  },
  global: {
    headers: {
      'x-application-name': env.appName
    }
  }
};

export const supabase = hasSupabase
  ? createClient<Database>(env.supabaseUrl, env.supabaseAnonKey, supabaseConfig)
  : null;

export const isSupabaseConfigured = hasSupabase;
