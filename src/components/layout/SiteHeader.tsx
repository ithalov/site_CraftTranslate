import { NavLink } from 'react-router-dom';
import { BrandLogo } from '@/components/branding/BrandLogo';
import { LocaleSwitcher } from '@/components/ui/LocaleSwitcher';
import { publicNavItems } from '@/navigation/navigation';
import { classNames } from '@/utils/classNames';

type SiteHeaderProps = { appName: string };

export function SiteHeader({ appName }: SiteHeaderProps) {
  return (
    <header className="mx-auto w-full max-w-7xl px-[var(--space-page)] py-5">
      <div className="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
        <NavLink to="/" className="flex items-center gap-3">
          <BrandLogo className="h-14 w-auto drop-shadow-[0_10px_20px_rgba(0,0,0,0.14)]" />
          <span>
            <span className="block font-[var(--font-display)] text-base font-bold">{appName}</span>
            <span className="pixel-label mt-0.5 block text-[9px] text-[#566172]">
              community translator
            </span>
          </span>
        </NavLink>
        <div className="flex flex-wrap items-center gap-4">
          <nav className="flex flex-wrap gap-4 text-sm font-bold text-[#566172]">
            {publicNavItems.map((item) => (
              <NavLink
                key={item.to}
                to={item.to}
                className={({ isActive }) =>
                  classNames('transition hover:text-[#5652ff]', isActive && 'text-[#101114]')
                }
              >
                {item.label}
              </NavLink>
            ))}
          </nav>
          <LocaleSwitcher />
        </div>
      </div>
    </header>
  );
}
