import { ProtectedFeaturePage } from '@/pages/ProtectedFeaturePage';

export function DashboardPage() {
  return (
    <ProtectedFeaturePage
      eyebrow="Dashboard"
      title="Workspace overview"
      description="Visão geral do produto com métricas, status e áreas de trabalho conectadas."
      items={[
        { title: 'Activity feed', description: 'Resumo de eventos e ações recentes.' },
        { title: 'Translation health', description: 'Base para qualidade e velocidade do fluxo.' },
        { title: 'Community signals', description: 'Indicadores de engajamento e moderação.' },
        { title: 'Release surface', description: 'Espaço para lançamentos e marcos do produto.' }
      ]}
      progress={[
        { label: 'Health', value: 84 },
        { label: 'Activity', value: 71 },
        { label: 'Release readiness', value: 47 }
      ]}
    />
  );
}
