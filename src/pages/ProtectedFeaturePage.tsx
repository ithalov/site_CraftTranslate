import { PageShell } from '@/components/page/PageShell';
import { FeatureGrid } from '@/components/page/FeatureGrid';

type ProtectedFeaturePageProps = {
  eyebrow: string;
  title: string;
  description: string;
  items: Array<{
    title: string;
    description: string;
  }>;
  progress?: Array<{
    label: string;
    value: number;
  }>;
};

export function ProtectedFeaturePage({
  eyebrow,
  title,
  description,
  items,
  progress
}: ProtectedFeaturePageProps) {
  return (
    <PageShell eyebrow={eyebrow} title={title} description={description}>
      <FeatureGrid items={items} progress={progress} />
    </PageShell>
  );
}
