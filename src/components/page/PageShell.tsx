import type { PropsWithChildren } from 'react';
import { Card } from '@/components/ui/Card';

type PageShellProps = PropsWithChildren<{
  eyebrow: string;
  title: string;
  description: string;
}>;

export function PageShell({ eyebrow, title, description, children }: PageShellProps) {
  return (
    <div className="space-y-6">
      <Card className="overflow-hidden p-0">
        <div className="relative overflow-hidden border-b-2 border-[#101114] bg-[#c7f464] px-6 py-3"><div className="absolute inset-y-0 w-1/3 -skew-x-12 bg-white/20 [animation:shine-sweep_5s_ease-in-out_infinite]" /><p className="pixel-label relative text-[10px] text-[#101114]">{eyebrow} // workspace module</p></div>
        <div className="p-6 md:p-8">
        <h2 className="minecraft-title text-3xl text-[#101114] md:text-4xl">
          {title}
        </h2>
        <p className="mt-4 max-w-3xl text-base leading-7 text-[#566172]">{description}</p>
        </div>
      </Card>
      {children}
    </div>
  );
}
