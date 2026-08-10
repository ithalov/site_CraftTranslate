import { useTheme } from '@/hooks/useTheme';

export function ThemeToggle() {
  const { theme, toggleTheme } = useTheme();
  const isDark = theme === 'dark';
  const label = isDark ? 'Ativar tema claro' : 'Ativar tema escuro';

  return <button type="button" aria-label={label} title={label} onClick={toggleTheme} className="grid h-11 w-11 place-items-center rounded-xl border-2 border-[#101114] bg-white text-[#101114] shadow-[3px_3px_0_#101114] transition hover:-translate-y-0.5 hover:shadow-[5px_5px_0_#101114]">
    {isDark ? <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5 text-[#c7a92d]" fill="none" stroke="currentColor" strokeWidth="2"><circle cx="12" cy="12" r="4" /><path d="M12 2v2m0 16v2M4.93 4.93l1.41 1.41m11.32 11.32 1.41 1.41M2 12h2m16 0h2M4.93 19.07l1.41-1.41M17.66 6.34l1.41-1.41" strokeLinecap="round" /></svg> : <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5 text-[#5652ff]" fill="none" stroke="currentColor" strokeWidth="2"><path d="M20.4 14.5A8.5 8.5 0 1 1 9.5 3.6 6.8 6.8 0 0 0 20.4 14.5Z" strokeLinecap="round" strokeLinejoin="round" /></svg>}
  </button>;
}
