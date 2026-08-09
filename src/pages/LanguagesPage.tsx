import { ProtectedFeaturePage } from '@/pages/ProtectedFeaturePage';

export function LanguagesPage() {
  return (
    <ProtectedFeaturePage
      eyebrow="Languages"
      title="Language workspace"
      description="Base para cadastrar, filtrar e organizar idiomas sem prender a interface a um formato único."
      items={[
        { title: 'Locale registry', description: 'Estrutura para idiomas suportados, variantes e metadados.' },
        { title: 'Display labels', description: 'Rótulos consistentes para navegação, listas e seletores.' },
        { title: 'Regional fallbacks', description: 'Ponto de partida para fallback e prioridade por região.' },
        { title: 'Import pipeline', description: 'Espaço reservado para importar e revisar novos idiomas.' }
      ]}
      progress={[
        { label: 'Registry', value: 72 },
        { label: 'Fallbacks', value: 48 },
        { label: 'UI coverage', value: 63 }
      ]}
    />
  );
}
