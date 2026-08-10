import { supabase } from '@/services/supabase';
import type { Database } from '@/integrations/supabase/database.types';
import { normalizeLanguageProficiency } from '@/utils/languageCompatibility';

export type LanguageRow = Database['public']['Tables']['languages']['Row'];
export type UserLanguageRow = Database['public']['Tables']['user_languages']['Row'];
export type LanguageProficiency = Database['public']['Enums']['language_proficiency'];

export type LanguagePreferenceDraft = {
  id?: string;
  language_id: string;
  proficiency: LanguageProficiency;
  is_primary: boolean;
  notes: string;
};

export type LanguagePreferencesResult = {
  languages: LanguageRow[];
  preferences: LanguagePreferenceDraft[];
  rows: UserLanguageRow[];
};

function sortLanguages(a: LanguageRow, b: LanguageRow) {
  if (a.is_active !== b.is_active) {
    return Number(b.is_active) - Number(a.is_active);
  }

  if (a.sort_order !== b.sort_order) {
    return a.sort_order - b.sort_order;
  }

  return a.name.localeCompare(b.name);
}

export function createEmptyPreference(): LanguagePreferenceDraft {
  return {
    language_id: '',
    proficiency: 'intermediate',
    is_primary: false,
    notes: ''
  };
}

export function mapUserLanguageToDraft(row: UserLanguageRow): LanguagePreferenceDraft {
  return {
    id: row.id,
    language_id: row.language_id,
    proficiency: normalizeLanguageProficiency(row.proficiency),
    is_primary: row.is_primary,
    notes: row.notes ?? ''
  };
}

export function normalizeLanguagePreferences(
  preferences: LanguagePreferenceDraft[]
): LanguagePreferenceDraft[] {
  const seen = new Set<string>();

  const filtered = preferences
    .filter((item) => item.language_id.trim().length > 0)
    .map((item) => ({
      ...item,
      language_id: item.language_id.trim(),
      notes: item.notes.trim(),
      proficiency: normalizeLanguageProficiency(item.proficiency)
    }))
    .filter((item) => {
      if (seen.has(item.language_id)) {
        return false;
      }

      seen.add(item.language_id);
      return true;
    });

  const primaryIndex = filtered.findIndex((item) => item.is_primary);

  return filtered.map((item, index) => ({
    ...item,
    is_primary: primaryIndex >= 0 ? index === primaryIndex : index === 0
  }));
}

export async function loadLanguagePreferences(userId: string): Promise<LanguagePreferencesResult> {
  if (!supabase) {
    return {
      languages: [],
      preferences: [],
      rows: []
    };
  }

  const [languagesResult, preferencesResult] = await Promise.all([
    supabase
      .from('languages')
      .select('id, code, name, native_name, emoji, is_active, sort_order, direction, created_at, created_by, updated_at')
      .order('sort_order', { ascending: true })
      .order('name', { ascending: true }),
    supabase
      .from('user_languages')
      .select('*')
      .eq('user_id', userId)
      .order('is_primary', { ascending: false })
      .order('created_at', { ascending: true })
  ]);

  if (languagesResult.error) {
    throw new Error(languagesResult.error.message);
  }

  if (preferencesResult.error) {
    throw new Error(preferencesResult.error.message);
  }

  return {
    languages: (languagesResult.data ?? []).sort(sortLanguages),
    preferences: (preferencesResult.data ?? []).map(mapUserLanguageToDraft),
    rows: preferencesResult.data ?? []
  };
}

export async function saveLanguagePreferences(
  userId: string,
  preferences: LanguagePreferenceDraft[],
  existingRows: UserLanguageRow[] = []
): Promise<UserLanguageRow[]> {
  if (!supabase) {
    throw new Error('Supabase is not configured.');
  }

  const normalized = normalizeLanguagePreferences(preferences);
  const nextLanguageIds = new Set(normalized.map((item) => item.language_id));
  const rowsToDelete = existingRows
    .filter((row) => !nextLanguageIds.has(row.language_id))
    .map((row) => row.id);

  if (rowsToDelete.length > 0) {
    const deleteResult = await supabase.from('user_languages').delete().in('id', rowsToDelete);

    if (deleteResult.error) {
      throw new Error(deleteResult.error.message);
    }
  }

  if (normalized.length === 0) {
    return [];
  }

  const payload: Array<Database['public']['Tables']['user_languages']['Insert']> = normalized.map(
    (item) => ({
      user_id: userId,
      language_id: item.language_id,
      proficiency: item.proficiency,
      is_primary: item.is_primary,
      is_native: item.proficiency === 'native',
      is_learning: item.proficiency !== 'native',
      notes: item.notes || null
    })
  );

  const { error, data } = await supabase
    .from('user_languages')
    .upsert(payload, { onConflict: 'user_id,language_id' })
    .select('*');

  if (error) {
    throw new Error(error.message);
  }

  return data ?? [];
}

export function taskEligibilityCopy(proficiency: LanguageProficiency) {
  const normalized = normalizeLanguageProficiency(proficiency);

  if (normalized === 'native' || normalized === 'fluent') {
    return 'Translation + review';
  }

  if (normalized === 'intermediate') {
    return 'Translation only';
  }

  return 'Training only';
}
