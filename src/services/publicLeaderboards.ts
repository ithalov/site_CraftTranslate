import { supabase } from '@/services/supabase';
import type { Database, Json } from '@/integrations/supabase/database.types';

export type LeaderboardPeriod = 'all_time' | 'year' | 'month' | 'week';
export type LeaderboardKind = 'translators' | 'reviewers' | 'supporters';

type LeaderboardRow = Database['public']['Functions']['public_leaderboard_rankings']['Returns'][number];

export type PublicLeaderboardBadge = {
  badge_id: string;
  slug: string;
  name: string;
  description: string;
  rarity: string;
  icon: string | null;
  awarded_at: string;
};

export type PublicLeaderboardEntry = {
  leaderboard_kind: LeaderboardKind;
  period: LeaderboardPeriod;
  user_id: string;
  display_name: string | null;
  username: string | null;
  avatar_url: string | null;
  primary_language_code: string | null;
  primary_language_name: string | null;
  primary_language_native_name: string | null;
  primary_language_emoji: string | null;
  role: string;
  total_xp: number;
  reputation_score: number;
  contribution_points: number;
  translations_count: number;
  approved_suggestions_count: number;
  reviews_count: number;
  approved_reviews_count: number;
  badges_count: number;
  approval_rate: number;
  ranking_score: number;
  rank: number;
  badges: PublicLeaderboardBadge[];
};

export type PublicLeaderboardGroup = Record<LeaderboardKind, PublicLeaderboardEntry[]>;

const emptyGroups: PublicLeaderboardGroup = {
  translators: [],
  reviewers: [],
  supporters: []
};

function parseBadges(value: Json): PublicLeaderboardBadge[] {
  if (!Array.isArray(value)) {
    return [];
  }

  return value
    .map((item) => {
      if (item === null || typeof item !== 'object' || Array.isArray(item)) {
        return null;
      }

      const badge = item as Record<string, Json | undefined>;

      return {
        badge_id: String(badge.badge_id ?? ''),
        slug: String(badge.slug ?? ''),
        name: String(badge.name ?? ''),
        description: String(badge.description ?? ''),
        rarity: String(badge.rarity ?? 'common'),
        icon: badge.icon == null ? null : String(badge.icon),
        awarded_at: String(badge.awarded_at ?? '')
      } satisfies PublicLeaderboardBadge;
    })
    .filter((badge): badge is PublicLeaderboardBadge => badge !== null && badge.badge_id.length > 0);
}

function normalizeRow(row: LeaderboardRow): PublicLeaderboardEntry {
  return {
    leaderboard_kind: row.leaderboard_kind as LeaderboardKind,
    period: row.period as LeaderboardPeriod,
    user_id: row.user_id,
    display_name: row.display_name,
    username: row.username,
    avatar_url: row.avatar_url,
    primary_language_code: row.primary_language_code,
    primary_language_name: row.primary_language_name,
    primary_language_native_name: row.primary_language_native_name,
    primary_language_emoji: row.primary_language_emoji,
    role: row.role,
    total_xp: Number(row.total_xp ?? 0),
    reputation_score: Number(row.reputation_score ?? 0),
    contribution_points: Number(row.contribution_points ?? 0),
    translations_count: Number(row.translations_count ?? 0),
    approved_suggestions_count: Number(row.approved_suggestions_count ?? 0),
    reviews_count: Number(row.reviews_count ?? 0),
    approved_reviews_count: Number(row.approved_reviews_count ?? 0),
    badges_count: Number(row.badges_count ?? 0),
    approval_rate: Number(row.approval_rate ?? 0),
    ranking_score: Number(row.ranking_score ?? 0),
    rank: Number(row.rank ?? 0),
    badges: parseBadges(row.badges)
  };
}

export async function fetchPublicLeaderboards(period: LeaderboardPeriod): Promise<PublicLeaderboardGroup> {
  if (!supabase) {
    return emptyGroups;
  }

  const { data, error } = await supabase.rpc('public_leaderboard_rankings', {
    leaderboard_period: period
  });

  if (error) {
    throw new Error(error.message);
  }

  const rows = (Array.isArray(data) ? data : []).map(normalizeRow);

  return rows.reduce<PublicLeaderboardGroup>(
    (groups, row) => {
      if (row.leaderboard_kind in groups) {
        groups[row.leaderboard_kind].push(row);
      }

      return groups;
    },
    {
      translators: [],
      reviewers: [],
      supporters: []
    }
  );
}
