import { supabase } from '@/services/supabase';
import type { Database } from '@/integrations/supabase/database.types';

type PublicProfileCard = Database['public']['Views']['public_profile_cards_view']['Row'];
type PublicLanguageProgress = Database['public']['Views']['public_language_progress_view']['Row'];

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
export type HomeLanguageProgressItem = PublicLanguageProgress;

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

  const [profilesResult, languagesResult] = await Promise.all([
    supabase.from('public_profile_cards_view').select('*'),
    supabase.from('public_language_progress_view').select('*')
  ]);

  if (profilesResult.error) {
    throw new Error(profilesResult.error.message);
  }

  if (languagesResult.error) {
    throw new Error(languagesResult.error.message);
  }

  const profiles = profilesResult.data ?? [];
  const languages = languagesResult.data ?? [];
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
  const totals = profiles.reduce(
    (acc, profile) => ({
      contributors: acc.contributors + 1,
      totalTranslations: acc.totalTranslations + Number(profile.translations_count ?? 0),
      totalReviews: acc.totalReviews + Number(profile.reviews_count ?? 0),
      totalBadges: acc.totalBadges + Number(profile.badges_count ?? 0)
    }),
    {
      contributors: 0,
      totalTranslations: 0,
      totalReviews: 0,
      totalBadges: 0
    }
  );

  return {
    stats: {
      ...totals,
      activeLanguages: languages.length,
      averageProgress: Math.round(average(languages.map((language) => Number(language.progress_percent ?? 0)))),
      approvedSuggestions: languages.reduce(
        (sum, language) => sum + Number(language.approved_suggestions ?? 0),
        0
      )
    },
    languages: sortByNumber(languages, 'progress_percent').slice(0, 6),
    translators,
    reviewers,
    supporters
  };
}
