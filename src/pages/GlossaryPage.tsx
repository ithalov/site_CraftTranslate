import { ProtectedFeaturePage } from '@/pages/ProtectedFeaturePage';

export function GlossaryPage() {
  return (
    <ProtectedFeaturePage
      eyebrow="Glossary"
      title="Terminology glossary"
      description="Base para termos aprovados, sinônimos e regras de consistência."
      items={[
        { title: 'Term cards', description: 'Cartões para termos, definições e exemplos.' },
        { title: 'Synonym rules', description: 'Camada para variações e preferência editorial.' },
        { title: 'Domain tags', description: 'Classificação por contexto, projeto ou comunidade.' },
        { title: 'Versioning', description: 'Espaço para evoluir termos sem quebrar traduções antigas.' }
      ]}
      progress={[
        { label: 'Approved terms', value: 77 },
        { label: 'Synonyms', value: 52 },
        { label: 'Coverage', value: 69 }
      ]}
    />
  );
}
