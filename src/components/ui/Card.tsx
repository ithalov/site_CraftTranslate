import type { PropsWithChildren } from 'react';
import { classNames } from '@/utils/classNames';

type CardProps = PropsWithChildren<{
  className?: string;
  elevated?: boolean;
}>;

export function Card({ className, elevated = false, children }: CardProps) {
  return (
    <div
      className={classNames(
        'pixel-panel relative',
        elevated && 'shadow-soft',
        className
      )}
    >
      {children}
    </div>
  );
}
