import type { Database } from '@/integrations/supabase/database.types';

export type LanguageProficiency = Database['public']['Enums']['language_proficiency'];

const proficiencyRank: Record<LanguageProficiency, number> = {
  beginner: 0,
  intermediate: 1,
  fluent: 2,
  advanced: 2,
  native: 3
};

export const proficiencyLabels: Record<LanguageProficiency, string> = {
  beginner: 'Beginner',
  intermediate: 'Intermediate',
  fluent: 'Fluent',
  advanced: 'Fluent',
  native: 'Native'
};

export const proficiencyDescriptions: Record<LanguageProficiency, string> = {
  beginner: 'Training only',
  intermediate: 'Translation tasks',
  fluent: 'Translation and review',
  advanced: 'Translation and review',
  native: 'Translation and review'
};

export function normalizeLanguageProficiency(
  proficiency: LanguageProficiency
): Exclude<LanguageProficiency, 'advanced'> {
  return proficiency === 'advanced' ? 'fluent' : proficiency;
}

export function getLanguageWorkAccess(proficiency: LanguageProficiency) {
  const rank = proficiencyRank[normalizeLanguageProficiency(proficiency)];

  return {
    canTranslate: rank >= proficiencyRank.intermediate,
    canReview: rank >= proficiencyRank.fluent,
    label: proficiencyLabels[proficiency],
    description: proficiencyDescriptions[proficiency]
  };
}

export function formatLanguageLevel(proficiency: LanguageProficiency) {
  return proficiencyLabels[proficiency];
}
