export type AuthProvider = 'discord';

export type UserSession = {
  provider: AuthProvider;
  userId: string;
  email?: string;
  accessToken?: string;
};
