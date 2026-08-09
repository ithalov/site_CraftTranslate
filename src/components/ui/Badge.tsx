import type { PropsWithChildren } from 'react';
import { classNames } from '@/utils/classNames';

type BadgeTone = 'accent' | 'neutral' | 'success' | 'warning' | 'danger';

const toneClasses: Record<BadgeTone, string> = {
  accent: 'border-[#101114] bg-[#c7f464] text-[#101114]',
  neutral: 'border-[#dfe3ea] bg-[#f7f8fb] text-[#495364]',
  success: 'border-[#2da44e] bg-[#e4f5e8] text-[#187638]',
  warning: 'border-[#e59b32] bg-[#fff1d6] text-[#8c5510]',
  danger: 'border-[#ff6b5f] bg-[#fff0ee] text-[#a83c34]'
};

type BadgeProps = PropsWithChildren<{
  tone?: BadgeTone;
  className?: string;
}>;

export function Badge({ tone = 'neutral', className, children }: BadgeProps) {
  return (
    <span
      className={classNames(
        'inline-flex items-center gap-2 rounded-full border px-3 py-1 text-xs font-bold',
        toneClasses[tone],
        className
      )}
    >
      {children}
    </span>
  );
}
