import { ProtectedFeaturePage } from '@/pages/ProtectedFeaturePage';

export function ReviewPage() {
  return (
    <ProtectedFeaturePage
      eyebrow="Review"
      title="Review queue"
      description="Estrutura para auditoria humana, qualidade e consistência de tradução."
      items={[
        { title: 'Quality checks', description: 'Lista de validações para tom, terminologia e contexto.' },
        { title: 'Comment threads', description: 'Espaço para feedback e histórico de decisões.' },
        { title: 'Approval states', description: 'Base de aprovações, rejeições e pendências.' },
        { title: 'Audit trail', description: 'Preparado para rastrear mudanças e responsáveis.' }
      ]}
      progress={[
        { label: 'Pending', value: 44 },
        { label: 'Approved', value: 67 },
        { label: 'Needs edits', value: 22 }
      ]}
    />
  );
}
