import { classNames } from '@/utils/classNames';

type StatusTone = 'success' | 'warning' | 'danger' | 'accent';

const statusClasses: Record<StatusTone, string> = {
  success: 'border-[#2da44e] bg-[#e4f5e8] text-[#187638]',
  warning: 'border-[#e59b32] bg-[#fff1d6] text-[#8c5510]',
  danger: 'border-[#ff6b5f] bg-[#fff0ee] text-[#a83c34]',
  accent: 'border-[#4cc9f0] bg-[#e2f8fe] text-[#16738e]'
};

type StatusPillProps = {
  tone: StatusTone;
  children: string;
};

export function StatusPill({ tone, children }: StatusPillProps) {
  return (
    <span className={classNames('inline-flex items-center rounded-full border px-3 py-1 text-xs font-bold', statusClasses[tone])}>
      {children}
    </span>
  );
}
