import type { PropsWithChildren } from 'react';
import { Badge } from '@/components/ui/Badge';
import { LocaleSwitcher } from '@/components/ui/LocaleSwitcher';

type AppShellProps = PropsWithChildren<{
  appName: string;
}>;

export function AppShell({ appName, children }: AppShellProps) {
  return (
    <div className="min-h-screen text-text">
      <header className="mx-auto flex w-full max-w-7xl items-center justify-between gap-4 px-[var(--space-page)] py-6">
        <div className="flex items-center gap-4">
          <div className="grid h-11 w-11 place-items-center rounded-2xl border border-line bg-white/5 shadow-soft">
            <span className="text-sm font-bold tracking-[0.24em] text-cyan-200">CT</span>
          </div>
          <div>
            <p className="text-[10px] uppercase tracking-[0.34em] text-cyan-200/80">ChatTranslate</p>
            <h1 className="mt-1 text-base font-semibold text-white">{appName}</h1>
          </div>
        </div>
        <div className="flex flex-wrap items-center justify-end gap-3">
          <Badge tone="accent">Dark Mode</Badge>
          <Badge tone="neutral">Responsive</Badge>
          <LocaleSwitcher />
        </div>
      </header>
      <main className="mx-auto w-full max-w-7xl px-[var(--space-page)] pb-16">{children}</main>
    </div>
  );
}
