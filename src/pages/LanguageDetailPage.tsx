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
  type PublicLanguageCategoryProgress,
  type PublicLanguageMember,
  type PublicLanguagePage as PublicLanguageData,
  type PublicLanguageTeamSection
} from '@/services/publicLanguages';

type RoleKey = 'translator' | 'trusted_translator' | 'reviewer' | 'language_moderator';
type CategoryKey = 'general' | 'minecraft' | 'pvp' | 'mmorpg' | 'economy' | 'trading' | 'commands' | 'system_messages' | 'mods' | 'other';

type DetailCopy = {
  eyebrow: string;
  back: string;
  publicOnly: string;
  team: string;
  lead: string;
  roster: string;
  reviewers: string;
  contributors: string;
  categories: string;
  categoryProgress: string;
  categoryProgressHint: string;
  overview: string;
  summary: string;
  progress: string;
  translatedLabel: string;
  reviewedLabel: string;
  translators: string;
  collaborators: string;
  officialLabel: string;
  startSession: string;
  resumeSession: string;
  fullyCovered: string;
  noLead: string;
  noReviewers: string;
  noContributors: string;
  noTeam: string;
  noCategories: string;
  noSections: string;
  noCategoryWork: string;
  teamHint: string;
  publicTeamHint: string;
  publicSummary: string;
  roleLabels: Record<RoleKey, string>;
  roleDescriptions: Record<RoleKey, string>;
  error: string;
};

const roleOrder: RoleKey[] = ['translator', 'trusted_translator', 'reviewer', 'language_moderator'];

const roleToneMap: Record<RoleKey, 'accent' | 'success' | 'warning' | 'danger'> = {
  translator: 'accent',
  trusted_translator: 'success',
  reviewer: 'warning',
  language_moderator: 'danger'
};

const categoryOrder: CategoryKey[] = ['general', 'minecraft', 'pvp', 'mmorpg', 'economy', 'trading', 'commands', 'system_messages', 'mods', 'other'];

const categoryToneMap: Record<CategoryKey, 'accent' | 'success' | 'warning' | 'danger' | 'neutral'> = {
  general: 'neutral',
  minecraft: 'accent',
  pvp: 'warning',
  mmorpg: 'success',
  economy: 'accent',
  trading: 'success',
  commands: 'warning',
  system_messages: 'neutral',
  mods: 'danger',
  other: 'neutral'
};

const copyByLocale: Record<'pt-BR' | 'en' | 'es', DetailCopy> = {
  'pt-BR': {
    eyebrow: 'Idioma',
    back: 'Voltar para idiomas',
    publicOnly: 'Somente dados publicos',
    team: 'Equipe publica',
    lead: 'Language Lead',
    roster: 'Lista publica',
    reviewers: 'Reviewers',
    contributors: 'Principais contribuidores',
    categories: 'Categorias',
    categoryProgress: 'Progresso por categoria',
    categoryProgressHint: 'Acompanhe o que ja foi traduzido, revisado e aprovado em cada area do idioma.',
    overview: 'Visao geral',
    summary: 'Resumo publico',
    progress: 'Progresso',
    translatedLabel: 'Traduzido',
    reviewedLabel: 'Revisado',
    translators: 'Tradutores',
    collaborators: 'Colaboradores',
    officialLabel: 'Oficial',
    startSession: 'Iniciar sessao',
    resumeSession: 'Continuar traduzindo',
    fullyCovered: 'Categoria concluida',
    noLead: 'Ainda nao ha um lead publico para este idioma.',
    noReviewers: 'Nenhum reviewer publico encontrado.',
    noContributors: 'Nenhum contribuidor publico encontrado.',
    noTeam: 'Nenhuma equipe publica encontrada.',
    noCategories: 'Nenhuma categoria disponivel.',
    noSections: 'Nenhum bloco de equipe disponivel.',
    noCategoryWork: 'Nenhuma categoria com trabalho pendente foi encontrada.',
    teamHint: 'Papeis publicos do idioma, organizados por funcao e visiveis para a comunidade.',
    publicTeamHint: 'Acoes administrativas continuam protegidas; aqui aparecem apenas membros e funcoes publicas.',
    publicSummary: 'Esta pagina mostra progresso agregado, equipe publica e contribuicoes por funcao sem expor strings.',
    roleLabels: {
      translator: 'Tradutores',
      trusted_translator: 'Tradutores confiaveis',
      reviewer: 'Reviewers',
      language_moderator: 'Moderadores do idioma'
    },
    roleDescriptions: {
      translator: 'Membros focados em enviar novas sugestoes e manter a base de traducao ativa.',
      trusted_translator: 'Colaboradores com confianca maior para entregar sugestoes mais maduras.',
      reviewer: 'Membros responsaveis por revisar qualidade, contexto e consistencia.',
      language_moderator: 'Equipe que organiza o idioma e protege o padrao publico da comunidade.'
    },
    error: 'Nao foi possivel carregar este idioma.'
  },
  en: {
    eyebrow: 'Language',
    back: 'Back to languages',
    publicOnly: 'Public data only',
    team: 'Public team',
    lead: 'Language Lead',
    roster: 'Public roster',
    reviewers: 'Reviewers',
    contributors: 'Top contributors',
    categories: 'Categories',
    categoryProgress: 'Progress by category',
    categoryProgressHint: 'Track what has already been translated, reviewed, and approved in each area of the language.',
    overview: 'Overview',
    summary: 'Public summary',
    progress: 'Progress',
    translatedLabel: 'Translated',
    reviewedLabel: 'Reviewed',
    translators: 'Translators',
    collaborators: 'Collaborators',
    officialLabel: 'Official',
    startSession: 'Start session',
    resumeSession: 'Continue translating',
    fullyCovered: 'Category complete',
    noLead: 'No public lead has been set for this language yet.',
    noReviewers: 'No public reviewers were found.',
    noContributors: 'No public contributors were found.',
    noTeam: 'No public team members were found.',
    noCategories: 'No categories available.',
    noSections: 'No team sections available.',
    noCategoryWork: 'No category with pending work was found.',
    teamHint: 'Public language roles, organized by function and visible to the community.',
    publicTeamHint: 'Administrative actions stay protected; only public members and roles are shown here.',
    publicSummary: 'This page shows aggregate progress, the public team, and role-based contributions without exposing strings.',
    roleLabels: {
      translator: 'Translators',
      trusted_translator: 'Trusted translators',
      reviewer: 'Reviewers',
      language_moderator: 'Language moderators'
    },
    roleDescriptions: {
      translator: 'Members focused on sending fresh suggestions and keeping translation work moving.',
      trusted_translator: 'People with higher trust to submit more mature translation work.',
      reviewer: 'Members responsible for checking quality, context, and consistency.',
      language_moderator: 'The group that organizes the language and protects the public standard.'
    },
    error: 'Unable to load this language.'
  },
  es: {
    eyebrow: 'Idioma',
    back: 'Volver a idiomas',
    publicOnly: 'Solo datos publicos',
    team: 'Equipo publico',
    lead: 'Language Lead',
    roster: 'Lista publica',
    reviewers: 'Reviewers',
    contributors: 'Principales contribuidores',
    categories: 'Categorias',
    categoryProgress: 'Progreso por categoria',
    categoryProgressHint: 'Sigue lo que ya fue traducido, revisado y aprobado en cada area del idioma.',
    overview: 'Resumen',
    summary: 'Resumen publico',
    progress: 'Progreso',
    translatedLabel: 'Traducido',
    reviewedLabel: 'Revisado',
    translators: 'Traductores',
    collaborators: 'Colaboradores',
    officialLabel: 'Oficial',
    startSession: 'Iniciar sesion',
    resumeSession: 'Seguir traduciendo',
    fullyCovered: 'Categoria completa',
    noLead: 'Todavia no hay un lead publico para este idioma.',
    noReviewers: 'No se encontraron reviewers publicos.',
    noContributors: 'No se encontraron contribuidores publicos.',
    noTeam: 'No se encontraron miembros publicos del equipo.',
    noCategories: 'No hay categorias disponibles.',
    noSections: 'No hay bloques de equipo disponibles.',
    noCategoryWork: 'No se encontro ninguna categoria con trabajo pendiente.',
    teamHint: 'Roles publicos del idioma, organizados por funcion y visibles para la comunidad.',
    publicTeamHint: 'Las acciones administrativas siguen protegidas; aqui solo aparecen miembros y roles publicos.',
    publicSummary: 'Esta pagina muestra progreso agregado, equipo publico y contribuciones por rol sin exponer strings.',
    roleLabels: {
      translator: 'Traductores',
      trusted_translator: 'Traductores confiables',
      reviewer: 'Reviewers',
      language_moderator: 'Moderadores del idioma'
    },
    roleDescriptions: {
      translator: 'Miembros enfocados en enviar nuevas sugerencias y mantener el flujo de traduccion activo.',
      trusted_translator: 'Colaboradores con mas confianza para enviar traducciones mas maduras.',
      reviewer: 'Miembros responsables de revisar calidad, contexto y consistencia.',
      language_moderator: 'Equipo que organiza el idioma y protege el estandar publico.'
    },
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

function roleKey(role: string): RoleKey {
  if (role === 'translator' || role === 'trusted_translator' || role === 'reviewer' || role === 'language_moderator') {
    return role;
  }

  return 'translator';
}

function roleTone(role: string): 'accent' | 'success' | 'warning' | 'danger' {
  return roleToneMap[roleKey(role)];
}

function categoryKeyFromSlug(slug: string): CategoryKey {
  if (
    slug === 'general' ||
    slug === 'minecraft' ||
    slug === 'pvp' ||
    slug === 'mmorpg' ||
    slug === 'economy' ||
    slug === 'trading' ||
    slug === 'commands' ||
    slug === 'system_messages' ||
    slug === 'mods'
  ) {
    return slug;
  }

  return 'other';
}

function buildTranslationSessionPath(languageCode: string, categorySlug: string) {
  const params = new URLSearchParams({
    language: languageCode,
    category: categorySlug
  });

  return `${paths.translate}?${params.toString()}`;
}

function TeamMemberCard({
  member,
  tone,
  locale,
  roleLabel,
  compact = false
}: {
  member: PublicLanguageMember;
  tone: 'accent' | 'success' | 'warning' | 'danger' | 'neutral';
  locale: 'pt-BR' | 'en' | 'es';
  roleLabel: string;
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
            <h3 className="truncate font-[var(--font-display)] text-base font-bold text-[#101114]">{memberName(member)}</h3>
            <Badge tone={tone}>{roleLabel}</Badge>
          </div>
          <p className="mt-1 text-sm text-[#566172]">@{memberHandle(member)}</p>
          <div className="mt-3 flex flex-wrap gap-2 text-xs text-[#566172]">
            <span className="rounded-full border border-[#dfe3ea] bg-[#f7f8fb] px-2 py-1">{formatter.format(member.contribution_score)} CP</span>
            <span className="rounded-full border border-[#dfe3ea] bg-[#f7f8fb] px-2 py-1">{member.proficiency}</span>
            {member.is_primary ? <span className="rounded-full border border-[#dfe3ea] bg-[#f7f8fb] px-2 py-1">Primary</span> : null}
            {member.is_native ? <span className="rounded-full border border-[#dfe3ea] bg-[#f7f8fb] px-2 py-1">Native</span> : null}
          </div>
          {compact ? null : member.bio ? <p className="mt-3 text-sm leading-6 text-[#566172]">{member.bio}</p> : null}
        </div>
      </div>
    </Link>
  );
}

function CategoryProgressCard({
  item,
  locale,
  languageCode,
  copy
}: {
  item: PublicLanguageCategoryProgress;
  locale: 'pt-BR' | 'en' | 'es';
  languageCode: string;
  copy: DetailCopy;
}) {
  const tone = categoryToneMap[categoryKeyFromSlug(item.slug)];
  const formatter = new Intl.NumberFormat(getLocaleTag(locale));
  const isComplete = !item.has_open_work;
  const sessionPath = buildTranslationSessionPath(languageCode, item.slug);

  return (
    <Card className="p-5 transition duration-200 hover:-translate-y-1 hover:shadow-[8px_8px_0_#101114]">
      <div className="flex flex-wrap items-start justify-between gap-3">
        <div>
          <p className="pixel-label text-[10px] text-[#566172]">{item.label}</p>
          <h3 className="mt-2 text-2xl font-bold text-[#101114]">{item.label}</h3>
          <p className="mt-2 text-sm leading-7 text-[#566172]">
            {locale === 'pt-BR'
              ? 'Acompanhe o progresso da categoria por traducao, revisao e aprovacao.'
              : locale === 'es'
                ? 'Sigue el progreso de la categoria por traduccion, revision y aprobacion.'
                : 'Track the category progress through translation, review, and approval.'}
          </p>
        </div>
        <Badge tone={tone}>{formatter.format(Math.round(item.official_percent))}%</Badge>
      </div>

      <div className="mt-5 space-y-4">
        <ProgressBar label="Translated" value={Math.round(item.translated_percent)} tone="accent" />
        <ProgressBar label="Reviewed" value={Math.round(item.reviewed_percent)} tone="success" />
        <ProgressBar label="Official" value={Math.round(item.official_percent)} tone="warning" />
      </div>

      <div className="mt-5 grid gap-3 sm:grid-cols-3">
        <div className="rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-4">
          <p className="pixel-label text-[10px] text-[#566172]">{copy.translatedLabel}</p>
          <p className="mt-2 text-2xl font-extrabold text-[#101114]">{formatter.format(Math.round(item.translated_percent))}%</p>
        </div>
        <div className="rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-4">
          <p className="pixel-label text-[10px] text-[#566172]">{copy.reviewedLabel}</p>
          <p className="mt-2 text-2xl font-extrabold text-[#101114]">{formatter.format(Math.round(item.reviewed_percent))}%</p>
        </div>
        <div className="rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-4">
          <p className="pixel-label text-[10px] text-[#566172]">{copy.officialLabel}</p>
          <p className="mt-2 text-2xl font-extrabold text-[#101114]">{formatter.format(Math.round(item.official_percent))}%</p>
        </div>
      </div>

      <div className="mt-5 flex flex-wrap items-center justify-between gap-3 border-t border-[#dfe3ea] pt-4">
        <p className="text-sm text-[#566172]">
          {formatter.format(item.total_strings)} {locale === 'pt-BR' ? 'strings' : locale === 'es' ? 'strings' : 'strings'}
        </p>
        {isComplete ? (
          <Badge tone="success">{copy.fullyCovered}</Badge>
        ) : (
          <Link to={sessionPath} className="block-button inline-flex px-4 py-2 text-sm">
            {copy.startSession}
          </Link>
        )}
      </div>
    </Card>
  );
}

function TeamSectionCard({
  section,
  copy,
  locale
}: {
  section: PublicLanguageTeamSection;
  copy: DetailCopy;
  locale: 'pt-BR' | 'en' | 'es';
}) {
  const visibleMembers = section.members.slice(0, 6);
  const remaining = Math.max(0, section.members.length - visibleMembers.length);
  const sectionKey = roleKey(section.role);
  const tone = roleTone(section.role);

  return (
    <Card className="p-5">
      <div className="flex flex-wrap items-start justify-between gap-4">
        <div>
          <p className="pixel-label text-[10px] text-[#566172]">{copy.roleLabels[sectionKey]}</p>
          <h3 className="mt-2 text-2xl font-bold text-[#101114]">{copy.roleLabels[sectionKey]}</h3>
          <p className="mt-2 max-w-2xl text-sm leading-7 text-[#566172]">{copy.roleDescriptions[sectionKey]}</p>
        </div>
        <Badge tone={tone}>{new Intl.NumberFormat(getLocaleTag(locale)).format(section.count)}</Badge>
      </div>

      <div className="mt-5 grid gap-3">
        {visibleMembers.length > 0 ? (
          visibleMembers.map((member) => (
            <TeamMemberCard
              key={member.user_id}
              member={member}
              tone={tone}
              locale={locale}
              roleLabel={copy.roleLabels[roleKey(member.role)]}
              compact
            />
          ))
        ) : (
          <div className="rounded-2xl border border-dashed border-[#dfe3ea] bg-[#f7f8fb] p-5 text-sm text-[#566172]">
            {copy.noTeam}
          </div>
        )}
      </div>

      {remaining > 0 ? (
        <p className="mt-4 text-xs uppercase tracking-[0.24em] text-[#566172]">
          +{remaining} {locale === 'pt-BR' ? 'membros publicos' : locale === 'es' ? 'miembros publicos' : 'public members'}
        </p>
      ) : null}
    </Card>
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

  const orderedCategoryProgress = useMemo(() => {
    if (!language) {
      return [];
    }

    return [...language.category_progress].sort(
      (left, right) => categoryOrder.indexOf(categoryKeyFromSlug(left.slug)) - categoryOrder.indexOf(categoryKeyFromSlug(right.slug))
    );
  }, [language]);

  const incompleteCategories = useMemo(() => orderedCategoryProgress.filter((item) => item.has_open_work), [orderedCategoryProgress]);

  const orderedTeamSections = useMemo(() => {
    if (!language) {
      return [];
    }

    return [...language.team_sections].sort(
      (left, right) => roleOrder.indexOf(roleKey(left.role)) - roleOrder.indexOf(roleKey(right.role))
    );
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
              <p className="mt-2 text-sm leading-7 text-[#566172]">{copy.publicSummary}</p>
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

        <Card className="p-5 md:p-6">
          <div className="flex flex-col gap-3 md:flex-row md:items-end md:justify-between">
            <div>
              <p className="pixel-label text-[10px] text-[#566172]">{copy.team}</p>
              <h2 className="mt-2 text-2xl font-bold text-[#101114]">{copy.teamHint}</h2>
            </div>
            <p className="max-w-2xl text-sm leading-7 text-[#566172]">{copy.publicTeamHint}</p>
          </div>

          <div className="mt-5 grid gap-4 lg:grid-cols-[1.05fr_.95fr]">
            <div className="rounded-3xl border-2 border-[#101114] bg-white p-5 shadow-[6px_6px_0_#c7f464]">
              <div className="flex items-center justify-between gap-3">
                <div>
                  <p className="pixel-label text-[10px] text-[#566172]">{copy.lead}</p>
                  <h3 className="mt-2 text-xl font-bold text-[#101114]">
                    {locale === 'pt-BR' ? 'Lider publico do idioma' : locale === 'es' ? 'Lider publico del idioma' : 'Public language lead'}
                  </h3>
                </div>
                <Badge tone="accent">{formatter.format(language.collaborators_count)}</Badge>
              </div>

              <div className="mt-5">
                {language.lead_member ? (
                  <TeamMemberCard
                    member={language.lead_member}
                    tone={roleTone(language.lead_member.role)}
                    locale={locale}
                    roleLabel={copy.roleLabels[roleKey(language.lead_member.role)]}
                  />
                ) : (
                  <div className="rounded-2xl border border-dashed border-[#dfe3ea] bg-[#f7f8fb] p-5 text-sm text-[#566172]">
                    {copy.noLead}
                  </div>
                )}
              </div>
            </div>

            <div className="rounded-3xl border-2 border-[#101114] bg-[#101114] p-5 text-white">
              <p className="pixel-label text-[10px] text-[#c7f464]">{copy.roster}</p>
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
          </div>
        </Card>

        <Card className="p-5 md:p-6">
          <div className="flex flex-col gap-3 md:flex-row md:items-end md:justify-between">
            <div>
              <p className="pixel-label text-[10px] text-[#566172]">{copy.categoryProgress}</p>
              <h2 className="mt-2 text-2xl font-bold text-[#101114]">{copy.categoryProgressHint}</h2>
            </div>
            {incompleteCategories.length > 0 ? (
              <div className="flex flex-wrap gap-2">
                {incompleteCategories.slice(0, 3).map((item) => (
                  <Link
                    key={item.slug}
                    to={buildTranslationSessionPath(language.code, item.slug)}
                    className="rounded-full border border-[#101114] bg-[#c7f464] px-4 py-2 text-sm font-bold text-[#101114] transition hover:-translate-y-1"
                  >
                    {copy.startSession} {item.label}
                  </Link>
                ))}
              </div>
            ) : (
              <Badge tone="success">{copy.fullyCovered}</Badge>
            )}
          </div>

          <div className="mt-5 grid gap-4 md:grid-cols-2 xl:grid-cols-3">
            {orderedCategoryProgress.length > 0 ? (
              orderedCategoryProgress.map((item) => (
                <CategoryProgressCard key={item.slug} item={item} locale={locale} languageCode={language.code} copy={copy} />
              ))
            ) : (
              <div className="rounded-2xl border border-dashed border-[#dfe3ea] bg-[#f7f8fb] p-5 text-sm text-[#566172]">
                {copy.noCategoryWork}
              </div>
            )}
          </div>
        </Card>

        <div className="grid gap-4">
          <div className="rounded-3xl border-2 border-[#101114] bg-white p-5 md:p-6">
            <div className="flex flex-wrap items-end justify-between gap-3">
              <div>
                <p className="pixel-label text-[10px] text-[#566172]">{copy.team}</p>
                <h2 className="mt-2 text-2xl font-bold text-[#101114]">
                  {locale === 'pt-BR' ? 'Blocos de funcao' : locale === 'es' ? 'Bloques por funcion' : 'Role blocks'}
                </h2>
              </div>
              <Badge tone="neutral">
                {formatter.format(language.team_sections.reduce((sum, section) => sum + section.count, 0))}{' '}
                {locale === 'pt-BR' ? 'membros' : locale === 'es' ? 'miembros' : 'members'}
              </Badge>
            </div>

            <div className="mt-5 grid gap-4 xl:grid-cols-2">
              {orderedTeamSections.length > 0 ? (
                orderedTeamSections.map((section) => (
                  <TeamSectionCard key={section.role} section={section} copy={copy} locale={locale} />
                ))
              ) : (
                <div className="rounded-2xl border border-dashed border-[#dfe3ea] bg-[#f7f8fb] p-5 text-sm text-[#566172]">
                  {copy.noSections}
                </div>
              )}
            </div>
          </div>

          <div className="grid gap-4 xl:grid-cols-[1.08fr_.92fr]">
            <Card className="p-5 md:p-6">
              <p className="pixel-label text-[10px] text-[#566172]">{copy.contributors}</p>
              <div className="mt-4 grid gap-4">
                {language.top_contributors.length > 0 ? (
                  language.top_contributors.map((member, index) => (
                    <TeamMemberCard
                      key={member.user_id}
                      member={member}
                      tone={index === 0 ? 'accent' : index === 1 ? 'success' : index === 2 ? 'warning' : 'neutral'}
                      locale={locale}
                      roleLabel={copy.roleLabels[roleKey(member.role)]}
                      compact
                    />
                  ))
                ) : (
                  <div className="rounded-2xl border border-dashed border-[#dfe3ea] bg-[#f7f8fb] p-5 text-sm text-[#566172]">
                    {copy.noContributors}
                  </div>
                )}
              </div>
            </Card>

            <Card className="p-5 md:p-6">
              <p className="pixel-label text-[10px] text-[#566172]">{copy.roster}</p>
              <div className="mt-4 grid gap-4">
                {language.team_members.length > 0 ? (
                  language.team_members.map((member) => (
                    <TeamMemberCard
                      key={member.user_id}
                      member={member}
                      tone={roleTone(member.role)}
                      locale={locale}
                      roleLabel={copy.roleLabels[roleKey(member.role)]}
                      compact
                    />
                  ))
                ) : (
                  <div className="rounded-2xl border border-dashed border-[#dfe3ea] bg-[#f7f8fb] p-5 text-sm text-[#566172]">
                    {copy.noTeam}
                  </div>
                )}
              </div>
            </Card>
          </div>
        </div>
      </div>
    </PageShell>
  );
}
