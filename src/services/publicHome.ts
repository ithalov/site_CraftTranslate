import { supabase } from '@/services/supabase';
import type { Database } from '@/integrations/supabase/database.types';

type PublicProfileCard = Database['public']['Views']['public_profile_cards_view']['Row'];

export type HomeCommunityStats = {
  contributors: number;
  totalTranslations: number;
  totalReviews: number;
  totalBadges: number;
  activeLanguages: number;
  averageProgress: number;
  approvedSuggestions: number;
};

export type HomeLeaderboardItem = PublicProfileCard;
export type HomeLanguageProgressItem = {
  language_id: string;
  code: string;
  name: string;
  native_name: string;
  emoji: string | null;
  progress_percent: number;
  approved_suggestions: number;
  active_translators: number;
};

export type HomePublicData = {
  stats: HomeCommunityStats;
  languages: HomeLanguageProgressItem[];
  translators: HomeLeaderboardItem[];
  reviewers: HomeLeaderboardItem[];
  supporters: HomeLeaderboardItem[];
};

function sortByNumber<T extends Record<string, unknown>>(rows: T[], field: keyof T) {
  return [...rows].sort((a, b) => Number(b[field] ?? 0) - Number(a[field] ?? 0));
}

function average(values: number[]) {
  if (values.length === 0) {
    return 0;
  }

  const total = values.reduce((sum, value) => sum + value, 0);
  return total / values.length;
}

export async function fetchHomePublicData(): Promise<HomePublicData> {
  if (!supabase) {
    return {
      stats: {
        contributors: 0,
        totalTranslations: 0,
        totalReviews: 0,
        totalBadges: 0,
        activeLanguages: 0,
        averageProgress: 0,
        approvedSuggestions: 0
      },
      languages: [],
      translators: [],
      reviewers: [],
      supporters: []
    };
  }

  const [profilesResult, overviewResult, languagesResult] = await Promise.all([
    supabase.from('public_profile_cards_view').select('*'),
    supabase.rpc('public_status_overview'),
    supabase.rpc('public_status_language_coverage')
  ]);

  if (profilesResult.error) {
    throw new Error(profilesResult.error.message);
  }

  if (overviewResult.error || languagesResult.error) {
    throw new Error(overviewResult.error?.message ?? languagesResult.error?.message ?? 'Unable to load translation statistics.');
  }

  const profiles = profilesResult.data ?? [];
  const overview = overviewResult.data?.[0];
  const languages: HomeLanguageProgressItem[] = (languagesResult.data ?? []).map((language) => ({
    language_id: language.language_id,
    code: language.code,
    name: language.name,
    native_name: language.native_name,
    emoji: language.emoji,
    progress_percent: Number(language.translated_percent ?? 0),
    approved_suggestions: Number(language.official_count ?? 0),
    active_translators: Number(language.active_translators ?? 0)
  }));
  const translators = sortByNumber(
    profiles.filter((profile) => Number(profile.translations_count ?? 0) > 0),
    'translations_count'
  ).slice(0, 4);
  const reviewers = sortByNumber(
    profiles.filter((profile) => Number(profile.reviews_count ?? 0) > 0),
    'reviews_count'
  ).slice(0, 4);
  const supporters = sortByNumber(
    profiles.filter((profile) => Number(profile.badges_count ?? 0) > 0),
    'badges_count'
  ).slice(0, 4);
  const totalBadges = profiles.reduce((sum, profile) => sum + Number(profile.badges_count ?? 0), 0);

  return {
    stats: {
      contributors: Number(overview?.collaborators ?? 0),
      totalTranslations: Number(overview?.total_translations ?? 0),
      totalReviews: Number(overview?.total_reviews ?? 0),
      totalBadges,
      activeLanguages: Number(overview?.total_languages ?? languages.length),
      averageProgress: Math.round(average(languages.map((language) => language.progress_percent))),
      approvedSuggestions: languages.reduce((sum, language) => sum + language.approved_suggestions, 0)
    },
    languages: sortByNumber(languages, 'progress_percent').slice(0, 6),
    translators,
    reviewers,
    supporters
  };
}
