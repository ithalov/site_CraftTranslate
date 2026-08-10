import { Link, NavLink } from 'react-router-dom';
import { BrandLogo } from '@/components/branding/BrandLogo';
import { useAuth } from '@/hooks/useAuth';
import { LocaleSwitcher } from '@/components/ui/LocaleSwitcher';
import { publicNavItems } from '@/navigation/navigation';
import { paths } from '@/navigation/paths';
import { classNames } from '@/utils/classNames';

type SiteHeaderProps = { appName: string };

export function SiteHeader({ appName }: SiteHeaderProps) {
  const { isAuthenticated, user } = useAuth();
  const userMetadata = user?.user_metadata ?? {};
  const avatarUrl =
    userMetadata.avatar_url ?? userMetadata.picture ?? userMetadata.avatar ?? userMetadata.image_url ?? '';
  const displayName =
    userMetadata.full_name ??
    userMetadata.name ??
    userMetadata.user_name ??
    userMetadata.preferred_username ??
    userMetadata.username ??
    user?.email ??
    'Player';

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
            {publicNavItems.filter((item) => isAuthenticated || item.to !== paths.login).map((item) => (
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
          {isAuthenticated ? (
            <Link
              to={paths.profile}
              className="flex items-center gap-3 rounded-full border-2 border-[#101114] bg-white px-3 py-2 transition hover:-translate-y-0.5 hover:shadow-[4px_4px_0_#101114]"
            >
              <span className="flex h-10 w-10 overflow-hidden rounded-full border border-[#dfe3ea] bg-[#101114]">
                {avatarUrl ? (
                  <img src={avatarUrl} alt={displayName} className="h-full w-full object-cover" />
                ) : (
                  <span className="grid h-full w-full place-items-center font-[var(--font-display)] text-sm font-bold text-[#c7f464]">
                    {displayName.slice(0, 1).toUpperCase()}
                  </span>
                )}
              </span>
              <span className="max-w-[160px] text-left">
                <span className="block truncate text-sm font-bold text-[#101114]">{displayName}</span>
                <span className="block text-[10px] uppercase tracking-[0.25em] text-[#566172]">Open profile</span>
              </span>
            </Link>
          ) : null}
        </div>
      </div>
    </header>
  );
}
