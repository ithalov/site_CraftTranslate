import { Badge } from '@/components/ui/Badge';
import { useLocale } from '@/hooks/useLocale';
import type { LocaleCode } from '@/types/locale';
import { classNames } from '@/utils/classNames';

const localeLabels: Record<LocaleCode, string> = {
  'pt-BR': 'PT-BR',
  en: 'EN',
  es: 'ES'
};

export function LocaleSwitcher() {
  const { locale, setLocale, locales } = useLocale();

  return (
    <div className="inline-flex items-center gap-1 rounded-md border-2 border-[#101114] bg-white p-1 shadow-[3px_3px_0_#101114]">
      <Badge tone="neutral" className="border-transparent bg-transparent px-1 py-1 text-[9px] tracking-[0.16em] text-[#566172]">
        LANG
      </Badge>
      {locales.map((item) => (
        <button
          key={item}
          type="button"
          onClick={() => setLocale(item)}
          className={classNames(
            'px-2 py-1 text-[10px] font-bold transition',
            locale === item ? 'rounded bg-[#c7f464] text-[#101114]' : 'text-[#566172] hover:bg-[#f0f2f6] hover:text-[#101114]'
          )}
        >
          {localeLabels[item]}
        </button>
      ))}
    </div>
  );
}
