import { useEffect, useMemo, useState } from 'react';
import { Link } from 'react-router-dom';
import { Badge } from '@/components/ui/Badge';
import { Card } from '@/components/ui/Card';
import { RouteLoadingScreen } from '@/components/layout/RouteLoadingScreen';
import { PageShell } from '@/components/page/PageShell';
import { classNames } from '@/utils/classNames';
import { paths } from '@/navigation/paths';
import { useLocale } from '@/hooks/useLocale';
import {
  fetchPublicLeaderboards,
  type LeaderboardKind,
  type LeaderboardPeriod,
  type PublicLeaderboardEntry,
  type PublicLeaderboardGroup
} from '@/services/publicLeaderboards';

type LeaderboardCopy = {
  eyebrow: string;
  title: string;
  description: string;
  heroLabel: string;
  heroTitle: string;
  heroLead: string;
  qualityNote: string;
  periodLabel: string;
  periodLead: string;
  scoreLabel: string;
  scoreTitle: string;
  scoreLead: string;
  scoreTags: [string, string, string];
  visibleLabel: string;
  topLabel: string;
  positionLabel: string;
  primaryLanguageLabel: string;
  cpLabel: string;
  repLabel: string;
  qualityLabel: string;
  badgesLabel: string;
  emptyBadges: string;
  empty: string;
  rankingNote: string;
  categories: Record<
    LeaderboardKind,
    {
      title: string;
      description: string;
      scoreLabel: string;
      scoreHint: string;
      accent: string;
      empty: string;
    }
  >;
  periods: Array<{ value: LeaderboardPeriod; label: string; hint: string }>;
};

const copyByLocale: Record<'pt-BR' | 'en' | 'es', LeaderboardCopy> = {
  'pt-BR': {
    eyebrow: 'Ranking publico',
    title: 'Lideres da comunidade',
    description:
      'Filtre por periodo e acompanhe tradutores, revisores e apoiadores com uma ordem pensada para qualidade, reputacao e colaboracao real.',
    heroLabel: 'Dados publicos',
    heroTitle: 'Ranking feito para destacar qualidade.',
    heroLead:
      'A pontuacao prioriza Contribution Points e reputacao, com sinais extras de qualidade para evitar incentivo a spam ou volume vazio.',
    qualityNote: 'Sem strings privadas ou dados internos.',
    periodLabel: 'Periodo',
    periodLead: 'Escolha a janela de tempo que deseja analisar.',
    scoreLabel: 'Pontuacao',
    scoreTitle: 'Como a ordem funciona',
    scoreLead:
      'A ordenacao usa CP como base, soma reputacao e valoriza aprovacoes, badges e consistencia de colaboracao.',
    scoreTags: ['CP em primeiro lugar', 'Reputacao como sinal de qualidade', 'Badges e aprovacoes reforcam o rank'],
    visibleLabel: 'visiveis',
    topLabel: 'Lider atual',
    positionLabel: 'Posicao',
    primaryLanguageLabel: 'Idioma principal',
    cpLabel: 'CP',
    repLabel: 'Rep',
    qualityLabel: 'Qualidade',
    badgesLabel: 'Badges',
    emptyBadges: 'Sem badges publicos ainda',
    empty: 'Nenhum colaborador publico encontrado para este periodo.',
    rankingNote: 'O ranking privilegia valor de comunidade acima de contagem bruta.',
    categories: {
      translators: {
        title: 'Top Translators',
        description: 'Tradutores com melhor combinacao de CP, reputacao e aprovacoes.',
        scoreLabel: 'Score de traducao',
        scoreHint: 'CP + reputacao + aprovacoes',
        accent: 'from-[#c7f464] to-[#87f5d8]',
        empty: 'Nenhum tradutor publico entrou no ranking ainda.'
      },
      reviewers: {
        title: 'Top Reviewers',
        description: 'Revisores com melhor qualidade de decisao e consistencia no periodo.',
        scoreLabel: 'Score de revisao',
        scoreHint: 'CP + reputacao + aprovacoes',
        accent: 'from-[#4cc9f0] to-[#b7a7ff]',
        empty: 'Nenhum revisor publico entrou no ranking ainda.'
      },
      supporters: {
        title: 'Supporters',
        description: 'Apoiadores com badges, reputacao e impacto publico na comunidade.',
        scoreLabel: 'Score de apoio',
        scoreHint: 'CP + reputacao + badges',
        accent: 'from-[#ffb86b] to-[#ffe3a1]',
        empty: 'Nenhum supporter publico entrou no ranking ainda.'
      }
    },
    periods: [
      { value: 'all_time', label: 'All Time', hint: 'Vida inteira' },
      { value: 'year', label: 'Year', hint: 'Ano atual' },
      { value: 'month', label: 'Month', hint: 'Mes atual' },
      { value: 'week', label: 'Week', hint: 'Semana atual' }
    ]
  },
  en: {
    eyebrow: 'Public ranking',
    title: 'Community leaders',
    description:
      'Filter by time window and track translators, reviewers, and supporters with an order designed around quality, reputation, and real collaboration.',
    heroLabel: 'Public data',
    heroTitle: 'A ranking designed to reward quality.',
    heroLead:
      'The score puts Contribution Points first, then reputation, with quality signals that help avoid spam or empty volume gaming.',
    qualityNote: 'No private strings or internal data exposed.',
    periodLabel: 'Time window',
    periodLead: 'Choose the period you want to inspect.',
    scoreLabel: 'Score',
    scoreTitle: 'How the order works',
    scoreLead:
      'The ranking uses CP as the base, adds reputation, and rewards approvals, badges, and consistent helpful activity.',
    scoreTags: ['CP first', 'Reputation as a quality signal', 'Badges and approvals reinforce rank'],
    visibleLabel: 'visible',
    topLabel: 'Current leader',
    positionLabel: 'Position',
    primaryLanguageLabel: 'Primary language',
    cpLabel: 'CP',
    repLabel: 'Rep',
    qualityLabel: 'Quality',
    badgesLabel: 'Badges',
    emptyBadges: 'No public badges yet',
    empty: 'No public collaborators were found for this time window.',
    rankingNote: 'The ranking favors community value over raw quantity.',
    categories: {
      translators: {
        title: 'Top Translators',
        description: 'Translators with the best mix of CP, reputation, and approvals.',
        scoreLabel: 'Translation score',
        scoreHint: 'CP + reputation + approvals',
        accent: 'from-[#c7f464] to-[#87f5d8]',
        empty: 'No public translators have entered the ranking yet.'
      },
      reviewers: {
        title: 'Top Reviewers',
        description: 'Reviewers with strong quality decisions and steady performance.',
        scoreLabel: 'Review score',
        scoreHint: 'CP + reputation + approvals',
        accent: 'from-[#4cc9f0] to-[#b7a7ff]',
        empty: 'No public reviewers have entered the ranking yet.'
      },
      supporters: {
        title: 'Supporters',
        description: 'Supporters with badges, reputation, and visible community impact.',
        scoreLabel: 'Support score',
        scoreHint: 'CP + reputation + badges',
        accent: 'from-[#ffb86b] to-[#ffe3a1]',
        empty: 'No public supporters have entered the ranking yet.'
      }
    },
    periods: [
      { value: 'all_time', label: 'All Time', hint: 'Lifetime' },
      { value: 'year', label: 'Year', hint: 'Current year' },
      { value: 'month', label: 'Month', hint: 'Current month' },
      { value: 'week', label: 'Week', hint: 'Current week' }
    ]
  },
  es: {
    eyebrow: 'Ranking publico',
    title: 'Lideres de la comunidad',
    description:
      'Filtra por periodo y sigue a traductores, revisores y supporters con un orden pensado para calidad, reputacion y colaboracion real.',
    heroLabel: 'Datos publicos',
    heroTitle: 'Un ranking creado para destacar calidad.',
    heroLead:
      'La puntuacion prioriza Contribution Points y reputacion, con senales de calidad para evitar spam o volumen vacio.',
    qualityNote: 'Sin strings privadas ni datos internos expuestos.',
    periodLabel: 'Periodo',
    periodLead: 'Elige la ventana de tiempo que quieres analizar.',
    scoreLabel: 'Puntuacion',
    scoreTitle: 'Como funciona el orden',
    scoreLead:
      'El ranking usa CP como base, suma reputacion y valora aprobaciones, badges y constancia de colaboracion.',
    scoreTags: ['CP primero', 'Reputacion como senal de calidad', 'Badges y aprobaciones refuerzan el puesto'],
    visibleLabel: 'visibles',
    topLabel: 'Lider actual',
    positionLabel: 'Posicion',
    primaryLanguageLabel: 'Idioma principal',
    cpLabel: 'CP',
    repLabel: 'Rep',
    qualityLabel: 'Calidad',
    badgesLabel: 'Badges',
    emptyBadges: 'Aun no hay badges publicos',
    empty: 'No se encontraron colaboradores publicos para este periodo.',
    rankingNote: 'El ranking favorece valor comunitario sobre cantidad bruta.',
    categories: {
      translators: {
        title: 'Top Translators',
        description: 'Traductores con la mejor combinacion de CP, reputacion y aprobaciones.',
        scoreLabel: 'Score de traduccion',
        scoreHint: 'CP + reputacion + aprobaciones',
        accent: 'from-[#c7f464] to-[#87f5d8]',
        empty: 'Aun no hay traductores publicos en el ranking.'
      },
      reviewers: {
        title: 'Top Reviewers',
        description: 'Revisores con mejor calidad de decision y constancia.',
        scoreLabel: 'Score de revision',
        scoreHint: 'CP + reputacion + aprobaciones',
        accent: 'from-[#4cc9f0] to-[#b7a7ff]',
        empty: 'Aun no hay revisores publicos en el ranking.'
      },
      supporters: {
        title: 'Supporters',
        description: 'Apoiadores con badges, reputacion e impacto visible en la comunidad.',
        scoreLabel: 'Score de apoyo',
        scoreHint: 'CP + reputacion + badges',
        accent: 'from-[#ffb86b] to-[#ffe3a1]',
        empty: 'Aun no hay supporters publicos en el ranking.'
      }
    },
    periods: [
      { value: 'all_time', label: 'All Time', hint: 'Vida entera' },
      { value: 'year', label: 'Year', hint: 'Ano atual' },
      { value: 'month', label: 'Month', hint: 'Mes atual' },
      { value: 'week', label: 'Week', hint: 'Semana atual' }
    ]
  }
};

function avatarInitial(name: string | null | undefined) {
  return (name ?? 'C').slice(0, 1).toUpperCase();
}

function formatUsername(entry: PublicLeaderboardEntry) {
  return entry.username ?? entry.display_name ?? 'Unnamed collaborator';
}

function formatLanguage(entry: PublicLeaderboardEntry, fallback: string) {
  const code = entry.primary_language_code ?? fallback;
  const name = entry.primary_language_name ?? entry.primary_language_native_name ?? fallback;
  return `${code} - ${name}`;
}

function getProfilePath(entry: PublicLeaderboardEntry) {
  const handle = entry.username ?? entry.display_name ?? entry.user_id;
  return paths.publicProfile.replace(':handle', encodeURIComponent(handle));
}

function getLocaleTag(locale: 'pt-BR' | 'en' | 'es') {
  return locale === 'pt-BR' ? 'pt-BR' : locale === 'es' ? 'es-ES' : 'en-US';
}

function LeaderboardRowCard({
  entry,
  index,
  scoreLabel,
  qualityLabel,
  cpLabel,
  repLabel,
  badgesLabel,
  emptyBadges,
  primaryLanguageLabel,
  positionLabel,
  locale
}: {
  entry: PublicLeaderboardEntry;
  index: number;
  scoreLabel: string;
  qualityLabel: string;
  cpLabel: string;
  repLabel: string;
  badgesLabel: string;
  emptyBadges: string;
  primaryLanguageLabel: string;
  positionLabel: string;
  locale: 'pt-BR' | 'en' | 'es';
}) {
  const topBadge = index < 3 ? ['#c7f464', '#4cc9f0', '#ffb86b'][index] : '#dfe3ea';
  const formatter = new Intl.NumberFormat(getLocaleTag(locale));

  return (
    <Link
      to={getProfilePath(entry)}
      className="group block rounded-2xl border border-[#dfe3ea] bg-white p-4 transition hover:-translate-y-1 hover:border-[#101114] hover:shadow-[6px_6px_0_#101114]"
    >
      <div className="flex items-start gap-4">
        <div
          className="flex h-12 w-12 shrink-0 items-center justify-center overflow-hidden rounded-xl border-2 border-[#101114] bg-[#101114] text-sm font-bold text-white"
          style={{ boxShadow: `4px 4px 0 ${topBadge}` }}
        >
          {entry.avatar_url ? (
            <img src={entry.avatar_url} alt={formatUsername(entry)} className="h-full w-full object-cover" />
          ) : (
            <span>{avatarInitial(entry.display_name ?? entry.username)}</span>
          )}
        </div>

        <div className="min-w-0 flex-1">
          <div className="flex flex-wrap items-center gap-2">
            <span className="rounded-full border border-[#101114] bg-[#101114] px-2 py-1 text-[10px] font-bold text-white">
              {positionLabel} #{entry.rank}
            </span>
            <h3 className="truncate font-[var(--font-display)] text-base font-bold text-[#101114]">
              {formatUsername(entry)}
            </h3>
            {entry.primary_language_code ? (
              <Badge tone="neutral" className="px-2 py-1 text-[10px]">
                {entry.primary_language_code}
              </Badge>
            ) : null}
          </div>

          <p className="mt-2 text-sm text-[#566172]">
            {primaryLanguageLabel}: {formatLanguage(entry, locale === 'pt-BR' ? 'Sem idioma' : locale === 'es' ? 'Sin idioma' : 'No language')}
          </p>

          <div className="mt-3 flex flex-wrap items-center gap-2 text-xs text-[#566172]">
            <span className="rounded-full border border-[#dfe3ea] bg-[#f7f8fb] px-2 py-1">
              {cpLabel} {formatter.format(entry.contribution_points)}
            </span>
            <span className="rounded-full border border-[#dfe3ea] bg-[#f7f8fb] px-2 py-1">
              {repLabel} {formatter.format(entry.reputation_score)}
            </span>
            <span className="rounded-full border border-[#dfe3ea] bg-[#f7f8fb] px-2 py-1">
              {qualityLabel} {formatter.format(Math.round(entry.approval_rate))}%
            </span>
            <span className="rounded-full border border-[#dfe3ea] bg-[#f7f8fb] px-2 py-1">
              {scoreLabel} {formatter.format(entry.ranking_score)}
            </span>
          </div>

          <div className="mt-3 flex flex-wrap items-center gap-2">
            <span className="pixel-label text-[10px] text-[#566172]">{badgesLabel}:</span>
            {entry.badges.slice(0, 3).map((badge) => (
              <Badge key={`${entry.user_id}-${badge.badge_id}`} tone="neutral" className="px-2 py-1 text-[10px]">
                {badge.name}
              </Badge>
            ))}
            {entry.badges.length === 0 ? <span className="text-xs text-[#8a94a6]">{emptyBadges}</span> : null}
          </div>
        </div>
      </div>
    </Link>
  );
}

function LeaderboardPanel({
  kind,
  entries,
  copy,
  locale
}: {
  kind: LeaderboardKind;
  entries: PublicLeaderboardEntry[];
  copy: LeaderboardCopy;
  locale: 'pt-BR' | 'en' | 'es';
}) {
  const meta = copy.categories[kind];
  const topEntry = entries[0];
  const formatter = new Intl.NumberFormat(getLocaleTag(locale));

  return (
    <Card className="overflow-hidden p-0">
      <div className={classNames('h-2 bg-gradient-to-r', meta.accent)} />
      <div className="border-b-2 border-[#101114] p-6">
        <div className="flex items-start justify-between gap-4">
          <div>
            <p className="pixel-label text-[10px] text-[#566172]">{copy.heroLabel}</p>
            <h2 className="mt-2 text-2xl font-bold text-[#101114]">{meta.title}</h2>
          </div>
          <Badge tone="accent">
            {formatter.format(entries.length)} {copy.visibleLabel}
          </Badge>
        </div>
        <p className="mt-3 max-w-xl text-sm leading-7 text-[#566172]">{meta.description}</p>
      </div>

      <div className="space-y-3 p-5">
        {topEntry ? (
          <div className="rounded-2xl border border-[#101114] bg-[#101114] p-4 text-white shadow-[6px_6px_0_#c7f464]">
            <div className="flex items-center justify-between gap-4">
              <p className="pixel-label text-[10px] text-[#c7f464]">{copy.topLabel}</p>
              <span className="rounded-full border border-white/20 bg-white/10 px-2 py-1 text-[10px] font-bold">
                #{topEntry.rank}
              </span>
            </div>
            <p className="mt-3 text-xl font-bold">{formatUsername(topEntry)}</p>
            <p className="mt-1 text-sm text-white/70">
              {copy.primaryLanguageLabel}: {formatLanguage(topEntry, locale === 'pt-BR' ? 'Sem idioma' : locale === 'es' ? 'Sin idioma' : 'No language')}
            </p>
            <div className="mt-4 flex flex-wrap gap-2">
              <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">
                {copy.cpLabel} {formatter.format(topEntry.contribution_points)}
              </Badge>
              <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">
                {copy.repLabel} {formatter.format(topEntry.reputation_score)}
              </Badge>
              <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">
                {copy.qualityLabel} {formatter.format(Math.round(topEntry.approval_rate))}%
              </Badge>
            </div>
            <p className="mt-4 text-xs leading-6 text-white/65">{meta.scoreHint}</p>
          </div>
        ) : null}

        <div className="space-y-3">
          {entries.length > 0 ? (
            entries.map((entry, index) => (
              <LeaderboardRowCard
                key={entry.user_id}
                entry={entry}
                index={index}
                scoreLabel={meta.scoreLabel}
                qualityLabel={copy.qualityLabel}
                cpLabel={copy.cpLabel}
                repLabel={copy.repLabel}
                badgesLabel={copy.badgesLabel}
                emptyBadges={copy.emptyBadges}
                primaryLanguageLabel={copy.primaryLanguageLabel}
                positionLabel={copy.positionLabel}
                locale={locale}
              />
            ))
          ) : (
            <div className="rounded-2xl border border-dashed border-[#dfe3ea] bg-[#f7f8fb] p-6 text-center text-sm text-[#566172]">
              {meta.empty}
            </div>
          )}
        </div>
      </div>
    </Card>
  );
}

export function LeaderboardPage() {
  const { locale } = useLocale();
  const copy = copyByLocale[locale];
  const [period, setPeriod] = useState<LeaderboardPeriod>('all_time');
  const [data, setData] = useState<PublicLeaderboardGroup>({ translators: [], reviewers: [], supporters: [] });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let active = true;

    async function load() {
      try {
        setLoading(true);
        setError(null);
        const result = await fetchPublicLeaderboards(period);

        if (!active) {
          return;
        }

        setData(result);
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

    return () => {
      active = false;
    };
  }, [period, copy.empty]);

  const periodMeta = useMemo(
    () => copy.periods.find((option) => option.value === period) ?? copy.periods[0],
    [copy.periods, period]
  );

  if (loading) {
    return <RouteLoadingScreen />;
  }

  if (error) {
    return (
      <PageShell eyebrow={copy.eyebrow} title={copy.title} description={copy.description}>
        <Card className="p-8 text-center">
          <h1 className="minecraft-title text-3xl text-[#101114]">
            {locale === 'pt-BR'
              ? 'Nao foi possivel carregar o ranking'
              : locale === 'es'
                ? 'No se pudo cargar el ranking'
                : 'Unable to load leaderboard'}
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
              <p className="pixel-label text-[10px] text-[#c7f464]">{copy.heroLabel}</p>
              <h2 className="minecraft-title mt-3 text-4xl leading-[.95] md:text-5xl">{copy.heroTitle}</h2>
              <p className="mt-4 max-w-2xl text-sm leading-7 text-white/70 md:text-base">{copy.heroLead}</p>
              <div className="mt-5 flex flex-wrap gap-2">
                <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">
                  {periodMeta.label}
                </Badge>
                <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">
                  {periodMeta.hint}
                </Badge>
                <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">
                  {copy.qualityNote}
                </Badge>
              </div>
            </div>

            <div className="rounded-3xl border border-white/10 bg-white/5 p-4">
              <p className="text-[10px] uppercase tracking-[0.3em] text-white/50">{copy.scoreLabel}</p>
              <div className="mt-4 grid gap-3">
                <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                  <p className="text-xs text-white/60">{copy.scoreTitle}</p>
                  <p className="mt-1 text-xl font-bold text-[#c7f464]">{copy.scoreLead}</p>
                </div>
                <div className="grid gap-3 sm:grid-cols-2">
                  <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                    <p className="text-xs text-white/60">{copy.scoreTags[0]}</p>
                    <p className="mt-1 text-lg font-bold text-[#c7f464]">CP</p>
                  </div>
                  <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                    <p className="text-xs text-white/60">{copy.scoreTags[1]}</p>
                    <p className="mt-1 text-lg font-bold text-[#4cc9f0]">Rep</p>
                  </div>
                </div>
                <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                  <p className="text-xs text-white/60">{copy.scoreTags[2]}</p>
                  <p className="mt-1 text-lg font-bold text-[#ffb86b]">{copy.rankingNote}</p>
                </div>
              </div>
            </div>
          </div>
        </Card>

        <Card className="p-4 md:p-5">
          <div className="flex flex-col gap-3 md:flex-row md:items-center md:justify-between">
            <div>
              <p className="pixel-label text-[10px] text-[#566172]">{copy.periodLabel}</p>
              <p className="mt-1 text-sm text-[#566172]">{copy.periodLead}</p>
            </div>
            <div className="grid grid-cols-2 gap-2 sm:flex">
              {copy.periods.map((option) => {
                const active = option.value === period;

                return (
                  <button
                    key={option.value}
                    type="button"
                    onClick={() => setPeriod(option.value)}
                    className={classNames(
                      'rounded-xl border-2 px-4 py-3 text-left transition sm:min-w-[150px]',
                      active
                        ? 'border-[#101114] bg-[#c7f464] text-[#101114] shadow-[4px_4px_0_#101114]'
                        : 'border-[#dfe3ea] bg-white text-[#566172] hover:border-[#101114]'
                    )}
                  >
                    <span className="block font-bold">{option.label}</span>
                    <span className="mt-1 block text-[10px] uppercase tracking-[0.25em]">{option.hint}</span>
                  </button>
                );
              })}
            </div>
          </div>
        </Card>

        <div className="grid gap-6 xl:grid-cols-3">
          <LeaderboardPanel kind="translators" entries={data.translators} copy={copy} locale={locale} />
          <LeaderboardPanel kind="reviewers" entries={data.reviewers} copy={copy} locale={locale} />
          <LeaderboardPanel kind="supporters" entries={data.supporters} copy={copy} locale={locale} />
        </div>
      </div>
    </PageShell>
  );
}
