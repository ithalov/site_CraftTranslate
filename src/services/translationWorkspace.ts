import { supabase } from '@/services/supabase';
import { notifyTranslationDataRefresh } from '@/services/translations/translationRefresh';
import type { Database, Json } from '@/integrations/supabase/database.types';

type TranslationWorkspaceSessionRow = Database['public']['Functions']['translation_workspace_session']['Returns'][number];
type PublicLanguageGlossaryRow = Database['public']['Functions']['public_language_glossary']['Returns'][number];

export type TranslationWorkspaceSuggestion = {
  suggestion_id: string;
  version_number: number;
  status: string;
  suggestion_text: string;
  author_id?: string | null;
  author_name?: string | null;
  author_username?: string | null;
  created_at?: string | null;
  rationale?: string | null;
  notes?: string | null;
  updated_at?: string | null;
};

export type TranslationWorkspaceGlossaryTerm = {
  id: string;
  term: string;
  original_term: string;
  recommended_translation: string;
  category: string;
  subcategory: string | null;
  rule: string | null;
  notes: string | null;
  do_not_translate: boolean;
  aliases: string[];
  tags: string[];
  match_reason: string;
};

export type TranslationWorkspaceItem = {
  translation_key_id: string;
  key_name: string;
  original_text: string;
  category: string;
  subcategory: string | null;
  context: string | null;
  protected_variables: string[];
  protected_terms: string[];
  source_language_id: string;
  source_language_code: string;
  source_language_name: string;
  source_language_native_name: string;
  source_language_emoji: string | null;
  target_language_id: string;
  target_language_code: string;
  target_language_name: string;
  target_language_native_name: string;
  target_language_emoji: string | null;
  auto_suggestion: TranslationWorkspaceSuggestion | null;
  my_suggestion: TranslationWorkspaceSuggestion | null;
  glossary_terms: TranslationWorkspaceGlossaryTerm[];
};

export type TranslationWorkspaceDuplicateSuggestion = {
  suggestion_id: string;
  version_number: number;
  status: string;
  suggestion_text: string;
  author_id: string | null;
  author_name: string | null;
  author_username: string | null;
  created_at: string | null;
  match_kind: string;
};

export type TranslationWorkspacePlaceholderValidation = {
  valid: boolean;
  required: string[];
  missing: string[];
  extra: string[];
};

export type TranslationWorkspaceProtectedTermsValidation = {
  valid: boolean;
  required: string[];
  missing: string[];
  modified: string[];
};

export type TranslationWorkspaceSession = {
  session_id: string;
  target_language_id: string;
  target_language_code: string;
  target_language_name: string;
  target_language_native_name: string;
  target_language_emoji: string | null;
  category_slug: string;
  total_available: number;
  loaded_count: number;
  batch_size: number;
  session_offset: number;
  has_more: boolean;
  items: TranslationWorkspaceItem[];
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

function toStringArray(value: unknown) {
  if (!Array.isArray(value)) {
    return [];
  }

  return value.map((item) => String(item));
}

function normalizeSearchText(value: string) {
  return value
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/\s+/g, ' ')
    .trim();
}

function parseSuggestion(value: Json): TranslationWorkspaceSuggestion | null {
  if (!value || typeof value !== 'object' || Array.isArray(value)) {
    return null;
  }

  const suggestion = value as Record<string, Json | undefined>;

  return {
    suggestion_id: String(suggestion.suggestion_id ?? ''),
    version_number: toNumber(suggestion.version_number),
    status: String(suggestion.status ?? 'draft'),
    suggestion_text: String(suggestion.suggestion_text ?? ''),
    author_id: suggestion.author_id == null ? null : String(suggestion.author_id),
    author_name: suggestion.author_name == null ? null : String(suggestion.author_name),
    author_username: suggestion.author_username == null ? null : String(suggestion.author_username),
    created_at: suggestion.created_at == null ? null : String(suggestion.created_at),
    rationale: suggestion.rationale == null ? null : String(suggestion.rationale),
    notes: suggestion.notes == null ? null : String(suggestion.notes),
    updated_at: suggestion.updated_at == null ? null : String(suggestion.updated_at)
  };
}

function parseGlossaryTerms(value: Json): TranslationWorkspaceGlossaryTerm[] {
  if (!Array.isArray(value)) {
    return [];
  }

  return value
    .map((item) => {
      if (!item || typeof item !== 'object' || Array.isArray(item)) {
        return null;
      }

      const term = item as Record<string, Json | undefined>;

      return {
        id: String(term.id ?? ''),
        term: String(term.term ?? ''),
        original_term: String(term.original_term ?? term.term ?? ''),
        recommended_translation: String(term.recommended_translation ?? term.definition ?? ''),
        category: String(term.category ?? ''),
        subcategory: term.subcategory == null ? null : String(term.subcategory),
        rule: term.rule == null ? null : String(term.rule),
        notes: term.notes == null ? null : String(term.notes),
        do_not_translate: Boolean(term.do_not_translate),
        aliases: toStringArray(term.aliases),
        tags: toStringArray(term.tags),
        match_reason: String(term.match_reason ?? '')
      } satisfies TranslationWorkspaceGlossaryTerm;
    })
    .filter((item): item is TranslationWorkspaceGlossaryTerm => item !== null && item.id.length > 0);
}

function matchGlossaryTerms(
  sourceText: string,
  glossaryTerms: TranslationWorkspaceGlossaryTerm[]
): TranslationWorkspaceGlossaryTerm[] {
  const rawHaystack = sourceText.toLowerCase();
  const normalizedHaystack = normalizeSearchText(sourceText);

  return glossaryTerms
    .map((term) => {
      const candidates = [
        term.original_term,
        term.term,
        ...term.aliases,
        ...term.tags
      ]
        .map((candidate) => candidate.trim())
        .filter((candidate) => candidate.length > 0);

      const matchedCandidates = candidates.filter((candidate) => {
        const rawCandidate = candidate.toLowerCase();
        const normalizedCandidate = normalizeSearchText(candidate);

        return (
          rawHaystack.includes(rawCandidate) ||
          normalizedHaystack.includes(normalizedCandidate)
        );
      });

      if (matchedCandidates.length === 0) {
        return null;
      }

      return {
        ...term,
        match_reason: term.do_not_translate
          ? 'protected'
          : matchedCandidates.some((candidate) => normalizeSearchText(candidate) === normalizeSearchText(term.original_term))
            ? 'original_term'
            : 'alias'
      };
    })
    .filter((item): item is TranslationWorkspaceGlossaryTerm => item !== null);
}

function attachRelevantGlossaryTerms(
  item: TranslationWorkspaceItem,
  glossaryTerms: TranslationWorkspaceGlossaryTerm[]
) {
  const sourceText = [
    item.original_text,
    item.key_name,
    item.context ?? '',
    item.protected_variables.join(' '),
    item.protected_terms.join(' ')
  ]
    .filter((entry) => entry.trim().length > 0)
    .join(' ');

  const matchedTerms = matchGlossaryTerms(sourceText, glossaryTerms);

  return matchedTerms.length > 0 ? matchedTerms : item.glossary_terms;
}

function parseItem(value: Json): TranslationWorkspaceItem | null {
  if (!value || typeof value !== 'object' || Array.isArray(value)) {
    return null;
  }

  const item = value as Record<string, Json | undefined>;

  return {
    translation_key_id: String(item.translation_key_id ?? ''),
    key_name: String(item.key_name ?? ''),
    original_text: String(item.original_text ?? ''),
    category: String(item.category ?? ''),
    subcategory: item.subcategory == null ? null : String(item.subcategory),
    context: item.context == null ? null : String(item.context),
    protected_variables: toStringArray(item.protected_variables),
    protected_terms: toStringArray(item.protected_terms),
    source_language_id: String(item.source_language_id ?? ''),
    source_language_code: String(item.source_language_code ?? ''),
    source_language_name: String(item.source_language_name ?? ''),
    source_language_native_name: String(item.source_language_native_name ?? ''),
    source_language_emoji: item.source_language_emoji == null ? null : String(item.source_language_emoji),
    target_language_id: String(item.target_language_id ?? ''),
    target_language_code: String(item.target_language_code ?? ''),
    target_language_name: String(item.target_language_name ?? ''),
    target_language_native_name: String(item.target_language_native_name ?? ''),
    target_language_emoji: item.target_language_emoji == null ? null : String(item.target_language_emoji),
    auto_suggestion: parseSuggestion(item.auto_suggestion ?? null),
    my_suggestion: parseSuggestion(item.my_suggestion ?? null),
    glossary_terms: parseGlossaryTerms(item.glossary_terms ?? null)
  };
}

function parseItems(value: Json): TranslationWorkspaceItem[] {
  if (!Array.isArray(value)) {
    return [];
  }

  return value.map(parseItem).filter((item): item is TranslationWorkspaceItem => item !== null && item.translation_key_id.length > 0);
}

function normalizeGlossaryRow(row: PublicLanguageGlossaryRow): TranslationWorkspaceGlossaryTerm {
  return {
    id: row.id,
    term: row.term,
    original_term: row.original_term,
    recommended_translation: row.recommended_translation,
    category: row.category,
    subcategory: row.subcategory,
    rule: row.rule,
    notes: row.notes,
    do_not_translate: Boolean(row.do_not_translate),
    aliases: row.aliases ?? [],
    tags: row.tags ?? [],
    match_reason: ''
  };
}

function parseDuplicateSuggestion(value: Json): TranslationWorkspaceDuplicateSuggestion | null {
  if (!value || typeof value !== 'object' || Array.isArray(value)) {
    return null;
  }

  const duplicate = value as Record<string, Json | undefined>;

  return {
    suggestion_id: String(duplicate.suggestion_id ?? ''),
    version_number: toNumber(duplicate.version_number),
    status: String(duplicate.status ?? 'draft'),
    suggestion_text: String(duplicate.suggestion_text ?? ''),
    author_id: duplicate.author_id == null ? null : String(duplicate.author_id),
    author_name: duplicate.author_name == null ? null : String(duplicate.author_name),
    author_username: duplicate.author_username == null ? null : String(duplicate.author_username),
    created_at: duplicate.created_at == null ? null : String(duplicate.created_at),
    match_kind: String(duplicate.match_kind ?? 'equivalent')
  };
}

function extractPlaceholders(text: string) {
  const matches = text.match(/(\{[A-Za-z0-9_]+\}|%[sd])/g);

  return matches ?? [];
}

function escapeRegExp(value: string) {
  return value.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

function toCounts(values: string[]) {
  const counts = new Map<string, number>();

  values.forEach((value) => {
    counts.set(value, (counts.get(value) ?? 0) + 1);
  });

  return counts;
}

export function validateTranslationPlaceholders(originalText: string, translatedText: string): TranslationWorkspacePlaceholderValidation {
  const required = extractPlaceholders(originalText);
  const translated = extractPlaceholders(translatedText);
  const requiredCounts = toCounts(required);
  const translatedCounts = toCounts(translated);
  const requiredUnique = [...new Set(required)];
  const extra = [...new Set(translated)];
  const missing: string[] = [];
  const extraTokens: string[] = [];

  requiredUnique.forEach((token) => {
    const requiredCount = requiredCounts.get(token) ?? 0;
    const translatedCount = translatedCounts.get(token) ?? 0;

    if (translatedCount < requiredCount) {
      missing.push(token);
    }

    if (translatedCount > requiredCount) {
      extraTokens.push(token);
    }
  });

  extra.forEach((token) => {
    if (!requiredCounts.has(token)) {
      extraTokens.push(token);
    }
  });

  return {
    valid: missing.length === 0 && extraTokens.length === 0,
    required: requiredUnique,
    missing,
    extra: [...new Set(extraTokens)]
  };
}

export function validateProtectedTerms(
  translatedText: string,
  protectedTerms: string[]
): TranslationWorkspaceProtectedTermsValidation {
  const required = [...new Set(
    protectedTerms
      .map((term) => term.trim())
      .filter((term) => term.length > 0)
  )];
  const missing: string[] = [];
  const modified: string[] = [];

  required.forEach((term) => {
    if (translatedText.includes(term)) {
      return;
    }

    const normalizedTerm = normalizeSearchText(term);
    const exactNormalizedPattern = new RegExp(`(^|[^\\p{L}\\p{N}_])${escapeRegExp(normalizedTerm)}([^\\p{L}\\p{N}_]|$)`, 'iu');
    const exactPattern = new RegExp(`(^|[^\\p{L}\\p{N}_])${escapeRegExp(term)}([^\\p{L}\\p{N}_]|$)`, 'u');
    const hasNormalizedMatch =
      normalizedTerm.length > 0 &&
      normalizeSearchText(translatedText).includes(normalizedTerm);

    if (exactPattern.test(translatedText)) {
      return;
    }

    if (exactNormalizedPattern.test(normalizeSearchText(translatedText)) || hasNormalizedMatch) {
      modified.push(term);
      return;
    }

    missing.push(term);
  });

  return {
    valid: missing.length === 0 && modified.length === 0,
    required,
    missing,
    modified
  };
}

function normalizeSessionRow(row: TranslationWorkspaceSessionRow, glossaryTerms: TranslationWorkspaceGlossaryTerm[] = []): TranslationWorkspaceSession {
  const items = parseItems(row.items).map((item) => ({
    ...item,
    glossary_terms: attachRelevantGlossaryTerms(item, glossaryTerms)
  }));

  return {
    session_id: row.session_id,
    target_language_id: row.target_language_id,
    target_language_code: row.target_language_code,
    target_language_name: row.target_language_name,
    target_language_native_name: row.target_language_native_name,
    target_language_emoji: row.target_language_emoji,
    category_slug: row.category_slug,
    total_available: toNumber(row.total_available),
    loaded_count: toNumber(row.loaded_count),
    batch_size: toNumber(row.batch_size),
    session_offset: toNumber(row.session_offset),
    has_more: Boolean(row.has_more),
    items
  };
}

export async function fetchLanguageGlossary(languageCode: string): Promise<TranslationWorkspaceGlossaryTerm[]> {
  if (!supabase || languageCode.trim().length === 0) {
    return [];
  }

  const { data, error } = await supabase.rpc('public_language_glossary', {
    language_code: languageCode
  });

  if (error) {
    throw new Error(error.message);
  }

  const rows = Array.isArray(data) ? (data as PublicLanguageGlossaryRow[]) : [];

  return rows.map(normalizeGlossaryRow);
}

export async function fetchTranslationWorkspaceSession(params: {
  targetLanguageCode?: string | null;
  categorySlug?: string | null;
  batchSize?: number;
  sessionOffset?: number;
  viewerUserId?: string | null;
}): Promise<TranslationWorkspaceSession | null> {
  const normalizedTargetLanguageCode = params.targetLanguageCode ?? '';
  const normalizedCategorySlug = params.categorySlug ?? null;
  const batchSize = params.batchSize ?? 10;
  const sessionOffset = params.sessionOffset ?? 0;
  const viewerUserId = params.viewerUserId ?? null;

  if (!supabase) {
    throw new Error('Supabase nao esta configurado. A fila nao pode ser carregada sem o banco oficial.');
  }

  const { data, error } = await supabase.rpc('translation_workspace_session', {
    p_target_language_code: normalizedTargetLanguageCode || null,
    p_category_slug: normalizedCategorySlug,
    p_batch_size: batchSize,
    p_session_offset: sessionOffset,
    p_viewer_user_id: viewerUserId
  });

  if (error) {
    throw new Error(error.message);
  }

  const row = Array.isArray(data) ? data[0] : null;

  if (!row) {
    return null;
  }

  let glossaryTerms: TranslationWorkspaceGlossaryTerm[] = [];

  try {
    glossaryTerms = await fetchLanguageGlossary(row.target_language_code);
  } catch {
    // Glossary loading is supplementary; it never changes queue persistence.
  }

  return normalizeSessionRow(row, glossaryTerms);
}

export async function findTranslationWorkspaceDuplicate(params: {
  translationKeyId: string;
  targetLanguageCode: string;
  suggestionText: string;
}): Promise<TranslationWorkspaceDuplicateSuggestion | null> {
  if (!supabase) {
    throw new Error('Supabase nao esta configurado.');
  }

  const { data, error } = await supabase.rpc('translation_workspace_detect_duplicate', {
    translation_key_id: params.translationKeyId,
    target_language_code: params.targetLanguageCode,
    suggestion_text: params.suggestionText
  });

  if (error) {
    throw new Error(error.message);
  }

  const row = Array.isArray(data) ? data[0] : null;

  if (!row) {
    return null;
  }

  return parseDuplicateSuggestion(row as Json);
}

export async function agreeTranslationWorkspaceSuggestion(params: { suggestionId: string }) {
  if (params.suggestionId.startsWith('seed:') || params.suggestionId.startsWith('local:') || !supabase) {
    return null;
  }

  const { data, error } = await supabase.rpc('translation_workspace_agree_suggestion', {
    suggestion_id: params.suggestionId
  });

  if (error) {
    throw new Error(error.message);
  }

  return Array.isArray(data) ? data[0] ?? null : null;
}

export async function submitTranslationWorkspaceSuggestion(params: {
  translationKeyId: string;
  targetLanguageCode: string;
  suggestionText: string;
  rationale?: string | null;
  notes?: string | null;
  supersedesSuggestionId?: string | null;
}): Promise<{
  suggestion_id: string;
  version_number: number;
  status: string;
  created_at: string;
} | null> {
  if (params.translationKeyId.startsWith('seed:')) {
    throw new Error('Esta string ainda nao foi importada para o Supabase e nao pode ser enviada.');
  }

  if (!supabase) {
    throw new Error('Supabase nao esta configurado. Sua traducao nao foi salva.');
  }

  const { data, error } = await supabase.rpc('translation_workspace_submit', {
    p_translation_key_id: params.translationKeyId,
    p_target_language_code: params.targetLanguageCode,
    p_suggestion_text: params.suggestionText,
    p_rationale: params.rationale ?? null,
    p_notes: params.notes ?? null,
    p_supersedes_suggestion_id: params.supersedesSuggestionId ?? null
  });

  if (error) {
    throw new Error(error.message);
  }

  const row = Array.isArray(data) ? data[0] : null;

  if (!row) {
    return null;
  }

  const result = {
    suggestion_id: row.suggestion_id,
    version_number: row.version_number,
    status: row.status,
    created_at: row.created_at
  };

  notifyTranslationDataRefresh();
  return result;
}
