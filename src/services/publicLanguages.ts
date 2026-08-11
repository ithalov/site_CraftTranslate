import { supabase } from '@/services/supabase';
import type { Database, Json } from '@/integrations/supabase/database.types';

type PublicLanguageCatalogRow = Database['public']['Functions']['public_language_catalog']['Returns'][number];
type PublicLanguagePageRow = Database['public']['Functions']['public_language_page']['Returns'][number];
type PublicLanguageCategoryStatsRow = Database['public']['Functions']['public_language_category_stats']['Returns'][number];

export type PublicLanguageCatalogItem = PublicLanguageCatalogRow;

export type PublicLanguageMember = {
  user_id: string;
  display_name: string | null;
  username: string | null;
  avatar_url: string | null;
  bio: string | null;
  role: string;
  contribution_score: number;
  joined_at: string;
  proficiency: string;
  is_primary: boolean;
  is_native: boolean;
  is_learning: boolean;
};

export type PublicLanguageCategory = {
  slug: string;
  label: string;
  value: number;
  hint: string;
};

export type PublicLanguageCategoryProgress = {
  slug: string;
  label: string;
  total_strings: number;
  translated_count: number;
  reviewed_count: number;
  official_count: number;
  translated_percent: number;
  reviewed_percent: number;
  official_percent: number;
  has_open_work: boolean;
};

export type PublicLanguageTeamSection = {
  role: string;
  count: number;
  members: PublicLanguageMember[];
};

export type PublicLanguagePage = {
  language_id: string;
  code: string;
  name: string;
  native_name: string;
  emoji: string | null;
  direction: string;
  total_strings: number;
  translated_count: number;
  reviewed_count: number;
  official_count: number;
  translated_percent: number;
  reviewed_percent: number;
  official_percent: number;
  collaborators_count: number;
  active_translators: number;
  active_reviewers: number;
  active_moderators: number;
  translation_keys: number;
  translation_suggestions: number;
  approved_suggestions: number;
  glossary_terms: number;
  glossary_proposals: number;
  lead_member: PublicLanguageMember | null;
  category_progress: PublicLanguageCategoryProgress[];
  team_sections: PublicLanguageTeamSection[];
  reviewers: PublicLanguageMember[];
  team_members: PublicLanguageMember[];
  top_contributors: PublicLanguageMember[];
  categories: PublicLanguageCategory[];
};

function toNumber(value: unknown) {
  if (typeof value === 'number') {
    return value;
  }

  if (typeof value === 'string') {
    return Number(value);
  }

  return 0;
}

function clampPercent(value: number) {
  if (Number.isNaN(value) || !Number.isFinite(value)) {
    return 0;
  }

  return Math.max(0, Math.min(100, value));
}

function parseMember(value: Json): PublicLanguageMember | null {
  if (!value || typeof value !== 'object' || Array.isArray(value)) {
    return null;
  }

  const member = value as Record<string, Json | undefined>;

  return {
    user_id: String(member.user_id ?? ''),
    display_name: member.display_name == null ? null : String(member.display_name),
    username: member.username == null ? null : String(member.username),
    avatar_url: member.avatar_url == null ? null : String(member.avatar_url),
    bio: member.bio == null ? null : String(member.bio),
    role: String(member.role ?? 'member'),
    contribution_score: toNumber(member.contribution_score),
    joined_at: String(member.joined_at ?? ''),
    proficiency: String(member.proficiency ?? 'beginner'),
    is_primary: Boolean(member.is_primary),
    is_native: Boolean(member.is_native),
    is_learning: Boolean(member.is_learning)
  };
}

function parseMemberList(value: Json): PublicLanguageMember[] {
  if (!Array.isArray(value)) {
    return [];
  }

  return value.map(parseMember).filter((item): item is PublicLanguageMember => item !== null && item.user_id.length > 0);
}

function parseCategories(value: Json): PublicLanguageCategory[] {
  if (!Array.isArray(value)) {
    return [];
  }

  return value
    .map((item) => {
      if (!item || typeof item !== 'object' || Array.isArray(item)) {
        return null;
      }

      const category = item as Record<string, Json | undefined>;

      return {
        slug: String(category.slug ?? ''),
        label: String(category.label ?? ''),
        value: toNumber(category.value),
        hint: String(category.hint ?? '')
      } satisfies PublicLanguageCategory;
    })
    .filter((item): item is PublicLanguageCategory => item !== null && item.slug.length > 0);
}

function parseCategoryProgress(value: Json): PublicLanguageCategoryProgress[] {
  if (!Array.isArray(value)) {
    return [];
  }

  return value
    .map((item) => {
      if (!item || typeof item !== 'object' || Array.isArray(item)) {
        return null;
      }

      const category = item as Record<string, Json | undefined>;

      return {
        slug: String(category.slug ?? ''),
        label: String(category.label ?? ''),
        total_strings: toNumber(category.total_strings),
        translated_count: toNumber(category.translated_count),
        reviewed_count: toNumber(category.reviewed_count),
        official_count: toNumber(category.official_count),
        translated_percent: Number(clampPercent(toNumber(category.translated_percent)).toFixed(2)),
        reviewed_percent: Number(clampPercent(toNumber(category.reviewed_percent)).toFixed(2)),
        official_percent: Number(clampPercent(toNumber(category.official_percent)).toFixed(2)),
        has_open_work: Boolean(category.has_open_work)
      } satisfies PublicLanguageCategoryProgress;
    })
    .filter((item): item is PublicLanguageCategoryProgress => item !== null && item.slug.length > 0);
}

function parseTeamSections(value: Json): PublicLanguageTeamSection[] {
  if (!Array.isArray(value)) {
    return [];
  }

  return value
    .map((item) => {
      if (!item || typeof item !== 'object' || Array.isArray(item)) {
        return null;
      }

      const section = item as Record<string, Json | undefined>;

      return {
        role: String(section.role ?? 'member'),
        count: toNumber(section.count),
        members: parseMemberList(section.members ?? null)
      } satisfies PublicLanguageTeamSection;
    })
    .filter((item): item is PublicLanguageTeamSection => item !== null && item.role.length > 0);
}

function normalizeCatalogRow(row: PublicLanguageCatalogRow): PublicLanguageCatalogItem {
  return {
    ...row,
    total_strings: toNumber(row.total_strings),
    translated_count: toNumber(row.translated_count),
    reviewed_count: toNumber(row.reviewed_count),
    official_count: toNumber(row.official_count),
    translated_percent: Number(clampPercent(toNumber(row.translated_percent)).toFixed(2)),
    reviewed_percent: Number(clampPercent(toNumber(row.reviewed_percent)).toFixed(2)),
    official_percent: Number(clampPercent(toNumber(row.official_percent)).toFixed(2)),
    collaborators_count: toNumber(row.collaborators_count),
    active_translators: toNumber(row.active_translators),
    active_reviewers: toNumber(row.active_reviewers),
    active_moderators: toNumber(row.active_moderators),
    translation_keys: toNumber(row.translation_keys),
    translation_suggestions: toNumber(row.translation_suggestions),
    approved_suggestions: toNumber(row.approved_suggestions),
    glossary_terms: toNumber(row.glossary_terms),
    glossary_proposals: toNumber(row.glossary_proposals)
  };
}

function normalizePageRow(row: PublicLanguagePageRow): PublicLanguagePage {
  return {
    language_id: row.language_id,
    code: row.code,
    name: row.name,
    native_name: row.native_name,
    emoji: row.emoji,
    direction: row.direction,
    total_strings: toNumber(row.total_strings),
    translated_count: toNumber(row.translated_count),
    reviewed_count: toNumber(row.reviewed_count),
    official_count: toNumber(row.official_count),
    translated_percent: Number(clampPercent(toNumber(row.translated_percent)).toFixed(2)),
    reviewed_percent: Number(clampPercent(toNumber(row.reviewed_percent)).toFixed(2)),
    official_percent: Number(clampPercent(toNumber(row.official_percent)).toFixed(2)),
    collaborators_count: toNumber(row.collaborators_count),
    active_translators: toNumber(row.active_translators),
    active_reviewers: toNumber(row.active_reviewers),
    active_moderators: toNumber(row.active_moderators),
    translation_keys: toNumber(row.translation_keys),
    translation_suggestions: toNumber(row.translation_suggestions),
    approved_suggestions: toNumber(row.approved_suggestions),
    glossary_terms: toNumber(row.glossary_terms),
    glossary_proposals: toNumber(row.glossary_proposals),
    lead_member: parseMember(row.lead_member),
    category_progress: parseCategoryProgress(row.category_progress),
    team_sections: parseTeamSections(row.team_sections),
    reviewers: parseMemberList(row.reviewers),
    team_members: parseMemberList(row.team_members),
    top_contributors: parseMemberList(row.top_contributors),
    categories: parseCategories(row.categories)
  };
}

export async function fetchPublicLanguageCatalog(): Promise<PublicLanguageCatalogItem[]> {
  if (!supabase) {
    return [];
  }

  const { data, error } = await supabase.rpc('public_language_catalog');

  if (error) {
    throw new Error(error.message);
  }

  return (Array.isArray(data) ? data : []).map(normalizeCatalogRow);
}

export async function fetchPublicLanguagePage(code: string): Promise<PublicLanguagePage | null> {
  if (!supabase) {
    return null;
  }

  const [pageResult, categoryResult] = await Promise.all([
    supabase.rpc('public_language_page', { language_code: code }),
    supabase.rpc('public_language_category_stats', { p_language_code: code })
  ]);

  if (pageResult.error) {
    throw new Error(pageResult.error.message);
  }

  if (categoryResult.error) {
    throw new Error(categoryResult.error.message);
  }

  const row = Array.isArray(pageResult.data) ? pageResult.data[0] : null;

  if (!row) {
    return null;
  }

  const page = normalizePageRow(row);
  const categoryProgress = (categoryResult.data ?? []).map((category: PublicLanguageCategoryStatsRow) => ({
    slug: category.slug,
    label: category.label,
    total_strings: toNumber(category.total_strings),
    translated_count: toNumber(category.translated_count),
    reviewed_count: toNumber(category.reviewed_count),
    official_count: toNumber(category.official_count),
    translated_percent: Number(clampPercent(toNumber(category.translated_percent)).toFixed(2)),
    reviewed_percent: Number(clampPercent(toNumber(category.reviewed_percent)).toFixed(2)),
    official_percent: Number(clampPercent(toNumber(category.official_percent)).toFixed(2)),
    has_open_work: Boolean(category.has_open_work)
  }));

  return { ...page, category_progress: categoryProgress };
}
