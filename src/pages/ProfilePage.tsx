import { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { Card } from '@/components/ui/Card';
import { Badge } from '@/components/ui/Badge';
import { MetricCard } from '@/components/ui/MetricCard';
import { RouteLoadingScreen } from '@/components/layout/RouteLoadingScreen';
import { LanguagePreferencesEditor } from '@/components/profile/LanguagePreferencesEditor';
import { useAuth } from '@/hooks/useAuth';
import { supabase } from '@/services/supabase';
import type { Database } from '@/integrations/supabase/database.types';
import { buildPublicProfileHandle } from '@/utils/profilePaths';
import { paths } from '@/navigation/paths';
import { subscribeToTranslationDataRefresh } from '@/services/translations/translationRefresh';

type ProfileRow = Database['public']['Tables']['profiles']['Row'];
type ProfileSummary = Database['public']['Views']['public_profile_cards_view']['Row'];
type ContributionRow = Database['public']['Functions']['my_translation_contributions']['Returns'][number];

export function ProfilePage() {
  const { user } = useAuth();
  const [profile, setProfile] = useState<ProfileRow | null>(null);
  const [summary, setSummary] = useState<ProfileSummary | null>(null);
  const [contributions, setContributions] = useState<ContributionRow[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let active = true;

    async function loadProfile() {
      if (!supabase || !user) {
        setLoading(false);
        return;
      }

      setLoading(true);
      setError(null);

      const [profileResult, summaryResult, contributionsResult] = await Promise.all([
        supabase.from('profiles').select('*').eq('user_id', user.id).maybeSingle(),
        supabase.from('public_profile_cards_view').select('*').eq('user_id', user.id).maybeSingle(),
        supabase.rpc('my_translation_contributions', { p_limit: 12 })
      ]);

      if (!active) {
        return;
      }

      if (profileResult.error) {
        setError(profileResult.error.message);
      } else {
        setProfile(profileResult.data ?? null);
      }

      if (summaryResult.error) {
        setError(summaryResult.error.message);
      } else {
        setSummary(summaryResult.data ?? null);
      }

      if (contributionsResult.error) {
        setError(contributionsResult.error.message);
      } else {
        setContributions(contributionsResult.data ?? []);
      }

      setLoading(false);
    }

    void loadProfile();
    const unsubscribe = subscribeToTranslationDataRefresh(() => {
      void loadProfile();
    });

    return () => {
      active = false;
      unsubscribe();
    };
  }, [user]);

  if (loading) {
    return <RouteLoadingScreen />;
  }

  if (error) {
    return (
      <div className="grid min-h-[60vh] place-items-center px-6">
        <Card className="w-full max-w-xl p-8 text-center">
          <p className="pixel-label text-[10px] text-[#566172]">Profile</p>
          <h2 className="minecraft-title mt-3 text-4xl text-[#101114]">Unable to load profile</h2>
          <p className="mt-4 text-sm leading-7 text-[#566172]">{error}</p>
        </Card>
      </div>
    );
  }

  if (!profile) {
    return (
      <div className="grid min-h-[60vh] place-items-center px-6">
        <Card className="w-full max-w-xl p-8 text-center">
          <p className="pixel-label text-[10px] text-[#566172]">Profile</p>
          <h2 className="minecraft-title mt-3 text-4xl text-[#101114]">Profile not found</h2>
          <p className="mt-4 text-sm leading-7 text-[#566172]">
            The account has not finished creating a profile yet.
          </p>
        </Card>
      </div>
    );
  }

  if (!user) {
    return <RouteLoadingScreen />;
  }

  const displayName = profile.display_name ?? profile.username ?? 'Unnamed player';
  const avatar =
    profile.avatar_url ?? user?.user_metadata?.avatar_url ?? user?.user_metadata?.picture ?? '';
  const publicHandle = buildPublicProfileHandle(profile.username, profile.display_name, profile.user_id);
  const publicProfilePath = publicHandle ? paths.publicProfile.replace(':handle', publicHandle) : '';

  return (
    <section className="grid gap-6">
      <Card className="overflow-hidden p-0">
        <div className="bg-[#101114] px-8 py-8 text-white md:px-10">
          <p className="pixel-label text-[10px] text-[#c7f464]">Profile</p>
          <div className="mt-4 flex flex-col gap-6 md:flex-row md:items-center md:justify-between">
            <div className="flex items-center gap-4">
              <div className="flex h-16 w-16 items-center justify-center overflow-hidden rounded-2xl border-2 border-[#c7f464] bg-[#1a1d24]">
                {avatar ? (
                  <img src={avatar} alt={displayName} className="h-full w-full object-cover" />
                ) : (
                  <span className="minecraft-title text-2xl text-[#c7f464]">
                    {displayName.slice(0, 1).toUpperCase()}
                  </span>
                )}
              </div>
              <div>
                <h1 className="minecraft-title text-4xl leading-none md:text-5xl">{displayName}</h1>
                <p className="mt-2 text-sm text-white/70">
                  {profile.discord_id ? `Discord ID ${profile.discord_id}` : 'Discord account connected'}
                </p>
              </div>
            </div>
            <div className="flex flex-wrap gap-2">
              <Badge tone="accent">{profile.role}</Badge>
              <Badge tone="success">{profile.preferred_locale}</Badge>
              {summary ? <Badge tone="neutral">Rank #{summary.rank}</Badge> : null}
            </div>
          </div>
        </div>

        <div className="grid gap-4 p-6 md:grid-cols-2 xl:grid-cols-4 md:p-8">
          <MetricCard label="XP" value={String(summary?.total_xp ?? 0)} hint="profile total" />
          <MetricCard
            label="Reputation"
            value={String(summary?.reputation_score ?? 0)}
            hint="community score"
          />
          <MetricCard label="Badges" value={String(summary?.badges_count ?? 0)} hint="earned" />
          <MetricCard
            label="Languages"
            value={String(summary?.languages_count ?? 0)}
            hint="active"
          />
        </div>
      </Card>

      <div className="grid gap-6 xl:grid-cols-[1.1fr_0.9fr]">
        <Card className="p-6 md:p-8">
          <p className="pixel-label text-[10px] text-[#566172]">Identity</p>
          <div className="mt-4 grid gap-4 md:grid-cols-2">
            <div className="rounded-md border-2 border-[#101114] bg-white p-4">
              <p className="text-[10px] uppercase tracking-[0.3em] text-[#566172]">Username</p>
              <p className="mt-2 text-base font-bold text-[#101114]">
                {profile.username ?? 'Not set'}
              </p>
            </div>
            <div className="rounded-md border-2 border-[#101114] bg-white p-4">
              <p className="text-[10px] uppercase tracking-[0.3em] text-[#566172]">Created at</p>
              <p className="mt-2 text-base font-bold text-[#101114]">
                {new Date(profile.created_at).toLocaleDateString('en-US', {
                  year: 'numeric',
                  month: 'short',
                  day: '2-digit'
                })}
              </p>
            </div>
            <div className="rounded-md border-2 border-[#101114] bg-white p-4">
              <p className="text-[10px] uppercase tracking-[0.3em] text-[#566172]">Discord ID</p>
              <p className="mt-2 break-all text-base font-bold text-[#101114]">
                {profile.discord_id ?? 'Not yet available'}
              </p>
            </div>
            <div className="rounded-md border-2 border-[#101114] bg-white p-4">
              <p className="text-[10px] uppercase tracking-[0.3em] text-[#566172]">Bio</p>
              <p className="mt-2 text-base font-bold text-[#101114]">
                {profile.bio ?? 'No bio yet'}
              </p>
            </div>
          </div>
        </Card>

        <Card className="p-6 md:p-8">
          <p className="pixel-label text-[10px] text-[#566172]">Progress</p>
          <div className="mt-4 space-y-4">
            <div className="rounded-md border-2 border-[#101114] bg-white p-4">
              <p className="text-sm font-bold text-[#101114]">Translations</p>
              <p className="mt-2 text-sm leading-6 text-[#566172]">
                {summary?.translations_count ?? 0} authored translations are visible in the public
                ranking.
              </p>
            </div>
            <div className="rounded-md border-2 border-[#101114] bg-white p-4">
              <p className="text-sm font-bold text-[#101114]">Reviews</p>
              <p className="mt-2 text-sm leading-6 text-[#566172]">
                {summary?.reviews_count ?? 0} reviews completed on the account.
              </p>
            </div>
            <div className="rounded-md border-2 border-[#101114] bg-white p-4">
              <p className="text-sm font-bold text-[#101114]">Locale</p>
              <p className="mt-2 text-sm leading-6 text-[#566172]">
                Primary locale set to {profile.preferred_locale}.
              </p>
            </div>
          </div>
        </Card>

        <Card className="p-6 md:p-8">
          <p className="pixel-label text-[10px] text-[#566172]">Public profile</p>
          <h2 className="minecraft-title mt-3 text-3xl text-[#101114]">Share your profile</h2>
          <p className="mt-3 text-sm leading-7 text-[#566172]">
            This is the public page other collaborators can open without seeing private account data.
          </p>
          <div className="mt-4 rounded-xl border-2 border-[#101114] bg-[#f7f8fb] p-4">
            <p className="text-[10px] uppercase tracking-[0.3em] text-[#566172]">Public URL</p>
            <p className="mt-2 break-all text-sm font-semibold text-[#101114]">
              {publicProfilePath || 'Not available'}
            </p>
          </div>
          {publicProfilePath ? (
            <Link
              to={publicProfilePath}
              className="block-button mt-5 inline-flex items-center justify-center px-5 py-3 text-sm"
            >
              Open public profile
            </Link>
          ) : null}
        </Card>
      </div>

      <Card className="p-6 md:p-8">
        <p className="pixel-label text-[10px] text-[#566172]">My contributions</p>
        <h2 className="minecraft-title mt-3 text-3xl text-[#101114]">Saved in Supabase</h2>
        <p className="mt-2 text-sm leading-7 text-[#566172]">
          Every entry below is a persisted suggestion, with its real review status and version.
        </p>
        <div className="mt-5 grid gap-3">
          {contributions.length ? contributions.map((contribution) => (
            <article key={contribution.suggestion_id} className="rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-4">
              <div className="flex flex-wrap items-center justify-between gap-3">
                <p className="font-[var(--font-display)] text-sm font-bold text-[#101114]">{contribution.key_name}</p>
                <Badge tone={contribution.status === 'official' ? 'success' : contribution.status === 'approved' ? 'accent' : 'neutral'}>
                  {contribution.status}
                </Badge>
              </div>
              <p className="mt-3 text-sm text-[#566172]">EN: {contribution.source_text}</p>
              <p className="mt-1 text-sm font-bold text-[#101114]">{contribution.target_language_code}: {contribution.translated_text}</p>
              <p className="mt-3 text-xs text-[#566172]">Source v{contribution.source_version} · Suggestion v{contribution.version_number}</p>
            </article>
          )) : (
            <p className="rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-4 text-sm text-[#566172]">
              Your persisted translations will appear here after a successful submission.
            </p>
          )}
        </div>
      </Card>

      <LanguagePreferencesEditor userId={user.id} mode="profile" />
    </section>
  );
}
