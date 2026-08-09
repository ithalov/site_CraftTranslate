import type { PropsWithChildren } from 'react';
import { Outlet } from 'react-router-dom';
import { SiteFooter } from '@/components/layout/SiteFooter';
import { SiteHeader } from '@/components/layout/SiteHeader';
import { useAppConfig } from '@/hooks/useAppConfig';

export function PublicLayout({ children }: PropsWithChildren) {
  const config = useAppConfig();

  return (
    <div className="min-h-screen text-text">
      <SiteHeader appName={config.appName} />
      <main className="mx-auto w-full max-w-7xl px-[var(--space-page)] pb-16">
        {children ?? <Outlet />}
      </main>
      <SiteFooter />
    </div>
  );
}
