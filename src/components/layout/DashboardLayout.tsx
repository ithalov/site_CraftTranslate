import type { PropsWithChildren } from 'react';
import { Outlet } from 'react-router-dom';
import { DashboardSidebar } from '@/components/layout/DashboardSidebar';
import { DashboardTopbar } from '@/components/layout/DashboardTopbar';

export function DashboardLayout({ children }: PropsWithChildren) {
  return (
    <div className="min-h-screen px-[var(--space-page)] py-6 text-text">
      <div className="mx-auto grid w-full max-w-7xl gap-6 lg:grid-cols-[260px_minmax(0,1fr)]">
        <div className="lg:sticky lg:top-6 lg:h-[calc(100vh-3rem)]">
          <DashboardSidebar />
        </div>
        <div className="flex min-w-0 flex-col gap-6">
          <DashboardTopbar />
          {children ?? <Outlet />}
        </div>
      </div>
    </div>
  );
}
