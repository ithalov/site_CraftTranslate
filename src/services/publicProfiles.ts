import { supabase } from '@/services/supabase';

export type PublicProfileLanguage = {
  language_id: string;
  code: string;
  name: string;
  native_name: string;
  emoji: string | null;
  proficiency: 'beginner' | 'intermediate' | 'fluent' | 'advanced' | 'native';
  is_primary: boolean;
  is_native: boolean;
  is_learning: boolean;
};

export type PublicProfileBadge = {
  badge_id: string;
  slug: string;
  name: string;
  description: string;
  rarity: string;
  icon: string | null;
  awarded_at: string;
};

export type PublicProfilePage = {
  user_id: string;
  display_name: string | null;
  username: string | null;
  avatar_url: string | null;
  bio: string | null;
  role: string;
  preferred_locale: string;
  total_xp: number;
  reputation_score: number;
  contribution_points: number;
  approval_rate: number;
  badges_count: number;
  languages_count: number;
  translations_count: number;
  reviews_count: number;
  rank: number;
  profile_state: string;
  profile_level: number;
  functions: string[];
  languages: PublicProfileLanguage[];
  badges: PublicProfileBadge[];
};

function asStringArray(value: unknown): string[] {
  if (!Array.isArray(value)) {
    return [];
  }

  return value.filter((item): item is string => typeof item === 'string');
}

export async function fetchPublicProfilePage(profileHandle: string) {
  if (!supabase) {
    throw new Error('Supabase is not configured.');
  }

  const { data, error } = await supabase.rpc('public_profile_page', {
    profile_handle: profileHandle
  });

  if (error) {
    throw new Error(error.message);
  }

  const row = Array.isArray(data) ? data[0] : null;

  if (!row) {
    return null;
  }

  return {
    ...row,
    total_xp: Number(row.total_xp ?? 0),
    reputation_score: Number(row.reputation_score ?? 0),
    contribution_points: Number(row.contribution_points ?? 0),
    approval_rate: Number(row.approval_rate ?? 0),
    badges_count: Number(row.badges_count ?? 0),
    languages_count: Number(row.languages_count ?? 0),
    translations_count: Number(row.translations_count ?? 0),
    reviews_count: Number(row.reviews_count ?? 0),
    rank: Number(row.rank ?? 0),
    profile_level: Number(row.profile_level ?? 1),
    functions: asStringArray(row.functions),
    languages: Array.isArray(row.languages) ? row.languages : [],
    badges: Array.isArray(row.badges) ? row.badges : []
  } as PublicProfilePage;
}
