import { supabase } from '@/services/supabase';
import type { Database } from '@/integrations/supabase/database.types';

type PublicStatusOverviewRow = Database['public']['Functions']['public_status_overview']['Returns'][number];
type PublicStatusLanguageRow = Database['public']['Functions']['public_status_language_coverage']['Returns'][number];

export type PublicStatusLanguage = PublicStatusLanguageRow;

export type PublicStatusSummary = {
  total_strings: number;
  total_languages: number;
  collaborators: number;
  total_translations: number;
  total_reviews: number;
  translated_percent: number;
  reviewed_percent: number;
  official_percent: number;
};

export type PublicStatusData = {
  summary: PublicStatusSummary;
  languages: PublicStatusLanguage[];
};

function clampPercent(value: number) {
  if (Number.isNaN(value) || !Number.isFinite(value)) {
    return 0;
  }

  return Math.max(0, Math.min(100, value));
}

function toNumber(value: string | number | null | undefined) {
  return Number(value ?? 0);
}

export async function fetchPublicStatusData(): Promise<PublicStatusData> {
  if (!supabase) {
    return {
      summary: {
        total_strings: 0,
        total_languages: 0,
        collaborators: 0,
        total_translations: 0,
        total_reviews: 0,
        translated_percent: 0,
        reviewed_percent: 0,
        official_percent: 0
      },
      languages: []
    };
  }

  const [overviewResult, languagesResult] = await Promise.all([
    supabase.rpc('public_status_overview'),
    supabase.rpc('public_status_language_coverage')
  ]);

  if (overviewResult.error) {
    throw new Error(overviewResult.error.message);
  }

  if (languagesResult.error) {
    throw new Error(languagesResult.error.message);
  }

  const overview = Array.isArray(overviewResult.data) ? (overviewResult.data[0] as PublicStatusOverviewRow | undefined) : undefined;
  const languages = (languagesResult.data ?? []).map((language) => ({
    ...language,
    translated_percent: Number(clampPercent(toNumber(language.translated_percent)).toFixed(2)),
    reviewed_percent: Number(clampPercent(toNumber(language.reviewed_percent)).toFixed(2)),
    official_percent: Number(clampPercent(toNumber(language.official_percent)).toFixed(2))
  }));

  return {
    summary: {
      total_strings: toNumber(overview?.total_strings),
      total_languages: toNumber(overview?.total_languages),
      collaborators: toNumber(overview?.collaborators),
      total_translations: toNumber(overview?.total_translations),
      total_reviews: toNumber(overview?.total_reviews),
      translated_percent: toNumber(overview?.translated_percent),
      reviewed_percent: toNumber(overview?.reviewed_percent),
      official_percent: toNumber(overview?.official_percent)
    },
    languages: languages.sort((a, b) => {
      const diff = b.official_percent - a.official_percent;
      if (diff !== 0) return diff;
      return b.translated_percent - a.translated_percent;
    })
  };
}
