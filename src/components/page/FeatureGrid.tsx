import { Card } from '@/components/ui/Card';
import { ProgressBar } from '@/components/ui/ProgressBar';
import { StatusPill } from '@/components/ui/StatusPill';

type FeatureGridProps = {
  items: Array<{
    title: string;
    description: string;
  }>;
  progress?: Array<{
    label: string;
    value: number;
  }>;
};

export function FeatureGrid({ items, progress }: FeatureGridProps) {
  return (
    <div className="grid gap-6 xl:grid-cols-[1.2fr_0.8fr]">
      <Card className="p-6 md:p-7">
        <div className="grid gap-4 md:grid-cols-2">
          {items.map((item) => (
            <div key={item.title} className="rounded-md border-2 border-[#101114] bg-white p-4 transition hover:-translate-x-1 hover:-translate-y-1 hover:shadow-[5px_5px_0_#101114]">
              <p className="font-[var(--font-display)] font-bold text-[#101114]">{item.title}</p>
              <p className="mt-2 text-sm leading-6 text-[#566172]">{item.description}</p>
            </div>
          ))}
        </div>
      </Card>

      <Card className="p-6 md:p-7">
        <p className="pixel-label mb-4 text-[10px] text-[#566172]">Server progress</p><div className="flex flex-wrap gap-2">
          <StatusPill tone="accent">beta</StatusPill>
          <StatusPill tone="success">ready</StatusPill>
          <StatusPill tone="warning">planned</StatusPill>
        </div>
        <div className="mt-6 space-y-5">
          {(progress ?? []).map((item) => (
            <ProgressBar key={item.label} label={item.label} value={item.value} />
          ))}
        </div>
      </Card>
    </div>
  );
}
