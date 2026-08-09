import type { PropsWithChildren } from 'react';
import { AppShell } from '@/components/layout/AppShell';
import { useAppConfig } from '@/hooks/useAppConfig';

export function RootLayout({ children }: PropsWithChildren) {
  const config = useAppConfig();

  return <AppShell appName={config.appName}>{children}</AppShell>;
}
