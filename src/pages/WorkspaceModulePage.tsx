import { useLocale } from '@/hooks/useLocale';
import { ProtectedFeaturePage } from '@/pages/ProtectedFeaturePage';
import type { LocaleCode } from '@/types/locale';

type WorkspaceModuleContent = {
  eyebrow: string;
  title: string;
  description: string;
  progressTitle: string;
  items: Array<{ title: string; description: string }>;
  progress: Array<{ label: string; value: number }>;
};

type WorkspaceModulePageProps = {
  content: Record<LocaleCode, WorkspaceModuleContent>;
};

export function WorkspaceModulePage({ content }: WorkspaceModulePageProps) {
  const { locale } = useLocale();
  return <ProtectedFeaturePage {...content[locale]} />;
}
