import { useEffect, useId, useRef, useState } from 'react';
import { useLocale } from '@/hooks/useLocale';
import type { LocaleCode } from '@/types/locale';
import { classNames } from '@/utils/classNames';

const localeDetails: Record<LocaleCode, { short: string; name: string; nativeName: string }> = {
  'pt-BR': { short: 'PT-BR', name: 'Portuguese (Brazil)', nativeName: 'Portugues (Brasil)' },
  en: { short: 'EN', name: 'English', nativeName: 'English' },
  es: { short: 'ES', name: 'Spanish', nativeName: 'Espanol' }
};

export function LocaleSwitcher() {
  const { locale, setLocale, locales } = useLocale();
  const [isOpen, setIsOpen] = useState(false);
  const rootRef = useRef<HTMLDivElement>(null);
  const menuId = useId();
  const current = localeDetails[locale];

  useEffect(() => {
    function closeOnOutsideClick(event: MouseEvent) {
      if (rootRef.current && !rootRef.current.contains(event.target as Node)) {
        setIsOpen(false);
      }
    }

    function closeOnEscape(event: KeyboardEvent) {
      if (event.key === 'Escape') setIsOpen(false);
    }

    document.addEventListener('mousedown', closeOnOutsideClick);
    document.addEventListener('keydown', closeOnEscape);
    return () => {
      document.removeEventListener('mousedown', closeOnOutsideClick);
      document.removeEventListener('keydown', closeOnEscape);
    };
  }, []);

  return (
    <div ref={rootRef} className="relative z-30">
      <button
        type="button"
        aria-expanded={isOpen}
        aria-controls={menuId}
        onClick={() => setIsOpen((currentState) => !currentState)}
        className={classNames(
          'group flex min-h-11 items-center gap-2 rounded-xl border-2 border-[#101114] bg-white px-3 text-left shadow-[3px_3px_0_#101114] transition duration-200 hover:-translate-y-0.5 hover:shadow-[5px_5px_0_#101114]',
          isOpen && '-translate-y-0.5 shadow-[5px_5px_0_#101114]'
        )}
      >
        <span className="grid h-6 w-6 place-items-center rounded-md bg-[#c7f464] font-[var(--font-display)] text-[10px] font-extrabold text-[#101114]">
          {current.short.slice(0, 2)}
        </span>
        <span className="hidden min-w-[62px] sm:block">
          <span className="pixel-label block text-[9px] leading-none text-[#566172]">Idioma</span>
          <span className="mt-1 block text-[11px] font-extrabold leading-none text-[#101114]">{current.short}</span>
        </span>
        <svg
          aria-hidden="true"
          viewBox="0 0 16 16"
          className={classNames('h-4 w-4 text-[#566172] transition-transform duration-200', isOpen && 'rotate-180')}
        >
          <path d="m3 6 5 5 5-5" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
        </svg>
      </button>

      <div
        id={menuId}
        className={classNames(
          'absolute right-0 top-[calc(100%+0.65rem)] w-56 origin-top-right rounded-2xl border-2 border-[#101114] bg-white p-2 shadow-[6px_6px_0_#101114] transition duration-200',
          isOpen ? 'pointer-events-auto translate-y-0 scale-100 opacity-100' : 'pointer-events-none -translate-y-2 scale-95 opacity-0'
        )}
      >
        <p className="px-2 pb-2 pt-1 text-[9px] font-extrabold uppercase tracking-[0.24em] text-[#566172]">Escolha o idioma</p>
        {locales.map((item) => {
          const itemDetails = localeDetails[item];
          const isSelected = item === locale;

          return (
            <button
              key={item}
              type="button"
              onClick={() => {
                setLocale(item);
                setIsOpen(false);
              }}
              className={classNames(
                'flex w-full items-center gap-3 rounded-xl px-3 py-2.5 text-left transition',
                isSelected ? 'bg-[#101114] text-white' : 'text-[#101114] hover:bg-[#f0f2f6]'
              )}
            >
              <span className={classNames('grid h-8 min-w-10 place-items-center rounded-lg border text-[10px] font-extrabold', isSelected ? 'border-white/20 bg-white/10' : 'border-[#dfe3ea] bg-white')}>
                {itemDetails.short}
              </span>
              <span>
                <span className="block text-xs font-extrabold">{itemDetails.nativeName}</span>
                <span className={classNames('mt-0.5 block text-[10px]', isSelected ? 'text-white/65' : 'text-[#566172]')}>{itemDetails.name}</span>
              </span>
              {isSelected ? <span className="ml-auto text-[#c7f464]">✓</span> : null}
            </button>
          );
        })}
      </div>
    </div>
  );
}
