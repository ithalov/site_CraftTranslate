import { Badge } from '@/components/ui/Badge';
import { LocaleSwitcher } from '@/components/ui/LocaleSwitcher';
import { useAuth } from '@/hooks/useAuth';

export function DashboardTopbar() { const { user, signOut } = useAuth(); return <header className="flex flex-col gap-3 border-b border-[#dfe3ea] pb-5 lg:flex-row lg:items-center lg:justify-between"><div><p className="pixel-label text-[10px] text-[#566172]">Translation workspace</p><h1 className="minecraft-title mt-1 text-3xl">Command center</h1></div><div className="flex flex-wrap items-center gap-2"><Badge tone="success">online</Badge><Badge tone="neutral">{user?.email ?? 'Discord player'}</Badge><LocaleSwitcher /><button type="button" onClick={() => void signOut()} className="rounded-lg border-2 border-[#101114] bg-white px-3 py-2 font-[var(--font-display)] text-xs font-bold transition hover:-translate-x-0.5 hover:-translate-y-0.5 hover:shadow-[3px_3px_0_#101114]">Log out</button></div></header>; }
