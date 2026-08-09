import { createContext, useContext, useEffect, useMemo, useState, type PropsWithChildren } from 'react';
import { localeList, type LocaleCode } from '@/types/locale';

const localeStorageKey = 'chattranslate.locale';

type LocaleContextValue = {
  locale: LocaleCode;
  setLocale: (locale: LocaleCode) => void;
  locales: readonly LocaleCode[];
};

const LocaleContext = createContext<LocaleContextValue | null>(null);

function isLocaleCode(value: string | null): value is LocaleCode {
  return Boolean(value && localeList.includes(value as LocaleCode));
}

export function LocaleProvider({ children }: PropsWithChildren) {
  const [locale, setLocaleState] = useState<LocaleCode>('pt-BR');

  useEffect(() => {
    const stored = window.localStorage.getItem(localeStorageKey);
    if (isLocaleCode(stored)) {
      setLocaleState(stored);
    } else {
      const browserLocale = navigator.language;
      if (browserLocale.startsWith('en')) {
        setLocaleState('en');
      } else if (browserLocale.startsWith('es')) {
        setLocaleState('es');
      }
    }
  }, []);

  useEffect(() => {
    window.localStorage.setItem(localeStorageKey, locale);
    document.documentElement.lang = locale;
    document.documentElement.dir = 'ltr';
  }, [locale]);

  const value = useMemo<LocaleContextValue>(
    () => ({
      locale,
      setLocale: setLocaleState,
      locales: localeList
    }),
    [locale]
  );

  return <LocaleContext.Provider value={value}>{children}</LocaleContext.Provider>;
}

export function useLocaleContext() {
  const context = useContext(LocaleContext);

  if (!context) {
    throw new Error('useLocaleContext must be used within LocaleProvider');
  }

  return context;
}
