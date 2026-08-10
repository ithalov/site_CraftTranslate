import { Badge } from '@/components/ui/Badge';
import { LocaleSwitcher } from '@/components/ui/LocaleSwitcher';
import { useAuth } from '@/hooks/useAuth';
import { useLocale } from '@/hooks/useLocale';

export function DashboardTopbar() {
  const { user, signOut } = useAuth();
  const { locale } = useLocale();
  const copy = locale === 'pt-BR'
    ? { eyebrow: 'Area de traducao', title: 'Central de comando', online: 'online', player: 'Jogador Discord', logout: 'Sair' }
    : locale === 'es'
      ? { eyebrow: 'Area de traduccion', title: 'Centro de control', online: 'en linea', player: 'Jugador de Discord', logout: 'Salir' }
      : { eyebrow: 'Translation workspace', title: 'Command center', online: 'online', player: 'Discord player', logout: 'Log out' };

  return <header className="flex flex-col gap-4 border-b border-[#dfe3ea] pb-5 lg:flex-row lg:items-center lg:justify-between"><div><p className="pixel-label text-[10px] text-[#566172]">{copy.eyebrow}</p><h1 className="minecraft-title mt-1 text-3xl">{copy.title}</h1></div><div className="flex flex-wrap items-center gap-2"><Badge tone="success">{copy.online}</Badge><Badge tone="neutral">{user?.email ?? copy.player}</Badge><LocaleSwitcher /><button type="button" onClick={() => void signOut()} className="rounded-xl border-2 border-[#101114] bg-white px-3 py-2.5 font-[var(--font-display)] text-xs font-bold transition hover:-translate-x-0.5 hover:-translate-y-0.5 hover:shadow-[3px_3px_0_#101114]">{copy.logout}</button></div></header>;
}
