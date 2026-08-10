import { useEffect, useMemo, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import { Badge } from '@/components/ui/Badge';
import { Card } from '@/components/ui/Card';
import { MetricCard } from '@/components/ui/MetricCard';
import { ProgressBar } from '@/components/ui/ProgressBar';
import { RouteLoadingScreen } from '@/components/layout/RouteLoadingScreen';
import { PageShell } from '@/components/page/PageShell';
import { useLocale } from '@/hooks/useLocale';
import { paths } from '@/navigation/paths';
import { buildPublicProfileHandle } from '@/utils/profilePaths';
import {
  fetchPublicLanguagePage,
  type PublicLanguageCategory,
  type PublicLanguageMember,
  type PublicLanguagePage as PublicLanguageData
} from '@/services/publicLanguages';

type DetailCopy = {
  eyebrow: string;
  back: string;
  publicOnly: string;
  team: string;
  lead: string;
  reviewers: string;
  contributors: string;
  categories: string;
  overview: string;
  summary: string;
  progress: string;
  translators: string;
  collaborators: string;
  officialLabel: string;
  noLead: string;
  noReviewers: string;
  noContributors: string;
  noTeam: string;
  noCategories: string;
  error: string;
};

const copyByLocale: Record<'pt-BR' | 'en' | 'es', DetailCopy> = {
  'pt-BR': {
    eyebrow: 'Idioma',
    back: 'Voltar para idiomas',
    publicOnly: 'Somente dados publicos',
    team: 'Equipe',
    lead: 'Language Lead',
    reviewers: 'Reviewers',
    contributors: 'Principais contribuidores',
    categories: 'Categorias',
    overview: 'Visao geral',
    summary: 'Resumo publico',
    progress: 'Progresso',
    translators: 'Tradutores',
    collaborators: 'Colaboradores',
    officialLabel: 'Oficial',
    noLead: 'Ainda nao ha um lead publico para este idioma.',
    noReviewers: 'Nenhum revisor publico encontrado.',
    noContributors: 'Nenhum contribuidor publico encontrado.',
    noTeam: 'Nenhuma equipe publica encontrada.',
    noCategories: 'Nenhuma categoria disponivel.',
    error: 'Nao foi possivel carregar este idioma.'
  },
  en: {
    eyebrow: 'Language',
    back: 'Back to languages',
    publicOnly: 'Public data only',
    team: 'Team',
    lead: 'Language Lead',
    reviewers: 'Reviewers',
    contributors: 'Top contributors',
    categories: 'Categories',
    overview: 'Overview',
    summary: 'Public summary',
    progress: 'Progress',
    translators: 'Translators',
    collaborators: 'Collaborators',
    officialLabel: 'Official',
    noLead: 'No public lead has been set for this language yet.',
    noReviewers: 'No public reviewers were found.',
    noContributors: 'No public contributors were found.',
    noTeam: 'No public team members were found.',
    noCategories: 'No categories available.',
    error: 'Unable to load this language.'
  },
  es: {
    eyebrow: 'Idioma',
    back: 'Volver a idiomas',
    publicOnly: 'Solo datos publicos',
    team: 'Equipo',
    lead: 'Language Lead',
    reviewers: 'Reviewers',
    contributors: 'Principales contribuidores',
    categories: 'Categorias',
    overview: 'Resumen',
    summary: 'Resumen publico',
    progress: 'Progreso',
    translators: 'Traductores',
    collaborators: 'Colaboradores',
    officialLabel: 'Oficial',
    noLead: 'Todavia no hay un lead publico para este idioma.',
    noReviewers: 'No se encontraron reviewers publicos.',
    noContributors: 'No se encontraron contribuidores publicos.',
    noTeam: 'No se encontraron miembros publicos del equipo.',
    noCategories: 'No hay categorias disponibles.',
    error: 'No se pudo cargar este idioma.'
  }
};

function getLocaleTag(locale: 'pt-BR' | 'en' | 'es') {
  return locale === 'pt-BR' ? 'pt-BR' : locale === 'es' ? 'es-ES' : 'en-US';
}

function memberName(member: PublicLanguageMember) {
  return member.display_name ?? member.username ?? 'Unnamed member';
}

function memberHandle(member: PublicLanguageMember) {
  return buildPublicProfileHandle(member.username, member.display_name, member.user_id);
}

function MemberCard({
  member,
  tone,
  locale,
  compact = false
}: {
  member: PublicLanguageMember;
  tone: 'accent' | 'success' | 'warning' | 'neutral';
  locale: 'pt-BR' | 'en' | 'es';
  compact?: boolean;
}) {
  const profilePath = paths.publicProfile.replace(':handle', encodeURIComponent(memberHandle(member)));
  const formatter = new Intl.NumberFormat(getLocaleTag(locale));

  return (
    <Link
      to={profilePath}
      className="group block rounded-2xl border border-[#dfe3ea] bg-white p-4 transition hover:-translate-y-1 hover:border-[#101114] hover:shadow-[6px_6px_0_#101114]"
    >
      <div className="flex items-start gap-4">
        <div className="flex h-12 w-12 shrink-0 items-center justify-center overflow-hidden rounded-xl border-2 border-[#101114] bg-[#101114] text-sm font-bold text-white">
          {member.avatar_url ? (
            <img src={member.avatar_url} alt={memberName(member)} className="h-full w-full object-cover" />
          ) : (
            <span>{memberName(member).slice(0, 1).toUpperCase()}</span>
          )}
        </div>

        <div className="min-w-0 flex-1">
          <div className="flex flex-wrap items-center gap-2">
            <h3 className="truncate font-[var(--font-display)] text-base font-bold text-[#101114]">
              {memberName(member)}
            </h3>
            <Badge tone={tone}>{member.role}</Badge>
          </div>
          <p className="mt-1 text-sm text-[#566172]">@{memberHandle(member)}</p>
          <div className="mt-3 flex flex-wrap gap-2 text-xs text-[#566172]">
            <span className="rounded-full border border-[#dfe3ea] bg-[#f7f8fb] px-2 py-1">
              {formatter.format(member.contribution_score)} CP
            </span>
            <span className="rounded-full border border-[#dfe3ea] bg-[#f7f8fb] px-2 py-1">
              {member.proficiency}
            </span>
            {member.is_primary ? <span className="rounded-full border border-[#dfe3ea] bg-[#f7f8fb] px-2 py-1">Primary</span> : null}
            {member.is_native ? <span className="rounded-full border border-[#dfe3ea] bg-[#f7f8fb] px-2 py-1">Native</span> : null}
          </div>
          {compact ? null : member.bio ? <p className="mt-3 text-sm leading-6 text-[#566172]">{member.bio}</p> : null}
        </div>
      </div>
    </Link>
  );
}

function CategoryCard({ category }: { category: PublicLanguageCategory }) {
  return (
    <div className="rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-5">
      <p className="pixel-label text-[10px] text-[#566172]">{category.label}</p>
      <p className="mt-2 text-3xl font-extrabold text-[#101114]">{category.value}</p>
      <p className="mt-2 text-sm leading-6 text-[#566172]">{category.hint}</p>
    </div>
  );
}

export function LanguageDetailPage() {
  const { locale } = useLocale();
  const copy = copyByLocale[locale];
  const params = useParams<{ code: string }>();
  const code = params.code ?? '';
  const [language, setLanguage] = useState<PublicLanguageData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let active = true;

    async function load() {
      if (!code) {
        setLoading(false);
        return;
      }

      try {
        setLoading(true);
        setError(null);
        const result = await fetchPublicLanguagePage(code);

        if (active) {
          setLanguage(result);
        }
      } catch (loadError) {
        if (active) {
          setError(loadError instanceof Error ? loadError.message : copy.error);
        }
      } finally {
        if (active) {
          setLoading(false);
        }
      }
    }

    void load();

    return () => {
      active = false;
    };
  }, [code, copy.error]);

  const formatter = new Intl.NumberFormat(getLocaleTag(locale));

  const summaryRows = useMemo(() => {
    if (!language) {
      return [];
    }

    return [
      { label: 'Translated', value: language.translated_percent, color: '#c7f464' },
      { label: 'Reviewed', value: language.reviewed_percent, color: '#4cc9f0' },
      { label: 'Official', value: language.official_percent, color: '#ffb86b' }
    ];
  }, [language]);

  if (loading) {
    return <RouteLoadingScreen />;
  }

  if (error || !language) {
    return (
      <PageShell eyebrow={copy.eyebrow} title={code || 'Language'} description={copy.error}>
        <Card className="p-8 text-center">
          <h1 className="minecraft-title text-3xl text-[#101114]">
            {locale === 'pt-BR' ? 'Idioma nao encontrado' : locale === 'es' ? 'Idioma no encontrado' : 'Language not found'}
          </h1>
          <p className="mt-4 text-sm leading-7 text-[#566172]">{error ?? copy.error}</p>
          <Link to={paths.languages} className="block-button mt-6 inline-flex px-5 py-3 text-sm">
            {copy.back}
          </Link>
        </Card>
      </PageShell>
    );
  }

  return (
    <PageShell eyebrow={copy.eyebrow} title={language.name} description={language.native_name}>
      <div className="space-y-6">
        <Card className="overflow-hidden bg-[#101114] p-0 text-white">
          <div className="relative overflow-hidden px-6 py-7 md:px-8 md:py-8">
            <div className="absolute inset-0 bg-[radial-gradient(circle_at_10%_15%,rgba(199,244,100,.18),transparent_30%),radial-gradient(circle_at_88%_20%,rgba(76,201,240,.18),transparent_28%),radial-gradient(circle_at_70%_80%,rgba(255,184,107,.12),transparent_30%)]" />
            <div className="relative flex flex-col gap-6 lg:flex-row lg:items-center lg:justify-between">
              <div className="flex items-center gap-4">
                <div className="flex h-20 w-20 items-center justify-center rounded-3xl border-2 border-[#c7f464] bg-[#15181f] text-4xl shadow-[6px_6px_0_#c7f464]">
                  {language.emoji ?? 'GL'}
                </div>
                <div>
                  <p className="pixel-label text-[10px] text-[#c7f464]">{language.code}</p>
                  <h1 className="minecraft-title mt-3 text-4xl leading-none md:text-6xl">{language.name}</h1>
                  <p className="mt-2 text-base text-white/72">{language.native_name}</p>
                  <div className="mt-4 flex flex-wrap gap-2">
                    <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">
                      {language.direction.toUpperCase()}
                    </Badge>
                    <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">
                      {copy.publicOnly}
                    </Badge>
                  </div>
                </div>
              </div>

              <div className="grid gap-3 sm:grid-cols-3 lg:min-w-[360px] lg:grid-cols-1">
                {summaryRows.map((item) => (
                  <div key={item.label} className="rounded-2xl border border-white/10 bg-white/[.06] p-4">
                    <p className="text-xs text-white/60">{item.label}</p>
                    <p className="mt-1 text-3xl font-extrabold" style={{ color: item.color }}>
                      {formatter.format(Math.round(item.value))}%
                    </p>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </Card>

        <div className="grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
          <MetricCard label={copy.summary} value={formatter.format(language.collaborators_count)} hint={copy.collaborators} />
          <MetricCard label={copy.progress} value={`${formatter.format(Math.round(language.translated_percent))}%`} hint={copy.translators} />
          <MetricCard label={copy.reviewers} value={`${formatter.format(Math.round(language.reviewed_percent))}%`} hint={copy.reviewers} />
          <MetricCard label={copy.officialLabel} value={`${formatter.format(Math.round(language.official_percent))}%`} hint={copy.officialLabel} />
        </div>

        <Card className="p-5 md:p-6">
          <p className="pixel-label text-[10px] text-[#566172]">{copy.overview}</p>
          <div className="mt-4 grid gap-4 lg:grid-cols-3">
            <div className="rounded-2xl border-2 border-[#101114] bg-white p-5">
              <p className="text-sm font-bold text-[#101114]">{copy.publicOnly}</p>
              <p className="mt-2 text-sm leading-7 text-[#566172]">
                {locale === 'pt-BR'
                  ? 'Esta pagina mostra progresso agregado, equipe e rankings internos do idioma, sem nenhum texto de string.'
                  : locale === 'es'
                    ? 'Esta pagina muestra progreso agregado, equipo y rankings internos del idioma, sin texto de strings.'
                    : 'This page shows aggregate progress, team, and internal rankings for the language, without any string text.'}
              </p>
            </div>
            <div className="rounded-2xl border-2 border-[#101114] bg-white p-5">
              <p className="text-sm font-bold text-[#101114]">{copy.progress}</p>
              <div className="mt-4 space-y-4">
                <ProgressBar label="Translated" value={Math.round(language.translated_percent)} tone="accent" />
                <ProgressBar label="Reviewed" value={Math.round(language.reviewed_percent)} tone="success" />
                <ProgressBar label="Official" value={Math.round(language.official_percent)} tone="warning" />
              </div>
            </div>
            <div className="rounded-2xl border-2 border-[#101114] bg-white p-5">
              <p className="text-sm font-bold text-[#101114]">{copy.categories}</p>
              <div className="mt-4 grid gap-3">
                {language.categories.length > 0 ? (
                  language.categories.map((category) => <CategoryCard key={category.slug} category={category} />)
                ) : (
                  <p className="text-sm text-[#566172]">{copy.noCategories}</p>
                )}
              </div>
            </div>
          </div>
        </Card>

        <div className="grid gap-6 xl:grid-cols-[1.08fr_.92fr]">
          <Card className="p-5 md:p-6">
            <div className="flex items-center justify-between gap-4">
              <div>
                <p className="pixel-label text-[10px] text-[#566172]">{copy.team}</p>
                <h2 className="mt-2 text-2xl font-bold text-[#101114]">{copy.lead}</h2>
              </div>
              <Link to={paths.languages} className="font-[var(--font-display)] text-sm font-bold text-[#5652ff]">
                {copy.back}
              </Link>
            </div>

            <div className="mt-5 grid gap-4">
              {language.lead_member ? (
                <MemberCard member={language.lead_member} tone="accent" locale={locale} />
              ) : (
                <div className="rounded-2xl border border-dashed border-[#dfe3ea] bg-[#f7f8fb] p-5 text-sm text-[#566172]">
                  {copy.noLead}
                </div>
              )}
            </div>

            <div className="mt-6 grid gap-4">
              <p className="pixel-label text-[10px] text-[#566172]">{copy.reviewers}</p>
              {language.reviewers.length > 0 ? (
                language.reviewers.map((member) => (
                  <MemberCard key={member.user_id} member={member} tone="success" locale={locale} compact />
                ))
              ) : (
                <div className="rounded-2xl border border-dashed border-[#dfe3ea] bg-[#f7f8fb] p-5 text-sm text-[#566172]">
                  {copy.noReviewers}
                </div>
              )}
            </div>
          </Card>

          <Card className="p-5 md:p-6">
            <p className="pixel-label text-[10px] text-[#566172]">{copy.contributors}</p>
            <div className="mt-4 grid gap-4">
              {language.top_contributors.length > 0 ? (
                language.top_contributors.map((member, index) => (
                  <MemberCard
                    key={member.user_id}
                    member={member}
                    tone={index === 0 ? 'accent' : index === 1 ? 'success' : index === 2 ? 'warning' : 'neutral'}
                    locale={locale}
                    compact
                  />
                ))
              ) : (
                <div className="rounded-2xl border border-dashed border-[#dfe3ea] bg-[#f7f8fb] p-5 text-sm text-[#566172]">
                  {copy.noContributors}
                </div>
              )}
            </div>

            <div className="mt-8 rounded-2xl border-2 border-[#101114] bg-[#101114] p-5 text-white">
              <p className="pixel-label text-[10px] text-[#c7f464]">{copy.summary}</p>
              <div className="mt-4 grid grid-cols-2 gap-3">
                <div className="rounded-xl border border-white/10 bg-white/5 p-3.5">
                  <p className="text-[10px] uppercase tracking-[0.3em] text-white/50">{copy.translators}</p>
                  <p className="mt-2 text-2xl font-bold">{formatter.format(language.active_translators)}</p>
                </div>
                <div className="rounded-xl border border-white/10 bg-white/5 p-3.5">
                  <p className="text-[10px] uppercase tracking-[0.3em] text-white/50">{copy.reviewers}</p>
                  <p className="mt-2 text-2xl font-bold">{formatter.format(language.active_reviewers)}</p>
                </div>
                <div className="rounded-xl border border-white/10 bg-white/5 p-3.5">
                  <p className="text-[10px] uppercase tracking-[0.3em] text-white/50">{copy.collaborators}</p>
                  <p className="mt-2 text-2xl font-bold">{formatter.format(language.collaborators_count)}</p>
                </div>
                <div className="rounded-xl border border-white/10 bg-white/5 p-3.5">
                  <p className="text-[10px] uppercase tracking-[0.3em] text-white/50">{copy.officialLabel}</p>
                  <p className="mt-2 text-2xl font-bold">{formatter.format(Math.round(language.official_percent))}%</p>
                </div>
              </div>
            </div>
          </Card>
        </div>

        <Card className="p-5 md:p-6">
          <p className="pixel-label text-[10px] text-[#566172]">{copy.team}</p>
          <div className="mt-4 grid gap-4 md:grid-cols-2 xl:grid-cols-3">
            {language.team_members.length > 0 ? (
              language.team_members.map((member) => (
                <MemberCard key={member.user_id} member={member} tone="neutral" locale={locale} compact />
              ))
            ) : (
              <div className="rounded-2xl border border-dashed border-[#dfe3ea] bg-[#f7f8fb] p-5 text-sm text-[#566172]">
                {copy.noTeam}
              </div>
            )}
          </div>
        </Card>
      </div>
    </PageShell>
  );
}
