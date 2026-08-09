import { Card } from '@/components/ui/Card';

type MetricCardProps = {
  label: string;
  value: string;
  hint: string;
};

export function MetricCard({ label, value, hint }: MetricCardProps) {
  return (
    <Card className="p-5">
      <p className="pixel-label text-[10px] text-[#566172]">{label}</p>
      <div className="mt-3 flex items-end justify-between gap-4">
        <strong className="minecraft-title text-3xl tracking-tight text-[#101114]">{value}</strong>
        <span className="rounded-full border border-[#dfe3ea] bg-[#f7f8fb] px-2 py-1 text-[10px] text-[#566172]">
          {hint}
        </span>
      </div>
    </Card>
  );
}
