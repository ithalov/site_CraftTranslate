import { Link } from 'react-router-dom';
import { paths } from '@/navigation/paths';

type RouteErrorStateProps = {
  title: string;
  description: string;
  actionLabel: string;
  actionTo?: string;
};

export function RouteErrorState({
  title,
  description,
  actionLabel,
  actionTo = paths.home
}: RouteErrorStateProps) {
  return (
    <div className="grid min-h-[60vh] place-items-center px-6">
      <div className="w-full max-w-xl rounded-[var(--radius-card)] border border-line bg-surface/80 p-8 text-center shadow-soft">
        <p className="text-[10px] uppercase tracking-[0.34em] text-cyan-200/80">ChatTranslate</p>
        <h2 className="mt-3 text-3xl font-semibold text-white">{title}</h2>
        <p className="mt-3 text-base leading-7 text-slate-300">{description}</p>
        <div className="mt-6">
          <Link
            to={actionTo}
            className="inline-flex rounded-full bg-white px-5 py-2.5 text-sm font-semibold text-slate-950 transition hover:bg-cyan-100"
          >
            {actionLabel}
          </Link>
        </div>
      </div>
    </div>
  );
}
