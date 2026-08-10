import { NavLink } from 'react-router-dom';
import { BrandLogo } from '@/components/branding/BrandLogo';
import { Badge } from '@/components/ui/Badge';
import { dashboardNavItems } from '@/navigation/navigation';
import { classNames } from '@/utils/classNames';
import { useLocale } from '@/hooks/useLocale';

export function DashboardSidebar() {
  const { locale } = useLocale();
  const copy = locale === 'pt-BR'
    ? { workspace: 'Espaco', beta: 'beta', status: 'Status do servidor', systems: 'Os sistemas de traducao estao online.' }
    : locale === 'es'
      ? { workspace: 'Espacio', beta: 'beta', status: 'Estado del servidor', systems: 'Los sistemas de traduccion estan en linea.' }
      : { workspace: 'Workspace', beta: 'beta', status: 'Server status', systems: 'Translation systems are online.' };
  return (
    <aside className="pixel-panel flex h-full flex-col gap-5 p-4 lg:p-5">
      <div className="border-b border-[#dfe3ea] pb-4">
        <div className="flex items-start gap-3">
          <BrandLogo className="h-16 w-auto" />
          <div className="pt-1">
            <p className="pixel-label text-[10px] text-[#566172]">ChatTranslate</p>
            <div className="mt-2 flex items-center justify-between gap-3">
              <h2 className="minecraft-title text-2xl">{copy.workspace}</h2>
              <Badge tone="accent">{copy.beta}</Badge>
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
                'flex items-center gap-3 rounded-xl px-3 py-3 text-sm font-bold transition duration-200',
                isActive ? 'bg-[#101114] text-white shadow-[3px_3px_0_#c7f464]' : 'text-[#566172] hover:translate-x-1 hover:bg-[#f0f2f6] hover:text-[#101114]'
              )
            }
          >
            <span className="font-[var(--font-display)] text-xs text-[#5652ff]">0{index + 1}</span>
            {item.label}
          </NavLink>
        ))}
      </nav>
      <div className="mt-auto rounded-xl border border-[#dfe3ea] bg-[#f0f2f6] p-3.5">
        <p className="pixel-label text-[9px] text-[#566172]">{copy.status}</p>
        <p className="mt-2 text-sm leading-5 text-[#566172]">{copy.systems}</p>
      </div>
    </aside>
  );
}
