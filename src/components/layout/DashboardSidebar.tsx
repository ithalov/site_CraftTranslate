import { NavLink } from 'react-router-dom';
import { BrandLogo } from '@/components/branding/BrandLogo';
import { Badge } from '@/components/ui/Badge';
import { dashboardNavItems } from '@/navigation/navigation';
import { classNames } from '@/utils/classNames';

export function DashboardSidebar() {
  return (
    <aside className="pixel-panel flex h-full flex-col gap-5 p-4">
      <div className="border-b border-[#dfe3ea] pb-4">
        <div className="flex items-start gap-3">
          <BrandLogo className="h-16 w-auto" />
          <div className="pt-1">
            <p className="pixel-label text-[10px] text-[#566172]">ChatTranslate</p>
            <div className="mt-2 flex items-center justify-between gap-3">
              <h2 className="minecraft-title text-2xl">Workspace</h2>
              <Badge tone="accent">beta</Badge>
            </div>
          </div>
        </div>
      </div>
      <nav className="grid gap-1">
        {dashboardNavItems.map((item, index) => (
          <NavLink
            key={item.to}
            to={item.to}
            className={({ isActive }) =>
              classNames(
                'flex items-center gap-3 rounded-md px-3 py-2.5 text-sm font-bold transition',
                isActive ? 'bg-[#101114] text-white' : 'text-[#566172] hover:bg-[#f0f2f6] hover:text-[#101114]'
              )
            }
          >
            <span className="font-[var(--font-display)] text-xs text-[#5652ff]">0{index + 1}</span>
            {item.label}
          </NavLink>
        ))}
      </nav>
      <div className="mt-auto rounded-md bg-[#f0f2f6] p-3">
        <p className="pixel-label text-[9px] text-[#566172]">Server status</p>
        <p className="mt-2 text-sm leading-5 text-[#566172]">Translation systems are online.</p>
      </div>
    </aside>
  );
}
