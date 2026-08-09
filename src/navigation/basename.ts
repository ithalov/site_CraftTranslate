import { env } from '@/services/environment';

export function getRouterBasename() {
  if (!env.basePath || env.basePath === '/') {
    return '/';
  }

  return `/${env.basePath.replace(/^\/+|\/+$/g, '')}`;
}
