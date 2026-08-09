import { ProtectedFeaturePage } from '@/pages/ProtectedFeaturePage';

export function AdminPage() {
  return (
    <ProtectedFeaturePage
      eyebrow="Admin"
      title="Admin controls"
      description="Espaço reservado para governança, moderação e configurações avançadas."
      items={[
        { title: 'Role controls', description: 'Base para papéis, permissões e escopos de acesso.' },
        { title: 'Moderation tools', description: 'Ponto de partida para revisão e ações administrativas.' },
        { title: 'System settings', description: 'Configurações de ambiente e produto.' },
        { title: 'Release controls', description: 'Fluxo preparado para versões e manutenção.' }
      ]}
      progress={[
        { label: 'Access rules', value: 36 },
        { label: 'Moderation', value: 54 },
        { label: 'Maintenance', value: 25 }
      ]}
    />
  );
}
