import { useEffect, useMemo, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import { Badge } from '@/components/ui/Badge';
import { Card } from '@/components/ui/Card';
import { MetricCard } from '@/components/ui/MetricCard';
import { ProgressBar } from '@/components/ui/ProgressBar';
import { StatusPill } from '@/components/ui/StatusPill';
import { RouteLoadingScreen } from '@/components/layout/RouteLoadingScreen';
import { fetchPublicProfilePage, type PublicProfilePage as PublicProfileData } from '@/services/publicProfiles';
import { buildPublicProfileHandle } from '@/utils/profilePaths';
import { paths } from '@/navigation/paths';

type ProfileState = 'new user' | 'translator' | 'reviewer' | 'moderator' | 'supporter';

const roleLabels: Record<string, string> = {
  member: 'Member',
  user: 'Player',
  translator: 'Translator',
  trusted_translator: 'Trusted translator',
  reviewer: 'Reviewer',
  language_moderator: 'Language moderator',
  moderator: 'Moderator',
  admin: 'Admin',
  owner: 'Owner'
};

const stateLabels: Record<ProfileState, string> = {
  'new user': 'New user',
  translator: 'Translator',
  reviewer: 'Reviewer',
  moderator: 'Moderator',
  supporter: 'Supporter'
};

const stateTones: Record<ProfileState, 'accent' | 'success' | 'warning' | 'danger'> = {
  'new user': 'warning',
  translator: 'accent',
  reviewer: 'success',
  moderator: 'danger',
  supporter: 'accent'
};

function toState(value: string): ProfileState {
  if (value === 'translator' || value === 'reviewer' || value === 'moderator' || value === 'supporter') {
    return value;
  }

  return 'new user';
}

function formatPercent(value: number) {
  return `${Math.round(value)}%`;
}

function formatCurrencyLabel(value: number) {
  return new Intl.NumberFormat('en-US').format(value);
}

function languageTone(proficiency: string) {
  if (proficiency === 'native') {
    return 'accent';
  }

  if (proficiency === 'fluent' || proficiency === 'advanced') {
    return 'success';
  }

  if (proficiency === 'intermediate') {
    return 'warning';
  }

  return 'neutral';
}

function badgeTone(rarity: string) {
  if (rarity === 'legendary') {
    return 'danger';
  }

  if (rarity === 'epic' || rarity === 'rare') {
    return 'accent';
  }

  return 'neutral';
}

function levelLabel(level: number) {
  return `Level ${level}`;
}

export function PublicProfilePage() {
  const params = useParams<{ handle: string }>();
  const handle = params.handle ?? '';
  const [profile, setProfile] = useState<PublicProfileData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let active = true;

    async function loadProfile() {
      if (!handle) {
        setLoading(false);
        return;
      }

      try {
        setLoading(true);
        setError(null);

        const result = await fetchPublicProfilePage(handle);

        if (!active) {
          return;
        }

        setProfile(result);
      } catch (loadError) {
        if (active) {
          setError(loadError instanceof Error ? loadError.message : 'Unable to load public profile.');
        }
      } finally {
        if (active) {
          setLoading(false);
        }
      }
    }

    void loadProfile();

    return () => {
      active = false;
    };
  }, [handle]);

  const publicHandle = useMemo(() => {
    if (!profile) {
      return handle;
    }

    return buildPublicProfileHandle(profile.username, profile.display_name, profile.user_id);
  }, [handle, profile]);

  if (loading) {
    return <RouteLoadingScreen />;
  }

  if (error || !profile) {
    return (
      <section className="grid min-h-[70vh] place-items-center px-[var(--space-page)] py-10">
        <Card className="w-full max-w-xl p-8 text-center">
          <p className="pixel-label text-[10px] text-[#566172]">Public profile</p>
          <h1 className="minecraft-title mt-3 text-4xl text-[#101114]">
            {error ? 'Unable to load profile' : 'Profile not found'}
          </h1>
          <p className="mt-4 text-sm leading-7 text-[#566172]">
            {error ?? 'This collaborator has not published a profile yet.'}
          </p>
          <Link to={paths.home} className="block-button mt-6 inline-flex px-5 py-3 text-sm">
            Back home
          </Link>
        </Card>
      </section>
    );
  }

  const profileState = toState(profile.profile_state);
  const displayName = profile.display_name ?? profile.username ?? 'Unnamed player';
  const avatar = profile.avatar_url ?? '';
  const publicUrl = typeof window !== 'undefined'
    ? `${window.location.origin}${import.meta.env.BASE_URL}${publicHandle ? `u/${publicHandle}` : ''}`
    : '';

  return (
    <section className="space-y-6 px-[var(--space-page)] py-10">
      <Card className="overflow-hidden p-0">
        <div className="relative overflow-hidden bg-[#101114] px-8 py-8 text-white md:px-10">
          <div className="absolute inset-0 bg-[radial-gradient(circle_at_top,rgba(199,244,100,.18),transparent_45%),radial-gradient(circle_at_bottom_right,rgba(76,201,240,.14),transparent_34%)]" />
          <div className="relative flex flex-col gap-6 md:flex-row md:items-center md:justify-between">
            <div className="flex items-center gap-5">
              <div className="flex h-20 w-20 items-center justify-center overflow-hidden rounded-3xl border-2 border-[#c7f464] bg-[#1a1d24]">
                {avatar ? (
                  <img src={avatar} alt={displayName} className="h-full w-full object-cover" />
                ) : (
                  <span className="minecraft-title text-3xl text-[#c7f464]">
                    {displayName.slice(0, 1).toUpperCase()}
                  </span>
                )}
              </div>

              <div>
                <p className="pixel-label text-[10px] text-[#c7f464]">Public collaborator profile</p>
                <h1 className="minecraft-title mt-3 text-4xl leading-none md:text-5xl">
                  {displayName}
                </h1>
                <div className="mt-3 flex flex-wrap items-center gap-2">
                  <Badge tone="accent">{stateLabels[profileState]}</Badge>
                  <Badge tone="neutral">{roleLabels[profile.role] ?? profile.role}</Badge>
                  <Badge tone="neutral">@{publicHandle || profile.user_id.slice(0, 8)}</Badge>
                </div>
              </div>
            </div>

            <div className="grid gap-2 text-right text-sm text-white/70">
              <span className="pixel-label text-[10px] text-[#c7f464]">Public URL</span>
              <span className="rounded-lg border border-white/10 bg-white/5 px-3 py-2 text-left font-mono text-xs text-white">
                {publicUrl || `${publicHandle}`}
              </span>
            </div>
          </div>
        </div>

        <div className="grid gap-4 p-6 md:grid-cols-2 xl:grid-cols-6 md:p-8">
          <MetricCard label="Level" value={levelLabel(profile.profile_level)} hint={stateLabels[profileState]} />
          <MetricCard label="XP" value={formatCurrencyLabel(profile.total_xp)} hint="total" />
          <MetricCard label="Reputation" value={formatCurrencyLabel(profile.reputation_score)} hint="community" />
          <MetricCard
            label="Contribution Points"
            value={formatCurrencyLabel(profile.contribution_points)}
            hint="ranked"
          />
          <MetricCard label="Rank" value={`#${profile.rank}`} hint="leaderboard" />
          <MetricCard label="Approval" value={formatPercent(profile.approval_rate)} hint="reviews" />
        </div>
      </Card>

      <div className="grid gap-6 xl:grid-cols-[1.08fr_0.92fr]">
        <Card className="p-6 md:p-8">
          <p className="pixel-label text-[10px] text-[#566172]">Overview</p>
          <div className="mt-4 grid gap-4 md:grid-cols-2">
            <div className="rounded-xl border-2 border-[#101114] bg-white p-4">
              <p className="text-[10px] uppercase tracking-[0.3em] text-[#566172]">Username</p>
              <p className="mt-2 text-base font-bold text-[#101114]">
                {profile.username ?? 'Not set'}
              </p>
            </div>
            <div className="rounded-xl border-2 border-[#101114] bg-white p-4">
              <p className="text-[10px] uppercase tracking-[0.3em] text-[#566172]">Locale</p>
              <p className="mt-2 text-base font-bold text-[#101114]">
                {profile.preferred_locale}
              </p>
            </div>
            <div className="rounded-xl border-2 border-[#101114] bg-white p-4 md:col-span-2">
              <p className="text-[10px] uppercase tracking-[0.3em] text-[#566172]">Bio</p>
              <p className="mt-2 text-sm leading-7 text-[#101114]">
                {profile.bio ?? 'No public bio yet.'}
              </p>
            </div>
          </div>

          <div className="mt-6 rounded-2xl border-2 border-[#101114] bg-[#f7f8fb] p-5">
            <div className="flex flex-wrap items-center justify-between gap-3">
              <div>
                <p className="text-sm font-bold text-[#101114]">Public performance</p>
                <p className="mt-1 text-xs text-[#566172]">
                  Contribution points, approval rate and ranking are derived from public activity only.
                </p>
              </div>
              <StatusPill tone={stateTones[profileState]}>{stateLabels[profileState]}</StatusPill>
            </div>
            <div className="mt-4 space-y-4">
              <ProgressBar label="Approval rate" value={Math.round(profile.approval_rate)} tone="success" />
              <ProgressBar
                label="Translation activity"
                value={Math.min(100, Math.round((profile.translations_count / Math.max(profile.translations_count + profile.reviews_count, 1)) * 100))}
                tone="accent"
              />
            </div>
          </div>
        </Card>

        <Card className="p-6 md:p-8">
          <p className="pixel-label text-[10px] text-[#566172]">Functions</p>
          <div className="mt-4 flex flex-wrap gap-2">
            {profile.functions.length > 0 ? (
              profile.functions.map((fn) => (
                <Badge key={fn} tone="neutral">
                  {fn}
                </Badge>
              ))
            ) : (
              <Badge tone="neutral">New user</Badge>
            )}
          </div>

          <p className="pixel-label mt-8 text-[10px] text-[#566172]">Languages</p>
          <div className="mt-4 grid gap-3">
            {profile.languages.length > 0 ? (
              profile.languages.map((language) => (
                <div
                  key={language.language_id}
                  className="rounded-2xl border-2 border-[#101114] bg-white p-4"
                >
                  <div className="flex items-start justify-between gap-4">
                    <div>
                      <p className="text-sm font-bold text-[#101114]">
                        {language.emoji ? `${language.emoji} ` : ''}
                        {language.name}
                      </p>
                      <p className="mt-1 text-xs text-[#566172]">{language.native_name}</p>
                    </div>
                    <Badge tone={languageTone(language.proficiency)}>
                      {language.proficiency}
                    </Badge>
                  </div>
                  <div className="mt-3 flex flex-wrap gap-2">
                    {language.is_primary ? <Badge tone="accent">Primary</Badge> : null}
                    {language.is_native ? <Badge tone="success">Native</Badge> : null}
                    {language.is_learning ? <Badge tone="neutral">Learning</Badge> : null}
                  </div>
                </div>
              ))
            ) : (
              <div className="rounded-2xl border-2 border-dashed border-[#dfe3ea] bg-[#f7f8fb] p-4 text-sm text-[#566172]">
                No public languages shared yet.
              </div>
            )}
          </div>

          <p className="pixel-label mt-8 text-[10px] text-[#566172]">Badges</p>
          <div className="mt-4 grid gap-3">
            {profile.badges.length > 0 ? (
              profile.badges.map((badge) => (
                <div
                  key={badge.badge_id}
                  className="rounded-2xl border-2 border-[#101114] bg-white p-4"
                >
                  <div className="flex items-start justify-between gap-4">
                    <div>
                      <p className="text-sm font-bold text-[#101114]">
                        {badge.icon ? `${badge.icon} ` : ''}
                        {badge.name}
                      </p>
                      <p className="mt-1 text-xs text-[#566172]">{badge.description}</p>
                    </div>
                    <Badge tone={badgeTone(badge.rarity)}>{badge.rarity}</Badge>
                  </div>
                  <p className="mt-3 text-[10px] uppercase tracking-[0.3em] text-[#566172]">
                    Awarded at {new Date(badge.awarded_at).toLocaleDateString('en-US')}
                  </p>
                </div>
              ))
            ) : (
              <div className="rounded-2xl border-2 border-dashed border-[#dfe3ea] bg-[#f7f8fb] p-4 text-sm text-[#566172]">
                No badges earned yet.
              </div>
            )}
          </div>

          <div className="mt-8 rounded-2xl border-2 border-[#101114] bg-[#101114] p-5 text-white">
            <p className="pixel-label text-[10px] text-[#c7f464]">Community summary</p>
            <div className="mt-4 grid grid-cols-2 gap-3">
              <div className="rounded-xl border border-white/10 bg-white/5 p-3">
                <p className="text-[10px] uppercase tracking-[0.3em] text-white/50">Translations</p>
                <p className="mt-2 text-2xl font-bold">{profile.translations_count}</p>
              </div>
              <div className="rounded-xl border border-white/10 bg-white/5 p-3">
                <p className="text-[10px] uppercase tracking-[0.3em] text-white/50">Reviews</p>
                <p className="mt-2 text-2xl font-bold">{profile.reviews_count}</p>
              </div>
              <div className="rounded-xl border border-white/10 bg-white/5 p-3">
                <p className="text-[10px] uppercase tracking-[0.3em] text-white/50">Languages</p>
                <p className="mt-2 text-2xl font-bold">{profile.languages_count}</p>
              </div>
              <div className="rounded-xl border border-white/10 bg-white/5 p-3">
                <p className="text-[10px] uppercase tracking-[0.3em] text-white/50">Badges</p>
                <p className="mt-2 text-2xl font-bold">{profile.badges_count}</p>
              </div>
            </div>
          </div>
        </Card>
      </div>
    </section>
  );
}
