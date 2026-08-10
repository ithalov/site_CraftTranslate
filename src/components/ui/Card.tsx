import type { PropsWithChildren } from 'react';
import { classNames } from '@/utils/classNames';

type CardProps = PropsWithChildren<{
  className?: string;
  elevated?: boolean;
}>;

export function Card({ className, elevated = false, children }: CardProps) {
  const hasCustomBackground = className?.includes('bg-');

  return (
    <div
      className={classNames(
        'pixel-panel relative',
        !hasCustomBackground && 'bg-white',
        elevated && 'shadow-soft',
        className
      )}
    >
      {children}
    </div>
  );
}
