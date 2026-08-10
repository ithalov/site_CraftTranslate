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
  progressTitle?: string;
};

export function ProtectedFeaturePage({
  eyebrow,
  title,
  description,
  items,
  progress,
  progressTitle
}: ProtectedFeaturePageProps) {
  return (
    <PageShell eyebrow={eyebrow} title={title} description={description}>
      <FeatureGrid items={items} progress={progress} progressTitle={progressTitle} />
    </PageShell>
  );
}
