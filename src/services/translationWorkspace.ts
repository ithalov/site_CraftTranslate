import { supabase } from '@/services/supabase';
import type { Database, Json } from '@/integrations/supabase/database.types';

type TranslationWorkspaceSessionRow = Database['public']['Functions']['translation_workspace_session']['Returns'][number];

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
  definition: string;
  category: string;
  subcategory: string | null;
  aliases: string[];
  tags: string[];
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
        definition: String(term.definition ?? ''),
        category: String(term.category ?? ''),
        subcategory: term.subcategory == null ? null : String(term.subcategory),
        aliases: toStringArray(term.aliases),
        tags: toStringArray(term.tags)
      } satisfies TranslationWorkspaceGlossaryTerm;
    })
    .filter((item): item is TranslationWorkspaceGlossaryTerm => item !== null && item.id.length > 0);
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

function normalizeSessionRow(row: TranslationWorkspaceSessionRow): TranslationWorkspaceSession {
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
    items: parseItems(row.items)
  };
}

export async function fetchTranslationWorkspaceSession(params: {
  targetLanguageCode?: string | null;
  categorySlug?: string | null;
  batchSize?: number;
  sessionOffset?: number;
}): Promise<TranslationWorkspaceSession | null> {
  if (!supabase) {
    return null;
  }

  const { data, error } = await supabase.rpc('translation_workspace_session', {
    target_language_code: params.targetLanguageCode ?? null,
    category_slug: params.categorySlug ?? null,
    batch_size: params.batchSize ?? 10,
    session_offset: params.sessionOffset ?? 0
  });

  if (error) {
    throw new Error(error.message);
  }

  const row = Array.isArray(data) ? data[0] : null;

  if (!row) {
    return null;
  }

  return normalizeSessionRow(row);
}

export async function submitTranslationWorkspaceSuggestion(params: {
  translationKeyId: string;
  targetLanguageCode: string;
  suggestionText: string;
  rationale?: string | null;
  notes?: string | null;
}): Promise<{
  suggestion_id: string;
  version_number: number;
  status: string;
  created_at: string;
} | null> {
  if (!supabase) {
    throw new Error('Supabase is not configured.');
  }

  const { data, error } = await supabase.rpc('translation_workspace_submit', {
    translation_key_id: params.translationKeyId,
    target_language_code: params.targetLanguageCode,
    suggestion_text: params.suggestionText,
    rationale: params.rationale ?? null,
    notes: params.notes ?? null
  });

  if (error) {
    throw new Error(error.message);
  }

  const row = Array.isArray(data) ? data[0] : null;

  if (!row) {
    return null;
  }

  return {
    suggestion_id: row.suggestion_id,
    version_number: row.version_number,
    status: row.status,
    created_at: row.created_at
  };
}
