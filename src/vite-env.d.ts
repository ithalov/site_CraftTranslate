/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_APP_NAME?: string;
  readonly VITE_SUPABASE_URL?: string;
  readonly VITE_SUPABASE_ANON_KEY?: string;
  readonly VITE_DISCORD_CLIENT_ID?: string;
  readonly VITE_DISCORD_REDIRECT_URI?: string;
  readonly VITE_BASE_PATH?: string;
  readonly VITE_TRANSLATION_CONTENT_URL?: string;
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}
