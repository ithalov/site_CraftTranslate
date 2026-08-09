import { ProtectedFeaturePage } from '@/pages/ProtectedFeaturePage';

export function TranslatePage() {
  return (
    <ProtectedFeaturePage
      eyebrow="Translate"
      title="Translation studio"
      description="Base visual para traduzir conteúdo com contexto, status e fluxo colaborativo."
      items={[
        { title: 'Source panel', description: 'Áreas separadas para conteúdo original e tradução.' },
        { title: 'Suggestion layer', description: 'Espaço para sugestões, revisão e edição assistida.' },
        { title: 'Status timeline', description: 'Linha do tempo para rascunho, revisão e publicação.' },
        { title: 'Keyboard-ready', description: 'Estrutura preparada para atalhos e trabalho rápido.' }
      ]}
      progress={[
        { label: 'Drafting', value: 81 },
        { label: 'Context', value: 58 },
        { label: 'Publish', value: 39 }
      ]}
    />
  );
}
