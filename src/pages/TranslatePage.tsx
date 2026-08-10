import { Link, useSearchParams } from 'react-router-dom';
import { Card } from '@/components/ui/Card';
import { Badge } from '@/components/ui/Badge';
import { FeatureGrid } from '@/components/page/FeatureGrid';
import { PageShell } from '@/components/page/PageShell';
import { useLocale } from '@/hooks/useLocale';
import { paths } from '@/navigation/paths';

type TranslateCopy = {
  eyebrow: string;
  title: string;
  description: string;
  progressTitle: string;
  selectedSession: string;
  languageLabel: string;
  categoryLabel: string;
  sessionReady: string;
  openLanguage: string;
  openCategory: string;
  noSession: string;
  items: Array<{ title: string; description: string }>;
  progress: Array<{ label: string; value: number }>;
};

function formatCategoryLabel(category: string) {
  return category
    .replace(/_/g, ' ')
    .replace(/\b\w/g, (char) => char.toUpperCase());
}

function buildLanguagePath(code: string) {
  return paths.languageDetail.replace(':code', encodeURIComponent(code));
}

const copyByLocale: Record<'pt-BR' | 'en' | 'es', TranslateCopy> = {
  'pt-BR': {
    eyebrow: 'Traduzir',
    title: 'Estudio de traducao',
    description: 'Traduza com contexto, qualidade e um fluxo colaborativo claro.',
    progressTitle: 'Fluxo de traducao',
    selectedSession: 'Sessao selecionada',
    languageLabel: 'Idioma',
    categoryLabel: 'Categoria',
    sessionReady: 'Sessao pronta para continuar.',
    openLanguage: 'Abrir idioma',
    openCategory: 'Categoria aberta',
    noSession: 'Selecione um idioma e uma categoria para iniciar a sessao direta de traducao.',
    items: [
      { title: 'Texto de origem', description: 'Conteudo original preservado com o contexto necessario.' },
      { title: 'Sugestoes', description: 'Espaco para escrever, comparar e aperfeicoar alternativas.' },
      { title: 'Status da tarefa', description: 'Acompanhe rascunho, revisao e publicacao.' },
      { title: 'Atalhos rapidos', description: 'Estrutura preparada para um trabalho mais agil.' }
    ],
    progress: [
      { label: 'Rascunhos', value: 81 },
      { label: 'Contexto', value: 58 },
      { label: 'Publicacao', value: 39 }
    ]
  },
  en: {
    eyebrow: 'Translate',
    title: 'Translation studio',
    description: 'Translate with context, quality, and a clear collaborative flow.',
    progressTitle: 'Translation flow',
    selectedSession: 'Selected session',
    languageLabel: 'Language',
    categoryLabel: 'Category',
    sessionReady: 'Session ready to continue.',
    openLanguage: 'Open language',
    openCategory: 'Open category',
    noSession: 'Choose a language and a category to start a direct translation session.',
    items: [
      { title: 'Source text', description: 'Original content preserved with the needed context.' },
      { title: 'Suggestions', description: 'A space to write, compare, and improve alternatives.' },
      { title: 'Task status', description: 'Follow draft, review, and publishing.' },
      { title: 'Quick shortcuts', description: 'A structure ready for faster work.' }
    ],
    progress: [
      { label: 'Drafts', value: 81 },
      { label: 'Context', value: 58 },
      { label: 'Publishing', value: 39 }
    ]
  },
  es: {
    eyebrow: 'Traducir',
    title: 'Estudio de traduccion',
    description: 'Traduce con contexto, calidad y un flujo colaborativo claro.',
    progressTitle: 'Flujo de traduccion',
    selectedSession: 'Sesion seleccionada',
    languageLabel: 'Idioma',
    categoryLabel: 'Categoria',
    sessionReady: 'Sesion lista para continuar.',
    openLanguage: 'Abrir idioma',
    openCategory: 'Abrir categoria',
    noSession: 'Elige un idioma y una categoria para iniciar una sesion directa de traduccion.',
    items: [
      { title: 'Texto de origen', description: 'Contenido original preservado con el contexto necesario.' },
      { title: 'Sugerencias', description: 'Espacio para escribir, comparar y mejorar alternativas.' },
      { title: 'Estado de tarea', description: 'Sigue borrador, revision y publicacion.' },
      { title: 'Atajos rapidos', description: 'Estructura lista para un trabajo mas agil.' }
    ],
    progress: [
      { label: 'Borradores', value: 81 },
      { label: 'Contexto', value: 58 },
      { label: 'Publicacion', value: 39 }
    ]
  }
};

export function TranslatePage() {
  const { locale } = useLocale();
  const copy = copyByLocale[locale];
  const [searchParams] = useSearchParams();
  const language = searchParams.get('language')?.trim() ?? '';
  const category = searchParams.get('category')?.trim() ?? '';

  return (
    <PageShell eyebrow={copy.eyebrow} title={copy.title} description={copy.description}>
      <div className="space-y-6">
        <Card className="overflow-hidden border-2 border-[#101114] bg-[#101114] p-0 text-white shadow-[8px_8px_0_#c7f464]">
          <div className="relative overflow-hidden px-6 py-8 md:px-8 md:py-10">
            <div className="absolute inset-0 bg-[radial-gradient(circle_at_20%_20%,rgba(199,244,100,.18),transparent_28%),radial-gradient(circle_at_82%_22%,rgba(76,201,240,.16),transparent_30%)]" />
            <div className="relative grid gap-6 lg:grid-cols-[1.05fr_.95fr] lg:items-center">
              <div>
                <p className="pixel-label text-[10px] text-[#c7f464]">{copy.selectedSession}</p>
                <h1 className="minecraft-title mt-3 text-4xl leading-none md:text-6xl">{copy.title}</h1>
                <p className="mt-4 max-w-2xl text-sm leading-7 text-white/72 md:text-base">{copy.description}</p>

                <div className="mt-6 flex flex-wrap gap-2">
                  {language ? <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">{copy.languageLabel}: {language}</Badge> : null}
                  {category ? <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">{copy.categoryLabel}: {formatCategoryLabel(category)}</Badge> : null}
                  {language && category ? <Badge tone="success">{copy.sessionReady}</Badge> : null}
                </div>

                <div className="mt-7 flex flex-wrap gap-3">
                  {language ? (
                    <Link to={buildLanguagePath(language)} className="block-button-secondary inline-flex px-5 py-3 text-sm">
                      {copy.openLanguage}
                    </Link>
                  ) : null}
                  {language && category ? (
                    <Badge tone="accent" className="px-4 py-3 text-sm">
                      {copy.openCategory}: {formatCategoryLabel(category)}
                    </Badge>
                  ) : (
                    <Badge tone="neutral" className="px-4 py-3 text-sm">
                      {copy.noSession}
                    </Badge>
                  )}
                </div>
              </div>

              <div className="rounded-3xl border border-white/10 bg-white/[.06] p-5 backdrop-blur-sm">
                <p className="pixel-label text-[10px] text-[#c7f464]">{copy.progressTitle}</p>
                <div className="mt-4 grid gap-3 sm:grid-cols-3 lg:grid-cols-1">
                  {copy.progress.map((item) => (
                    <div key={item.label} className="rounded-2xl border border-white/10 bg-white/[.06] p-4">
                      <p className="text-xs uppercase tracking-[0.24em] text-white/50">{item.label}</p>
                      <p className="mt-2 text-3xl font-extrabold text-white">{item.value}%</p>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          </div>
        </Card>

        <FeatureGrid items={copy.items} progress={copy.progress} progressTitle={copy.progressTitle} />
      </div>
    </PageShell>
  );
}
