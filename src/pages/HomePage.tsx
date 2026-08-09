import { useEffect, useMemo, useState } from 'react';
import { Link } from 'react-router-dom';
import { Card } from '@/components/ui/Card';
import { Badge } from '@/components/ui/Badge';
import { MetricCard } from '@/components/ui/MetricCard';
import { ProgressBar } from '@/components/ui/ProgressBar';
import { StatusPill } from '@/components/ui/StatusPill';
import { RouteLoadingScreen } from '@/components/layout/RouteLoadingScreen';
import { useAuth } from '@/hooks/useAuth';
import { paths } from '@/navigation/paths';
import { fetchHomePublicData, type HomePublicData } from '@/services/publicHome';

const repoUrl = 'https://github.com/ithalov/site_CraftTranslate';

const heroSignals = [
  'Discord login',
  'Community review',
  'Public rankings',
  'Minecraft-friendly'
];

function avatarInitial(name: string | null | undefined) {
  return (name ?? 'C').slice(0, 1).toUpperCase();
}

function formatNumber(value: number) {
  return new Intl.NumberFormat('en-US').format(value);
}

function getStartPath(isAuthenticated: boolean) {
  return isAuthenticated ? paths.dashboard : paths.login;
}

function getDiscordPath() {
  return paths.login;
}

function PersonList({
  title,
  subtitle,
  items,
  accent
}: {
  title: string;
  subtitle: string;
  items: HomePublicData['translators'];
  accent: 'accent' | 'success' | 'warning';
}) {
  return (
    <Card className="p-6 md:p-7">
      <div className="flex items-start justify-between gap-4">
        <div>
          <p className="pixel-label text-[10px] text-[#566172]">{title}</p>
          <h3 className="mt-2 text-2xl font-bold text-[#101114]">{subtitle}</h3>
        </div>
        <Badge tone={accent}>Top 4</Badge>
      </div>

      <div className="mt-5 space-y-3">
        {items.length > 0 ? (
          items.map((item, index) => (
            <div key={item.user_id} className="flex items-center gap-4 rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-3">
              <div className="flex h-12 w-12 items-center justify-center overflow-hidden rounded-xl border-2 border-[#101114] bg-[#101114] text-sm font-bold text-white">
                {item.avatar_url ? (
                  <img src={item.avatar_url} alt={item.display_name ?? item.username ?? 'user'} className="h-full w-full object-cover" />
                ) : (
                  <span>{avatarInitial(item.display_name ?? item.username)}</span>
                )}
              </div>
              <div className="min-w-0 flex-1">
                <p className="truncate text-sm font-bold text-[#101114]">
                  {index + 1}. {item.display_name ?? item.username ?? 'Unnamed player'}
                </p>
                <p className="text-xs text-[#566172]">
                  {formatNumber(item.total_xp)} XP · {formatNumber(item.reputation_score)} rep · #{item.rank}
                </p>
              </div>
            </div>
          ))
        ) : (
          <p className="text-sm text-[#566172]">No public entries yet.</p>
        )}
      </div>
    </Card>
  );
}

export function HomePage() {
  const { isAuthenticated } = useAuth();
  const [data, setData] = useState<HomePublicData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let active = true;

    async function load() {
      try {
        setLoading(true);
        setError(null);
        const result = await fetchHomePublicData();

        if (!active) {
          return;
        }

        setData(result);
      } catch (loadError) {
        if (active) {
          setError(loadError instanceof Error ? loadError.message : 'Unable to load public data.');
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
  }, []);

  const startPath = getStartPath(isAuthenticated);
  const discordPath = getDiscordPath();
  const communityGoalTarget = 500;
  const approvedGoal = data?.stats.approvedSuggestions ?? 0;
  const communityGoalProgress = Math.min(100, Math.round((approvedGoal / communityGoalTarget) * 100));

  const featuredLanguages = useMemo(() => data?.languages.slice(0, 4) ?? [], [data]);

  if (loading) {
    return <RouteLoadingScreen />;
  }

  if (error) {
    return (
      <section className="grid min-h-[70vh] place-items-center px-[var(--space-page)] py-10">
        <Card className="w-full max-w-2xl p-8 text-center">
          <p className="pixel-label text-[10px] text-[#566172]">Home</p>
          <h1 className="minecraft-title mt-3 text-4xl text-[#101114]">Unable to load home</h1>
          <p className="mt-4 text-sm leading-7 text-[#566172]">{error}</p>
        </Card>
      </section>
    );
  }

  const stats = data?.stats ?? {
    contributors: 0,
    totalTranslations: 0,
    totalReviews: 0,
    totalBadges: 0,
    activeLanguages: 0,
    averageProgress: 0,
    approvedSuggestions: 0
  };

  return (
    <section className="pb-16">
      <div className="mx-[calc(var(--space-page)*-1)] border-b-2 border-[#101114] bg-[#101114] text-white">
        <div className="mx-auto grid w-full max-w-7xl gap-10 px-[var(--space-page)] py-16 md:py-24 lg:grid-cols-[1.02fr_.98fr] lg:items-center">
          <div className="animate-[block-rise_.7s_ease-out_both]">
            <div className="flex flex-wrap gap-2">
              {heroSignals.map((signal) => (
                <StatusPill key={signal} tone="accent">
                  {signal}
                </StatusPill>
              ))}
            </div>

            <p className="pixel-label mt-6 text-xs text-[#c7f464]">Minecraft community translation</p>
            <h1 className="minecraft-title mt-4 max-w-3xl text-5xl leading-[.94] tracking-[-.06em] sm:text-6xl md:text-7xl">
              One community.
              <br />
              <span className="text-[#c7f464]">Many languages.</span>
            </h1>
            <p className="mt-6 max-w-2xl text-base leading-8 text-white/70 md:text-lg">
              ChatTranslate Web helps Minecraft communities translate chat, guide new players and keep every conversation clear without exposing private data.
            </p>
            <div className="mt-8 flex flex-wrap gap-3">
              <Link to={startPath} className="block-button px-5 py-3 text-sm transition">
                Start Translating <span aria-hidden="true">-&gt;</span>
              </Link>
              <a
                href={repoUrl}
                target="_blank"
                rel="noreferrer"
                className="rounded-lg border-2 border-white/80 px-5 py-3 font-[var(--font-display)] text-sm font-bold text-white transition hover:-translate-y-1 hover:bg-white hover:text-[#101114]"
              >
                GitHub
              </a>
              <Link
                to={discordPath}
                className="rounded-lg border-2 border-[#c7f464] bg-[#c7f464] px-5 py-3 font-[var(--font-display)] text-sm font-bold text-[#101114] transition hover:-translate-y-1 hover:bg-white"
              >
                Discord
              </Link>
            </div>

            <div className="mt-8 grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
              {[
                ['Public contributors', formatNumber(stats.contributors), 'community members'],
                ['Active languages', formatNumber(stats.activeLanguages), 'main language lanes'],
                ['Translations', formatNumber(stats.totalTranslations), 'public activity'],
                ['Reviews', formatNumber(stats.totalReviews), 'quality checks']
              ].map(([label, value, hint]) => (
                <div key={label as string} className="rounded-2xl border border-white/10 bg-white/5 p-4">
                  <p className="text-[10px] uppercase tracking-[0.3em] text-white/50">{label}</p>
                  <p className="mt-2 text-2xl font-bold text-white">{value}</p>
                  <p className="mt-1 text-xs text-white/60">{hint}</p>
                </div>
              ))}
            </div>
          </div>

          <div className="relative animate-[block-rise_.7s_.14s_ease-out_both]">
            <div className="absolute -inset-5 bg-[radial-gradient(circle_at_20%_15%,rgba(199,244,100,.25),transparent_38%),radial-gradient(circle_at_85%_75%,rgba(76,201,240,.2),transparent_35%)] blur-2xl" />
            <div className="relative overflow-hidden rounded-lg border-2 border-white/90 bg-[#f7f8fb] text-[#101114] shadow-[9px_9px_0_#c7f464]">
              <div className="flex items-center justify-between border-b-2 border-[#101114] px-5 py-4">
                <div>
                  <p className="pixel-label text-[10px] text-[#566172]">Community goal</p>
                  <h2 className="mt-1 font-[var(--font-display)] text-lg font-bold">Build the next 500 approved suggestions</h2>
                </div>
                <Badge tone="success">{communityGoalProgress}%</Badge>
              </div>
              <div className="space-y-4 p-5">
                <ProgressBar label="Goal progress" value={communityGoalProgress} tone="accent" />
                <div className="grid gap-3 md:grid-cols-2">
                  <div className="rounded-xl border border-[#dfe3ea] bg-white p-4">
                    <p className="text-[10px] uppercase tracking-[0.3em] text-[#566172]">Approved suggestions</p>
                    <p className="mt-2 text-3xl font-bold text-[#101114]">{formatNumber(approvedGoal)}</p>
                    <p className="mt-2 text-sm text-[#566172]">Public milestone tracked from language progress.</p>
                  </div>
                  <div className="rounded-xl border border-[#dfe3ea] bg-white p-4">
                    <p className="text-[10px] uppercase tracking-[0.3em] text-[#566172]">Average progress</p>
                    <p className="mt-2 text-3xl font-bold text-[#101114]">{stats.averageProgress}%</p>
                    <p className="mt-2 text-sm text-[#566172]">Across the main active languages.</p>
                  </div>
                </div>
                <div className="rounded-xl border border-[#dfe3ea] bg-white p-4">
                  <p className="text-[10px] uppercase tracking-[0.3em] text-[#566172]">What this means</p>
                  <p className="mt-2 text-sm leading-7 text-[#566172]">
                    When the community keeps translating and reviewing, approved suggestions grow and language packs become more useful for every player.
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div className="mx-auto w-full max-w-7xl px-[var(--space-page)]">
        <div className="grid gap-4 py-10 sm:grid-cols-2 xl:grid-cols-4">
          <MetricCard label="Active languages" value={formatNumber(stats.activeLanguages)} hint="public progress" />
          <MetricCard label="Supporters" value={formatNumber(stats.totalBadges)} hint="earned badges" />
          <MetricCard label="Approved suggestions" value={formatNumber(stats.approvedSuggestions)} hint="milestone count" />
          <MetricCard label="Average progress" value={`${stats.averageProgress}%`} hint="all main languages" />
        </div>

        <div className="grid gap-12 border-t border-[#dfe3ea] py-16 lg:grid-cols-[1fr_1.05fr] lg:items-start">
          <div>
            <p className="pixel-label text-xs text-[#566172]">How community translation works</p>
            <h2 className="minecraft-title mt-3 text-4xl leading-none text-[#101114] md:text-5xl">
              A calm flow for
              <br />
              <span className="text-[#5652ff]">players, translators and reviewers.</span>
            </h2>
            <p className="mt-5 max-w-md leading-7 text-[#566172]">
              ChatTranslate keeps the process lightweight: contributors choose their languages, translations are suggested in context, and reviewers approve the best version for the community.
            </p>
            <div className="mt-6 flex flex-wrap gap-2">
              <StatusPill tone="success">Open workflow</StatusPill>
              <StatusPill tone="accent">Discord-powered</StatusPill>
            </div>
          </div>

          <div className="grid gap-4 md:grid-cols-3">
            {[
              ['01', 'Capture', 'Messages and strings arrive with context intact.'],
              ['02', 'Translate', 'Members create clear suggestions in the right language.'],
              ['03', 'Review', 'Trusted reviewers approve what reaches the community.']
            ].map(([number, title, copy], index) => (
              <Card key={number} className="p-5 transition duration-200 hover:-translate-x-1 hover:-translate-y-1 hover:shadow-[10px_10px_0_#101114]">
                <span
                  className="font-[var(--font-display)] text-sm font-bold"
                  style={{ color: ['#4cc9f0', '#5652ff', '#ff6b5f'][index] }}
                >
                  {number}
                </span>
                <h3 className="minecraft-title mt-8 text-2xl text-[#101114]">{title}</h3>
                <p className="mt-3 text-sm leading-6 text-[#566172]">{copy}</p>
              </Card>
            ))}
          </div>
        </div>

        <div className="grid gap-6 border-t border-[#dfe3ea] py-16 xl:grid-cols-3">
          <Card className="p-6 md:p-7 xl:col-span-3">
            <div className="flex flex-col gap-4 md:flex-row md:items-end md:justify-between">
              <div>
                <p className="pixel-label text-[10px] text-[#566172]">Main languages</p>
                <h2 className="minecraft-title mt-2 text-3xl text-[#101114]">Progress of the most active languages</h2>
              </div>
              <p className="max-w-xl text-sm leading-7 text-[#566172]">
                These metrics are public and safe to show. They help the community see where translation effort is moving.
              </p>
            </div>

            <div className="mt-6 grid gap-4 md:grid-cols-2 xl:grid-cols-4">
              {featuredLanguages.map((language) => (
                <div key={language.language_id} className="rounded-2xl border-2 border-[#101114] bg-white p-4">
                  <div className="flex items-start justify-between gap-3">
                    <div>
                      <p className="text-sm font-bold text-[#101114]">
                        {language.emoji ? `${language.emoji} ` : ''}
                        {language.name}
                      </p>
                      <p className="mt-1 text-xs text-[#566172]">{language.native_name}</p>
                    </div>
                    <Badge tone="neutral">{language.code}</Badge>
                  </div>
                  <div className="mt-4">
                    <ProgressBar label="Progress" value={Math.round(Number(language.progress_percent ?? 0))} tone="accent" />
                  </div>
                  <div className="mt-4 flex flex-wrap gap-2">
                    <Badge tone="success">{formatNumber(Number(language.approved_suggestions ?? 0))} approved</Badge>
                    <Badge tone="neutral">{formatNumber(Number(language.active_translators ?? 0))} translators</Badge>
                  </div>
                </div>
              ))}
            </div>
          </Card>

          <PersonList
            title="Top translators"
            subtitle="Most active translation contributors"
            items={data?.translators ?? []}
            accent="accent"
          />
          <PersonList
            title="Top reviewers"
            subtitle="Most active review contributors"
            items={data?.reviewers ?? []}
            accent="success"
          />
          <PersonList
            title="Supporters"
            subtitle="Badges and community support"
            items={data?.supporters ?? []}
            accent="warning"
          />
        </div>

        <div className="grid gap-6 border-t border-[#dfe3ea] py-16 lg:grid-cols-[1fr_0.95fr]">
          <Card className="p-6 md:p-8">
            <p className="pixel-label text-[10px] text-[#566172]">Why it works</p>
            <h2 className="minecraft-title mt-3 text-4xl leading-none text-[#101114] md:text-5xl">
              Built for community
              <br />
              <span className="text-[#c7f464]">without losing clarity.</span>
            </h2>
            <div className="mt-6 grid gap-4 md:grid-cols-2">
              {[
                ['Accessible flow', 'Every contributor sees the same public progress and simple entry points.'],
                ['Quality first', 'Review and moderation keep language packs clean and useful.'],
                ['No private leaks', 'Public pages only use safe views and derived metrics.'],
                ['Future-ready', 'The layout is ready for more languages, badges and seasonal goals.']
              ].map(([title, copy]) => (
                <div key={title} className="rounded-xl border-2 border-[#101114] bg-white p-4">
                  <p className="text-sm font-bold text-[#101114]">{title}</p>
                  <p className="mt-2 text-sm leading-6 text-[#566172]">{copy}</p>
                </div>
              ))}
            </div>
          </Card>

          <Card className="overflow-hidden p-0">
            <div className="bg-[#101114] px-6 py-6 text-white md:px-8">
              <p className="pixel-label text-[10px] text-[#c7f464]">Final CTA</p>
              <h2 className="minecraft-title mt-3 text-4xl leading-none md:text-5xl">
                Ready to start
                <br />
                contributing?
              </h2>
              <p className="mt-4 max-w-md text-sm leading-7 text-white/70">
                Join the translation flow, pick your languages and help keep every Minecraft player included.
              </p>
            </div>
            <div className="p-6 md:p-8">
              <div className="flex flex-wrap gap-3">
                <Link to={startPath} className="block-button px-5 py-3 text-sm transition">
                  Start Translating
                </Link>
                <a
                  href={repoUrl}
                  target="_blank"
                  rel="noreferrer"
                  className="rounded-lg border-2 border-[#101114] px-5 py-3 font-[var(--font-display)] text-sm font-bold text-[#101114] transition hover:-translate-y-1 hover:bg-[#101114] hover:text-white"
                >
                  GitHub
                </a>
                <Link
                  to={discordPath}
                  className="rounded-lg border-2 border-[#101114] bg-[#f7f8fb] px-5 py-3 font-[var(--font-display)] text-sm font-bold text-[#101114] transition hover:-translate-y-1 hover:bg-white"
                >
                  Discord
                </Link>
              </div>
              <p className="mt-5 text-sm leading-7 text-[#566172]">
                Want to see your own profile? Log in with Discord, choose your languages and join the contributor ranking.
              </p>
            </div>
          </Card>
        </div>
      </div>
    </section>
  );
}
