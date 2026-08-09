import { env } from '@/services/environment';

export function useAppConfig() {
  return {
    appName: env.appName
  };
}
