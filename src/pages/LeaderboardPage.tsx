import { useEffect, useMemo, useState } from 'react';
import { Link } from 'react-router-dom';
import { Badge } from '@/components/ui/Badge';
import { Card } from '@/components/ui/Card';
import { RouteLoadingScreen } from '@/components/layout/RouteLoadingScreen';
import { PageShell } from '@/components/page/PageShell';
import { classNames } from '@/utils/classNames';
import { paths } from '@/navigation/paths';
import {
  fetchPublicLeaderboards,
  type LeaderboardKind,
  type LeaderboardPeriod,
  type PublicLeaderboardEntry,
  type PublicLeaderboardGroup
} from '@/services/publicLeaderboards';

const periodOptions: Array<{ value: LeaderboardPeriod; label: string; hint: string }> = [
  { value: 'all_time', label: 'All Time', hint: 'Lifetime activity' },
  { value: 'year', label: 'Year', hint: 'Current year' },
  { value: 'month', label: 'Month', hint: 'Current month' },
  { value: 'week', label: 'Week', hint: 'Current week' }
];

const categoryMeta: Record<
  LeaderboardKind,
  {
    title: string;
    description: string;
    accent: string;
    scoreLabel: string;
  }
> = {
  translators: {
    title: 'Top Translators',
    description: 'Ranked by contribution points, reputation and approved translation work.',
    accent: 'from-[#c7f464] to-[#87f5d8]',
    scoreLabel: 'Translator score'
  },
  reviewers: {
    title: 'Top Reviewers',
    description: 'Ranked by review quality, contribution points and approval rate.',
    accent: 'from-[#4cc9f0] to-[#b7a7ff]',
    scoreLabel: 'Reviewer score'
  },
  supporters: {
    title: 'Supporters',
    description: 'Ranked by badges, contribution points and community reputation.',
    accent: 'from-[#ffb86b] to-[#ffe3a1]',
    scoreLabel: 'Supporter score'
  }
};

function avatarInitial(name: string | null | undefined) {
  return (name ?? 'C').slice(0, 1).toUpperCase();
}

function formatNumber(value: number) {
  return new Intl.NumberFormat('en-US').format(value);
}

function formatUsername(entry: PublicLeaderboardEntry) {
  return entry.username ?? entry.display_name ?? 'Unnamed collaborator';
}

function formatLanguage(entry: PublicLeaderboardEntry) {
  const code = entry.primary_language_code ?? '—';
  const name = entry.primary_language_name ?? entry.primary_language_native_name ?? 'No primary language';
  return `${code} · ${name}`;
}

function getProfilePath(entry: PublicLeaderboardEntry) {
  const handle = entry.username ?? entry.display_name ?? entry.user_id;
  return paths.publicProfile.replace(':handle', encodeURIComponent(handle));
}

function LeaderboardRowCard({ entry, index, scoreLabel }: { entry: PublicLeaderboardEntry; index: number; scoreLabel: string }) {
  const topBadge = index < 3 ? ['#c7f464', '#4cc9f0', '#ffb86b'][index] : '#dfe3ea';

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
            <img
              src={entry.avatar_url}
              alt={formatUsername(entry)}
              className="h-full w-full object-cover"
            />
          ) : (
            <span>{avatarInitial(entry.display_name ?? entry.username)}</span>
          )}
        </div>

        <div className="min-w-0 flex-1">
          <div className="flex flex-wrap items-center gap-2">
            <span className="rounded-full border border-[#101114] bg-[#101114] px-2 py-1 text-[10px] font-bold text-white">
              #{entry.rank}
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

          <p className="mt-2 text-sm text-[#566172]">{formatLanguage(entry)}</p>

          <div className="mt-3 flex flex-wrap items-center gap-2 text-xs text-[#566172]">
            <span className="rounded-full border border-[#dfe3ea] bg-[#f7f8fb] px-2 py-1">
              CP {formatNumber(entry.contribution_points)}
            </span>
            <span className="rounded-full border border-[#dfe3ea] bg-[#f7f8fb] px-2 py-1">
              {scoreLabel} {formatNumber(entry.ranking_score)}
            </span>
            <span className="rounded-full border border-[#dfe3ea] bg-[#f7f8fb] px-2 py-1">
              Rep {formatNumber(entry.reputation_score)}
            </span>
          </div>

          <div className="mt-3 flex flex-wrap gap-2">
            {entry.badges.slice(0, 3).map((badge) => (
              <Badge key={`${entry.user_id}-${badge.badge_id}`} tone="neutral" className="px-2 py-1 text-[10px]">
                {badge.name}
              </Badge>
            ))}
            {entry.badges.length === 0 ? (
              <span className="text-xs text-[#8a94a6]">No public badges yet</span>
            ) : null}
          </div>
        </div>
      </div>
    </Link>
  );
}

function LeaderboardPanel({
  kind,
  entries
}: {
  kind: LeaderboardKind;
  entries: PublicLeaderboardEntry[];
}) {
  const meta = categoryMeta[kind];
  const topEntry = entries[0];

  return (
    <Card className="overflow-hidden p-0">
      <div className={classNames('h-2 bg-gradient-to-r', meta.accent)} />
      <div className="border-b-2 border-[#101114] p-6">
        <div className="flex items-start justify-between gap-4">
          <div>
            <p className="pixel-label text-[10px] text-[#566172]">Public ranking</p>
            <h2 className="mt-2 text-2xl font-bold text-[#101114]">{meta.title}</h2>
          </div>
          <Badge tone="accent">{entries.length} visible</Badge>
        </div>
        <p className="mt-3 max-w-xl text-sm leading-7 text-[#566172]">{meta.description}</p>
      </div>

      <div className="space-y-3 p-5">
        {topEntry ? (
          <div className="rounded-2xl border border-[#101114] bg-[#101114] p-4 text-white shadow-[6px_6px_0_#c7f464]">
            <div className="flex items-center justify-between gap-4">
              <p className="pixel-label text-[10px] text-[#c7f464]">Leader</p>
              <span className="rounded-full border border-white/20 bg-white/10 px-2 py-1 text-[10px] font-bold">
                #{topEntry.rank}
              </span>
            </div>
            <p className="mt-3 text-xl font-bold">{formatUsername(topEntry)}</p>
            <p className="mt-1 text-sm text-white/70">{formatLanguage(topEntry)}</p>
            <div className="mt-4 flex flex-wrap gap-2">
              <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">
                CP {formatNumber(topEntry.contribution_points)}
              </Badge>
              <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">
                Rep {formatNumber(topEntry.reputation_score)}
              </Badge>
            </div>
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
              />
            ))
          ) : (
            <div className="rounded-2xl border border-dashed border-[#dfe3ea] bg-[#f7f8fb] p-6 text-center text-sm text-[#566172]">
              No public entries for this period yet.
            </div>
          )}
        </div>
      </div>
    </Card>
  );
}

export function LeaderboardPage() {
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
          setError(loadError instanceof Error ? loadError.message : 'Unable to load leaderboards.');
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
  }, [period]);

  const periodMeta = useMemo(
    () => periodOptions.find((option) => option.value === period) ?? periodOptions[0],
    [period]
  );

  if (loading) {
    return <RouteLoadingScreen />;
  }

  if (error) {
    return (
      <PageShell
        eyebrow="Leaderboard"
        title="Community rankings"
        description="Rankings públicos por período, qualidade e contribuição."
      >
        <Card className="p-8 text-center">
          <h1 className="minecraft-title text-3xl text-[#101114]">Unable to load leaderboard</h1>
          <p className="mt-4 text-sm leading-7 text-[#566172]">{error}</p>
        </Card>
      </PageShell>
    );
  }

  return (
    <PageShell
      eyebrow="Leaderboard"
      title="Community rankings"
      description="Rankings públicos para tradutores, revisores e supporters, com foco em contribuição real, reputação e qualidade."
    >
      <div className="space-y-6">
        <Card className="overflow-hidden bg-[#101114] p-0 text-white">
          <div className="grid gap-6 px-6 py-6 md:px-8 md:py-8 lg:grid-cols-[1.1fr_.9fr] lg:items-center">
            <div>
              <p className="pixel-label text-[10px] text-[#c7f464]">Public data only</p>
              <h2 className="minecraft-title mt-3 text-4xl leading-[.95] md:text-5xl">
                Quality-first rankings for the community.
              </h2>
              <p className="mt-4 max-w-2xl text-sm leading-7 text-white/70 md:text-base">
                The leaderboard uses contribution points, reputation and approval signals so active helpers rise above raw-volume spam.
              </p>
              <div className="mt-5 flex flex-wrap gap-2">
                <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">
                  {periodMeta.label}
                </Badge>
                <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">
                  {periodMeta.hint}
                </Badge>
                <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">
                  No private strings exposed
                </Badge>
              </div>
            </div>

            <div className="rounded-3xl border border-white/10 bg-white/5 p-4">
              <p className="text-[10px] uppercase tracking-[0.3em] text-white/50">Scoring focus</p>
              <div className="mt-4 grid gap-3 sm:grid-cols-3 lg:grid-cols-1">
                <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                  <p className="text-xs text-white/60">Contribution Points</p>
                  <p className="mt-1 text-xl font-bold text-[#c7f464]">Weighted core</p>
                </div>
                <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                  <p className="text-xs text-white/60">Reputation</p>
                  <p className="mt-1 text-xl font-bold text-[#4cc9f0]">Quality signal</p>
                </div>
                <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                  <p className="text-xs text-white/60">Badges</p>
                  <p className="mt-1 text-xl font-bold text-[#ffb86b]">Community proof</p>
                </div>
              </div>
            </div>
          </div>
        </Card>

        <Card className="p-4 md:p-5">
          <div className="flex flex-col gap-3 md:flex-row md:items-center md:justify-between">
            <div>
              <p className="pixel-label text-[10px] text-[#566172]">Time filter</p>
              <p className="mt-1 text-sm text-[#566172]">Choose the time window you want to inspect.</p>
            </div>
            <div className="grid grid-cols-2 gap-2 sm:flex">
              {periodOptions.map((option) => {
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
          <LeaderboardPanel kind="translators" entries={data.translators} />
          <LeaderboardPanel kind="reviewers" entries={data.reviewers} />
          <LeaderboardPanel kind="supporters" entries={data.supporters} />
        </div>
      </div>
    </PageShell>
  );
}
