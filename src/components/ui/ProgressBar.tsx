import { classNames } from '@/utils/classNames';

type ProgressBarProps = {
  label: string;
  value: number;
  tone?: 'accent' | 'success' | 'warning';
};

const toneClasses = {
  accent: 'bg-[#4cc9f0]',
  success: 'bg-[#2da44e]',
  warning: 'bg-[#e59b32]'
};

export function ProgressBar({ label, value, tone = 'accent' }: ProgressBarProps) {
  return (
    <div className="space-y-2">
      <div className="flex items-center justify-between gap-4 text-sm">
        <span className="text-[#566172]">{label}</span>
        <span className="font-bold text-[#101114]">{value}%</span>
      </div>
      <div className="h-3 rounded-full bg-[#e6eaf0] p-[2px]">
        <div
          className={classNames('h-full rounded-full', toneClasses[tone])}
          style={{ width: `${value}%` }}
        />
      </div>
    </div>
  );
}
