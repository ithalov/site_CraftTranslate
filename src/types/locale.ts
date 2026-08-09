export const localeList = ['pt-BR', 'en', 'es'] as const;

export type LocaleCode = (typeof localeList)[number];

export type LocaleLabel = {
  code: LocaleCode;
  label: string;
  nativeLabel: string;
};
