import { useEffect, useMemo, useState, type ReactNode } from 'react';
import { Badge } from '@/components/ui/Badge';
import { Card } from '@/components/ui/Card';
import { MetricCard } from '@/components/ui/MetricCard';
import { ProgressBar } from '@/components/ui/ProgressBar';
import { RouteLoadingScreen } from '@/components/layout/RouteLoadingScreen';
import { useLocale } from '@/hooks/useLocale';
import { fetchPublicStatusData, type PublicStatusData } from '@/services/publicStatus';

type StatusCopy = {
  eyebrow: string;
  title: ReactNode;
  lead: string;
  live: string;
  protected: string;
  updated: string;
  snapshot: string;
  translated: string;
  reviewed: string;
  official: string;
  heroStats: Array<{ label: string; hint: string }>;
  metrics: Array<[string, string]>;
  coverage: string;
  coverageLead: string;
  strings: string;
  approved: string;
  empty: string;
  error: string;
  publicOnly: string;
};

function languageLabel(language: PublicStatusData['languages'][number]) {
  return `${language.code} - ${language.name}`;
}

const copyByLocale: Record<'pt-BR' | 'en' | 'es', StatusCopy> = {
  'pt-BR': {
    eyebrow: 'Status publico',
    title: (
      <>
        A traducao esta
        <br />
        <span className="text-[#c7f464]">em movimento.</span>
      </>
    ),
    lead: 'Acompanhe o progresso da comunidade em tempo real sem expor strings, notas internas ou qualquer conteudo privado.',
    live: 'Dados publicos',
    protected: 'Conteudo protegido',
    updated: 'Atualizado pelo Supabase',
    snapshot: 'Panorama de cobertura',
    translated: 'Traduzido',
    reviewed: 'Revisado',
    official: 'Oficial',
    heroStats: [
      { label: 'Cobertura traduzida', hint: 'visao geral agregada' },
      { label: 'Cobertura revisada', hint: 'qualidade confirmada' },
      { label: 'Cobertura oficial', hint: 'aprovacao final' }
    ],
    metrics: [
      ['Strings', 'chaves de traducao'],
      ['Idiomas', 'comunidades ativas'],
      ['Colaboradores', 'perfis publicos'],
      ['Traducoes', 'sugestoes enviadas'],
      ['Revisoes', 'checagens de qualidade'],
      ['Cobertura oficial', 'versoes aprovadas']
    ],
    coverage: 'Cobertura por idioma',
    coverageLead: 'Cada card abaixo mostra apenas totais e percentuais agregados. O texto das strings nunca aparece aqui.',
    strings: 'Strings',
    approved: 'Aprovadas',
    empty: 'Nenhum idioma ativo foi encontrado ainda.',
    error: 'Nao foi possivel carregar o status do projeto.',
    publicOnly: 'Somente dados publicos'
  },
  en: {
    eyebrow: 'Public status',
    title: (
      <>
        Translation is
        <br />
        <span className="text-[#c7f464]">in motion.</span>
      </>
    ),
    lead: 'Track community progress in real time without exposing strings, internal notes, or any private content.',
    live: 'Public data',
    protected: 'Protected content',
    updated: 'Updated by Supabase',
    snapshot: 'Coverage snapshot',
    translated: 'Translated',
    reviewed: 'Reviewed',
    official: 'Official',
    heroStats: [
      { label: 'Translated coverage', hint: 'aggregate overview' },
      { label: 'Reviewed coverage', hint: 'quality confirmed' },
      { label: 'Official coverage', hint: 'final approval' }
    ],
    metrics: [
      ['Strings', 'translation keys'],
      ['Languages', 'active communities'],
      ['Contributors', 'public profiles'],
      ['Translations', 'submitted suggestions'],
      ['Reviews', 'quality checks'],
      ['Official coverage', 'approved versions']
    ],
    coverage: 'Coverage by language',
    coverageLead: 'Each card below shows only aggregate totals and percentages. String text never appears here.',
    strings: 'Strings',
    approved: 'Approved',
    empty: 'No active languages were found yet.',
    error: 'Unable to load project status.',
    publicOnly: 'Public data only'
  },
  es: {
    eyebrow: 'Estado publico',
    title: (
      <>
        La traduccion esta
        <br />
        <span className="text-[#c7f464]">en movimiento.</span>
      </>
    ),
    lead: 'Sigue el progreso de la comunidad en tiempo real sin exponer strings, notas internas ni contenido privado.',
    live: 'Datos publicos',
    protected: 'Contenido protegido',
    updated: 'Actualizado por Supabase',
    snapshot: 'Resumen de cobertura',
    translated: 'Traducido',
    reviewed: 'Revisado',
    official: 'Oficial',
    heroStats: [
      { label: 'Cobertura traducida', hint: 'vision general agregada' },
      { label: 'Cobertura revisada', hint: 'calidad confirmada' },
      { label: 'Cobertura oficial', hint: 'aprobacion final' }
    ],
    metrics: [
      ['Strings', 'claves de traduccion'],
      ['Idiomas', 'comunidades activas'],
      ['Colaboradores', 'perfiles publicos'],
      ['Traducciones', 'sugerencias enviadas'],
      ['Revisiones', 'controles de calidad'],
      ['Cobertura oficial', 'versiones aprobadas']
    ],
    coverage: 'Cobertura por idioma',
    coverageLead: 'Cada tarjeta muestra solo totales y porcentajes agregados. El texto nunca aparece aqui.',
    strings: 'Strings',
    approved: 'Aprobadas',
    empty: 'Todavia no se encontraron idiomas activos.',
    error: 'No se pudo cargar el estado del proyecto.',
    publicOnly: 'Solo datos publicos'
  }
};

export function StatusPage() {
  const { locale } = useLocale();
  const copy = copyByLocale[locale];
  const [data, setData] = useState<PublicStatusData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let active = true;

    void fetchPublicStatusData()
      .then((result) => {
        if (active) {
          setData(result);
        }
      })
      .catch((loadError: unknown) => {
        if (active) {
          setError(loadError instanceof Error ? loadError.message : copy.error);
        }
      })
      .finally(() => {
        if (active) {
          setLoading(false);
        }
      });

    return () => {
      active = false;
    };
  }, [copy.error]);

  const summary = data?.summary ?? {
    total_strings: 0,
    total_languages: 0,
    collaborators: 0,
    total_translations: 0,
    total_reviews: 0,
    translated_percent: 0,
    reviewed_percent: 0,
    official_percent: 0
  };

  const languages = useMemo(() => data?.languages.slice(0, 6) ?? [], [data]);
  const metricValues = [
    summary.total_strings,
    summary.total_languages,
    summary.collaborators,
    summary.total_translations,
    summary.total_reviews,
    `${summary.official_percent}%`
  ];
  const formatter = new Intl.NumberFormat(locale === 'pt-BR' ? 'pt-BR' : locale === 'es' ? 'es-ES' : 'en-US');

  if (loading) {
    return <RouteLoadingScreen />;
  }

  if (error) {
    return (
      <section className="grid min-h-[60vh] place-items-center px-[var(--space-page)]">
        <Card className="max-w-lg p-8 text-center">
          <p className="pixel-label text-[10px] text-[#566172]">ChatTranslate</p>
          <h1 className="minecraft-title mt-3 text-3xl text-[#101114]">{copy.error}</h1>
          <p className="mt-4 text-sm leading-7 text-[#566172]">{error}</p>
        </Card>
      </section>
    );
  }

  return (
    <section className="space-y-6 pb-12">
      <Card className="relative overflow-hidden bg-[#101114] p-0 text-white">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_12%_14%,rgba(199,244,100,.22),transparent_26%),radial-gradient(circle_at_85%_18%,rgba(76,201,240,.18),transparent_24%),radial-gradient(circle_at_84%_84%,rgba(255,184,107,.14),transparent_28%)]" />
        <div className="relative grid gap-8 px-6 py-9 md:px-10 md:py-12 lg:grid-cols-[1.05fr_.95fr] lg:items-center">
          <div>
            <p className="pixel-label text-[10px] text-[#c7f464]">{copy.eyebrow}</p>
            <h1 className="minecraft-title mt-4 text-4xl leading-[.92] md:text-6xl">{copy.title}</h1>
            <p className="mt-5 max-w-xl text-sm leading-7 text-white/75 md:text-base">{copy.lead}</p>
            <div className="mt-7 flex flex-wrap gap-2">
              <Badge tone="neutral" className="border-white/15 bg-white/10 text-white">
                {copy.live}
              </Badge>
              <Badge tone="neutral" className="border-white/15 bg-white/10 text-white">
                {copy.protected}
              </Badge>
              <Badge tone="neutral" className="border-white/15 bg-white/10 text-white">
                {copy.updated}
              </Badge>
            </div>
          </div>

          <div className="rounded-3xl border border-white/10 bg-white/[.07] p-5 backdrop-blur-sm">
            <div className="flex items-center justify-between">
              <p className="pixel-label text-[10px] text-white/60">{copy.snapshot}</p>
              <span className="h-2.5 w-2.5 rounded-full bg-[#c7f464] shadow-[0_0_14px_#c7f464]" />
            </div>
            <div className="mt-5 grid gap-3 sm:grid-cols-3 lg:grid-cols-1">
              {[
                [copy.translated, summary.translated_percent, '#c7f464'],
                [copy.reviewed, summary.reviewed_percent, '#4cc9f0'],
                [copy.official, summary.official_percent, '#ffb86b']
              ].map(([label, value, color]) => (
                <div key={label as string} className="rounded-2xl border border-white/10 bg-[#0d0f13]/35 p-4">
                  <p className="text-xs text-white/60">{label}</p>
                  <p className="mt-1 text-3xl font-extrabold" style={{ color: color as string }}>
                    {value}%
                  </p>
                </div>
              ))}
            </div>
            <div className="mt-4 rounded-2xl border border-white/10 bg-white/5 p-4">
              <p className="text-xs uppercase tracking-[0.24em] text-white/55">{copy.publicOnly}</p>
              <p className="mt-2 text-sm leading-6 text-white/72">
                {copy.lead}
              </p>
            </div>
          </div>
        </div>
      </Card>

      <div className="grid gap-4 sm:grid-cols-2 xl:grid-cols-3">
        {copy.heroStats.map((item, index) => (
          <Card key={item.label} className="overflow-hidden p-0">
            <div
              className="h-2"
              style={{
                background: ['linear-gradient(90deg, #c7f464, #87f5d8)', 'linear-gradient(90deg, #4cc9f0, #b7a7ff)', 'linear-gradient(90deg, #ffb86b, #ffe3a1)'][index]
              }}
            />
            <div className="p-5">
              <p className="pixel-label text-[10px] text-[#566172]">{item.label}</p>
              <p className="mt-2 text-sm text-[#566172]">{item.hint}</p>
              <div className="mt-4 flex items-end justify-between gap-4">
                <strong className="minecraft-title text-3xl tracking-tight text-[#101114]">
                  {formatter.format(index === 0 ? summary.translated_percent : index === 1 ? summary.reviewed_percent : summary.official_percent)}
                  %
                </strong>
                <span className="rounded-full border border-[#dfe3ea] bg-[#f7f8fb] px-2 py-1 text-[10px] text-[#566172]">
                  {copy.publicOnly}
                </span>
              </div>
            </div>
          </Card>
        ))}
      </div>

      <div className="grid gap-4 sm:grid-cols-2 xl:grid-cols-3">
        {copy.metrics.map(([label, hint], index) => (
          <MetricCard
            key={label}
            label={label}
            value={typeof metricValues[index] === 'number' ? formatter.format(metricValues[index] as number) : String(metricValues[index])}
            hint={hint}
          />
        ))}
      </div>

      <Card className="overflow-hidden p-0">
        <div className="flex flex-col gap-3 border-b-2 border-[#101114] bg-[#c7f464] px-6 py-4 md:flex-row md:items-center md:justify-between">
          <div>
            <p className="pixel-label text-[10px] text-[#101114]">{copy.coverage}</p>
            <p className="mt-1 text-sm font-bold text-[#101114]">{copy.coverageLead}</p>
          </div>
          <Badge tone="neutral" className="border-[#101114]/15 bg-white/45 text-[#101114]">
            {formatter.format(summary.total_languages)} {copy.metrics[1][0]}
          </Badge>
        </div>

        <div className="grid gap-5 p-5 md:p-6 xl:grid-cols-2">
          {languages.length ? (
            languages.map((language, index) => (
              <article
                key={language.language_id}
                className="group rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-5 transition duration-200 hover:-translate-y-1 hover:bg-white hover:shadow-[6px_6px_0_#101114]"
              >
                <div className="flex items-start justify-between gap-4">
                  <div>
                    <p className="font-[var(--font-display)] text-xl font-extrabold text-[#101114]">
                      {languageLabel(language)}
                    </p>
                    <p className="mt-1 text-sm text-[#566172]">{language.native_name}</p>
                  </div>
                  <Badge tone={index % 2 === 0 ? 'accent' : 'success'}>
                    {formatter.format(Number(language.official_percent ?? 0))}% {copy.official.toLowerCase()}
                  </Badge>
                </div>

                <div className="mt-6 space-y-4">
                  <ProgressBar label={copy.translated} value={Math.round(Number(language.translated_percent ?? 0))} tone="accent" />
                  <ProgressBar label={copy.reviewed} value={Math.round(Number(language.reviewed_percent ?? 0))} tone="success" />
                  <ProgressBar label={copy.official} value={Math.round(Number(language.official_percent ?? 0))} tone="warning" />
                </div>

                <div className="mt-6 grid grid-cols-2 gap-3">
                  <div className="rounded-xl border border-[#dfe3ea] bg-white p-3.5">
                    <p className="pixel-label text-[9px] text-[#566172]">{copy.strings}</p>
                    <p className="mt-2 text-xl font-extrabold text-[#101114]">
                      {formatter.format(Number(language.total_strings ?? 0))}
                    </p>
                  </div>
                  <div className="rounded-xl border border-[#dfe3ea] bg-white p-3.5">
                    <p className="pixel-label text-[9px] text-[#566172]">{copy.approved}</p>
                    <p className="mt-2 text-xl font-extrabold text-[#101114]">
                      {formatter.format(Number(language.official_count ?? 0))}
                    </p>
                  </div>
                </div>
              </article>
            ))
          ) : (
            <p className="rounded-xl border border-[#dfe3ea] bg-[#f7f8fb] p-6 text-sm text-[#566172] xl:col-span-2">
              {copy.empty}
            </p>
          )}
        </div>
      </Card>
    </section>
  );
}
