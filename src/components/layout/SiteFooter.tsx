import { NavLink } from 'react-router-dom';
import { BrandLogo } from '@/components/branding/BrandLogo';
import { publicNavItems } from '@/navigation/navigation';
import { classNames } from '@/utils/classNames';

export function SiteFooter() {
  return (
    <footer className="mx-auto w-full max-w-7xl px-[var(--space-page)]">
      <div className="flex flex-col gap-4 border-t border-[#dfe3ea] py-7 text-sm text-[#566172] md:flex-row md:items-center md:justify-between">
        <div className="flex items-center gap-3">
          <BrandLogo className="h-10 w-auto" />
          <p>
            <span className="font-semibold text-[#101114]">ChatTranslate</span>{' '}
            <span className="text-[#2da44e]">//</span> made for Minecraft communities.
          </p>
        </div>
        <div className="flex gap-4">
          {publicNavItems.map((item) => (
            <NavLink
              key={item.to}
              to={item.to}
              className={({ isActive }) =>
                classNames('font-bold transition hover:text-[#5652ff]', isActive && 'text-[#101114]')
              }
            >
              {item.label}
            </NavLink>
          ))}
        </div>
      </div>
    </footer>
  );
}
