import { useDeferredValue, useEffect, useMemo, useState } from 'react';
import { Link } from 'react-router-dom';
import { Badge } from '@/components/ui/Badge';
import { Card } from '@/components/ui/Card';
import { MetricCard } from '@/components/ui/MetricCard';
import { ProgressBar } from '@/components/ui/ProgressBar';
import { PageShell } from '@/components/page/PageShell';
import { RouteLoadingScreen } from '@/components/layout/RouteLoadingScreen';
import { useLocale } from '@/hooks/useLocale';
import { paths } from '@/navigation/paths';
import { classNames } from '@/utils/classNames';
import {
  fetchPublicLanguageCatalog,
  type PublicLanguageCatalogItem
} from '@/services/publicLanguages';
import { subscribeToTranslationDataRefresh } from '@/services/translations/translationRefresh';

type SortKey = 'progress' | 'collaborators' | 'official' | 'name';
type DirectionFilter = 'all' | 'ltr' | 'rtl';

type LanguagesCopy = {
  eyebrow: string;
  title: string;
  description: string;
  search: string;
  searchPlaceholder: string;
  filters: string;
  sort: string;
  all: string;
  ltr: string;
  rtl: string;
  progress: string;
  collaborators: string;
  official: string;
  empty: string;
  explore: string;
  detail: string;
  metrics: Array<[string, string]>;
};

const copyByLocale: Record<'pt-BR' | 'en' | 'es', LanguagesCopy> = {
  'pt-BR': {
    eyebrow: 'Idiomas',
    title: 'Catalogo de idiomas',
    description: 'Encontre idiomas ativos, compare cobertura e abra a pagina propria de cada idioma para ver equipe, lider e contribuidores.',
    search: 'Buscar',
    searchPlaceholder: 'Pesquisar por nome, codigo ou idioma nativo',
    filters: 'Filtros',
    sort: 'Ordenar',
    all: 'Todos',
    ltr: 'LTR',
    rtl: 'RTL',
    progress: 'Progresso',
    collaborators: 'Colaboradores',
    official: 'Oficial',
    empty: 'Nenhum idioma encontrado com esses filtros.',
    explore: 'Explorar idioma',
    detail: 'Abrir detalhe',
    metrics: [
      ['Idiomas ativos', 'catalogo publico'],
      ['Colaboradores', 'pessoas envolvidas'],
      ['Cobertura media', 'visao geral'],
      ['Melhor idioma', 'mais avancado']
    ]
  },
  en: {
    eyebrow: 'Languages',
    title: 'Language catalog',
    description: 'Find active languages, compare coverage, and open each language page to see the team, lead, and contributors.',
    search: 'Search',
    searchPlaceholder: 'Search by name, code, or native language',
    filters: 'Filters',
    sort: 'Sort',
    all: 'All',
    ltr: 'LTR',
    rtl: 'RTL',
    progress: 'Progress',
    collaborators: 'Collaborators',
    official: 'Official',
    empty: 'No languages matched your filters.',
    explore: 'Explore language',
    detail: 'Open details',
    metrics: [
      ['Active languages', 'public catalog'],
      ['Collaborators', 'people involved'],
      ['Average coverage', 'global view'],
      ['Top language', 'most advanced']
    ]
  },
  es: {
    eyebrow: 'Idiomas',
    title: 'Catalogo de idiomas',
    description: 'Encuentra idiomas activos, compara cobertura y abre la pagina de cada idioma para ver equipo, lider y contribuidores.',
    search: 'Buscar',
    searchPlaceholder: 'Buscar por nombre, codigo o idioma nativo',
    filters: 'Filtros',
    sort: 'Ordenar',
    all: 'Todos',
    ltr: 'LTR',
    rtl: 'RTL',
    progress: 'Progreso',
    collaborators: 'Colaboradores',
    official: 'Oficial',
    empty: 'No se encontraron idiomas con estos filtros.',
    explore: 'Explorar idioma',
    detail: 'Abrir detalle',
    metrics: [
      ['Idiomas activos', 'catalogo publico'],
      ['Colaboradores', 'personas involucradas'],
      ['Cobertura media', 'vista general'],
      ['Mejor idioma', 'mas avanzado']
    ]
  }
};

function getLocaleTag(locale: 'pt-BR' | 'en' | 'es') {
  return locale === 'pt-BR' ? 'pt-BR' : locale === 'es' ? 'es-ES' : 'en-US';
}

function languageEmoji(language: PublicLanguageCatalogItem) {
  return language.emoji ?? '🌐';
}

function getDetailPath(code: string) {
  return paths.languageDetail.replace(':code', encodeURIComponent(code));
}

function sortLanguages(items: PublicLanguageCatalogItem[], sortBy: SortKey) {
  const sorted = [...items];

  sorted.sort((a, b) => {
    if (sortBy === 'collaborators') {
      const diff = b.collaborators_count - a.collaborators_count;
      if (diff !== 0) return diff;
      return b.official_percent - a.official_percent;
    }

    if (sortBy === 'official') {
      const diff = b.official_percent - a.official_percent;
      if (diff !== 0) return diff;
      return b.reviewed_percent - a.reviewed_percent;
    }

    if (sortBy === 'name') {
      return a.name.localeCompare(b.name);
    }

    const diff = b.translated_percent - a.translated_percent;
    if (diff !== 0) return diff;
    return b.reviewed_percent - a.reviewed_percent;
  });

  return sorted;
}

function matchesDirection(language: PublicLanguageCatalogItem, filter: DirectionFilter) {
  if (filter === 'all') {
    return true;
  }

  return language.direction === filter;
}

function LanguageCard({
  language,
  locale
}: {
  language: PublicLanguageCatalogItem;
  locale: 'pt-BR' | 'en' | 'es';
}) {
  const formatter = new Intl.NumberFormat(getLocaleTag(locale));
  const detailPath = getDetailPath(language.code);

  return (
    <Link
      to={detailPath}
      className="group block rounded-[28px] border-2 border-[#101114] bg-white p-5 transition duration-200 hover:-translate-y-1 hover:shadow-[8px_8px_0_#101114]"
    >
      <div className="flex items-start justify-between gap-4">
        <div className="flex items-start gap-4">
          <div className="flex h-14 w-14 items-center justify-center rounded-2xl border-2 border-[#101114] bg-[#f7f8fb] text-2xl shadow-[4px_4px_0_#c7f464]">
            {languageEmoji(language)}
          </div>
          <div>
            <p className="pixel-label text-[10px] text-[#566172]">{language.code}</p>
            <h3 className="mt-2 text-2xl font-extrabold text-[#101114]">{language.name}</h3>
            <p className="mt-1 text-sm text-[#566172]">{language.native_name}</p>
          </div>
        </div>
        <Badge tone={language.direction === 'rtl' ? 'warning' : 'accent'}>
          {language.direction.toUpperCase()}
        </Badge>
      </div>

      <div className="mt-5 flex flex-wrap gap-2">
        <Badge tone="neutral">{formatter.format(language.collaborators_count)} {locale === 'pt-BR' ? 'colaboradores' : locale === 'es' ? 'colaboradores' : 'collaborators'}</Badge>
        <Badge tone="neutral">{formatter.format(language.active_translators)} {locale === 'pt-BR' ? 'tradutores' : locale === 'es' ? 'traductores' : 'translators'}</Badge>
        <Badge tone="neutral">{formatter.format(language.active_reviewers)} {locale === 'pt-BR' ? 'revisores' : locale === 'es' ? 'revisores' : 'reviewers'}</Badge>
      </div>

      <div className="mt-5 space-y-4">
        <ProgressBar label="Translated" value={Math.round(language.translated_percent)} tone="accent" />
        <ProgressBar label="Reviewed" value={Math.round(language.reviewed_percent)} tone="success" />
        <ProgressBar label="Official" value={Math.round(language.official_percent)} tone="warning" />
      </div>

      <div className="mt-5 grid grid-cols-2 gap-3">
        <div className="rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-3.5">
          <p className="pixel-label text-[9px] text-[#566172]">{locale === 'pt-BR' ? 'Cobertura traduzida' : locale === 'es' ? 'Cobertura traducida' : 'Translated coverage'}</p>
          <p className="mt-2 text-2xl font-extrabold text-[#101114]">{formatter.format(Math.round(language.translated_percent))}%</p>
        </div>
        <div className="rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-3.5">
          <p className="pixel-label text-[9px] text-[#566172]">{locale === 'pt-BR' ? 'Cobertura oficial' : locale === 'es' ? 'Cobertura oficial' : 'Official coverage'}</p>
          <p className="mt-2 text-2xl font-extrabold text-[#101114]">{formatter.format(Math.round(language.official_percent))}%</p>
        </div>
      </div>

      <div className="mt-5 flex items-center justify-between gap-3 border-t border-[#dfe3ea] pt-4">
        <p className="text-sm text-[#566172]">
          {locale === 'pt-BR' ? 'Idioma com pagina propria e equipe publica.' : locale === 'es' ? 'Idioma con pagina propia y equipo publico.' : 'Language with its own page and public team.'}
        </p>
        <span className="font-[var(--font-display)] text-sm font-bold text-[#5652ff]">
          {locale === 'pt-BR' ? 'Abrir detalhe' : locale === 'es' ? 'Abrir detalle' : 'Open details'} →
        </span>
      </div>
    </Link>
  );
}

export function LanguagesPage() {
  const { locale } = useLocale();
  const copy = copyByLocale[locale];
  const [languages, setLanguages] = useState<PublicLanguageCatalogItem[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [search, setSearch] = useState('');
  const [sortBy, setSortBy] = useState<SortKey>('progress');
  const [direction, setDirection] = useState<DirectionFilter>('all');
  const deferredSearch = useDeferredValue(search);

  useEffect(() => {
    let active = true;

    async function load() {
      try {
        setLoading(true);
        setError(null);
        const result = await fetchPublicLanguageCatalog();

        if (active) {
          setLanguages(result);
        }
      } catch (loadError) {
        if (active) {
          setError(loadError instanceof Error ? loadError.message : copy.empty);
        }
      } finally {
        if (active) {
          setLoading(false);
        }
      }
    }

    void load();
    const unsubscribe = subscribeToTranslationDataRefresh(() => {
      void load();
    });

    return () => {
      active = false;
      unsubscribe();
    };
  }, [copy.empty]);

  const filteredLanguages = useMemo(() => {
    const query = deferredSearch.trim().toLowerCase();

    return sortLanguages(
      languages.filter((language) => {
        const matchesSearch =
          query.length === 0 ||
          [language.code, language.name, language.native_name].some((value) => value.toLowerCase().includes(query));

        return matchesSearch && matchesDirection(language, direction);
      }),
      sortBy
    );
  }, [deferredSearch, direction, languages, sortBy]);

  const summary = useMemo(() => {
    const totalLanguages = languages.length;
    const totalCollaborators = languages.reduce((sum, language) => sum + language.collaborators_count, 0);
    const averageCoverage =
      totalLanguages === 0
        ? 0
        : Math.round(
            languages.reduce((sum, language) => sum + Number(language.official_percent ?? 0), 0) / totalLanguages
          );
    const topLanguage = [...languages].sort((a, b) => b.official_percent - a.official_percent)[0];

    return {
      totalLanguages,
      totalCollaborators,
      averageCoverage,
      topLanguage: topLanguage ? `${topLanguage.name} (${topLanguage.official_percent.toFixed(0)}%)` : '-'
    };
  }, [languages]);

  if (loading) {
    return <RouteLoadingScreen />;
  }

  if (error) {
    return (
      <PageShell eyebrow={copy.eyebrow} title={copy.title} description={copy.description}>
        <Card className="p-8 text-center">
          <h1 className="minecraft-title text-3xl text-[#101114]">
            {locale === 'pt-BR' ? 'Nao foi possivel carregar os idiomas' : locale === 'es' ? 'No se pudieron cargar los idiomas' : 'Unable to load languages'}
          </h1>
          <p className="mt-4 text-sm leading-7 text-[#566172]">{error}</p>
        </Card>
      </PageShell>
    );
  }

  return (
    <PageShell eyebrow={copy.eyebrow} title={copy.title} description={copy.description}>
      <div className="space-y-6">
        <Card className="overflow-hidden bg-[#101114] p-0 text-white">
          <div className="grid gap-6 px-6 py-6 md:px-8 md:py-8 lg:grid-cols-[1.08fr_.92fr] lg:items-center">
            <div>
              <p className="pixel-label text-[10px] text-[#c7f464]">{copy.filters}</p>
              <h2 className="minecraft-title mt-3 text-4xl leading-[.95] md:text-5xl">
                {locale === 'pt-BR' ? 'Um catalogo publico e organizado.' : locale === 'es' ? 'Un catalogo publico y ordenado.' : 'A public catalog built for clarity.'}
              </h2>
              <p className="mt-4 max-w-2xl text-sm leading-7 text-white/70 md:text-base">
                {copy.description}
              </p>
              <div className="mt-5 flex flex-wrap gap-2">
                <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">
                  {summary.totalLanguages} {copy.metrics[0][0]}
                </Badge>
                <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">
                  {summary.totalCollaborators} {copy.metrics[1][0]}
                </Badge>
                <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">
                  {summary.averageCoverage}% {copy.metrics[2][0]}
                </Badge>
              </div>
            </div>

            <div className="rounded-3xl border border-white/10 bg-white/5 p-4">
              <p className="text-[10px] uppercase tracking-[0.3em] text-white/50">
                {copy.metrics[3][0]}
              </p>
              <div className="mt-4 grid gap-3">
                <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                  <p className="text-xs text-white/60">{copy.metrics[3][1]}</p>
                  <p className="mt-1 text-xl font-bold text-[#c7f464]">{summary.topLanguage}</p>
                </div>
                <div className="grid gap-3 sm:grid-cols-2">
                  <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                    <p className="text-xs text-white/60">{copy.progress}</p>
                    <p className="mt-1 text-xl font-bold text-[#4cc9f0]">
                      {languages.length ? `${Math.round(languages[0].translated_percent)}%` : '0%'}
                    </p>
                  </div>
                  <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                    <p className="text-xs text-white/60">{copy.official}</p>
                    <p className="mt-1 text-xl font-bold text-[#ffb86b]">
                      {languages.length ? `${Math.round(languages[0].official_percent)}%` : '0%'}
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </Card>

        <Card className="p-5 md:p-6">
          <div className="grid gap-4 lg:grid-cols-[1.2fr_.8fr_.8fr]">
            <label className="block">
              <span className="pixel-label text-[10px] text-[#566172]">{copy.search}</span>
              <input
                value={search}
                onChange={(event) => setSearch(event.target.value)}
                placeholder={copy.searchPlaceholder}
                className="mt-2 h-12 w-full rounded-2xl border-2 border-[#101114] bg-white px-4 text-sm text-[#101114] outline-none transition placeholder:text-[#8a94a6] focus:border-[#5652ff]"
              />
            </label>

            <div>
              <span className="pixel-label text-[10px] text-[#566172]">{copy.sort}</span>
              <div className="mt-2 grid grid-cols-2 gap-2">
                {([
                  ['progress', copy.progress],
                  ['collaborators', copy.collaborators],
                  ['official', copy.official],
                  ['name', 'A-Z']
                ] as const).map(([value, label]) => (
                  <button
                    key={value}
                    type="button"
                    onClick={() => setSortBy(value)}
                    className={classNames(
                      'rounded-xl border-2 px-3 py-3 text-sm font-bold transition',
                      sortBy === value
                        ? 'border-[#101114] bg-[#c7f464] text-[#101114] shadow-[4px_4px_0_#101114]'
                        : 'border-[#dfe3ea] bg-white text-[#566172] hover:border-[#101114]'
                    )}
                  >
                    {label}
                  </button>
                ))}
              </div>
            </div>

            <div>
              <span className="pixel-label text-[10px] text-[#566172]">{copy.filters}</span>
              <div className="mt-2 grid grid-cols-3 gap-2">
                {([
                  ['all', copy.all],
                  ['ltr', copy.ltr],
                  ['rtl', copy.rtl]
                ] as const).map(([value, label]) => (
                  <button
                    key={value}
                    type="button"
                    onClick={() => setDirection(value)}
                    className={classNames(
                      'rounded-xl border-2 px-3 py-3 text-sm font-bold transition',
                      direction === value
                        ? 'border-[#101114] bg-[#101114] text-white shadow-[4px_4px_0_#c7f464]'
                        : 'border-[#dfe3ea] bg-white text-[#566172] hover:border-[#101114]'
                    )}
                  >
                    {label}
                  </button>
                ))}
              </div>
            </div>
          </div>
        </Card>

        <div className="grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
          {copy.metrics.map(([label, hint], index) => (
            <MetricCard
              key={label}
              label={label}
              value={
                index === 0
                  ? String(summary.totalLanguages)
                  : index === 1
                    ? String(summary.totalCollaborators)
                    : index === 2
                      ? `${summary.averageCoverage}%`
                      : summary.topLanguage
              }
              hint={hint}
            />
          ))}
        </div>

        <div className="grid gap-5 md:grid-cols-2 xl:grid-cols-3">
          {filteredLanguages.length > 0 ? (
            filteredLanguages.map((language) => (
              <LanguageCard key={language.language_id} language={language} locale={locale} />
            ))
          ) : (
            <Card className="p-8 text-center md:col-span-2 xl:col-span-3">
              <p className="minecraft-title text-2xl text-[#101114]">{copy.empty}</p>
              <p className="mt-3 text-sm leading-7 text-[#566172]">
                {locale === 'pt-BR'
                  ? 'Tente mudar a busca ou trocar o filtro de direcao.'
                  : locale === 'es'
                    ? 'Prueba otra busqueda o cambia el filtro de direccion.'
                    : 'Try changing the search or direction filter.'}
              </p>
            </Card>
          )}
        </div>
      </div>
    </PageShell>
  );
}
