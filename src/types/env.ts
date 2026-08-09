export type AppEnv = {
  appName: string;
  supabaseUrl: string;
  supabaseAnonKey: string;
  discordClientId: string;
  discordRedirectUri: string;
  basePath: string;
};

export type AppEnvKey = keyof AppEnv;
