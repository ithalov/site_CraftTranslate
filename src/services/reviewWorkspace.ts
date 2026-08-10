import { supabase } from '@/services/supabase';
import type { Database, Json } from '@/integrations/supabase/database.types';

type ReviewWorkspaceSessionRow = Database['public']['Functions']['review_workspace_session']['Returns'][number];

export type ReviewWorkspaceHistoryEntry = {
  review_id: string;
  reviewer_id: string | null;
  reviewer_name: string | null;
  reviewer_username: string | null;
  decision: string;
  score: number;
  notes: string | null;
  reviewed_at: string | null;
};

export type ReviewWorkspaceSiblingSuggestion = {
  suggestion_id: string;
  version_number: number;
  status: string;
  suggestion_text: string;
  author_id: string | null;
  author_name: string | null;
  author_username: string | null;
  created_at: string | null;
  supersedes_suggestion_id: string | null;
};

export type ReviewWorkspaceGlossaryTerm = {
  id: string;
  term: string;
  definition: string;
  category: string;
  subcategory: string | null;
  aliases: string[];
  tags: string[];
};

export type ReviewWorkspaceItem = {
  suggestion_id: string;
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
  suggestion_text: string;
  rationale: string | null;
  notes: string | null;
  status: string;
  version_number: number;
  author_id: string | null;
  author_name: string | null;
  author_username: string | null;
  created_at: string | null;
  review_history: ReviewWorkspaceHistoryEntry[];
  other_suggestions: ReviewWorkspaceSiblingSuggestion[];
  glossary_terms: ReviewWorkspaceGlossaryTerm[];
};

export type ReviewWorkspaceSession = {
  session_id: string;
  target_language_id: string;
  target_language_code: string;
  target_language_name: string;
  target_language_native_name: string;
  target_language_emoji: string | null;
  total_available: number;
  loaded_count: number;
  batch_size: number;
  session_offset: number;
  has_more: boolean;
  items: ReviewWorkspaceItem[];
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

function parseHistory(value: Json): ReviewWorkspaceHistoryEntry[] {
  if (!Array.isArray(value)) {
    return [];
  }

  return value
    .map((entry) => {
      if (!entry || typeof entry !== 'object' || Array.isArray(entry)) {
        return null;
      }

      const item = entry as Record<string, Json | undefined>;

      return {
        review_id: String(item.review_id ?? ''),
        reviewer_id: item.reviewer_id == null ? null : String(item.reviewer_id),
        reviewer_name: item.reviewer_name == null ? null : String(item.reviewer_name),
        reviewer_username: item.reviewer_username == null ? null : String(item.reviewer_username),
        decision: String(item.decision ?? ''),
        score: toNumber(item.score),
        notes: item.notes == null ? null : String(item.notes),
        reviewed_at: item.reviewed_at == null ? null : String(item.reviewed_at)
      } satisfies ReviewWorkspaceHistoryEntry;
    })
    .filter((entry): entry is ReviewWorkspaceHistoryEntry => entry !== null && entry.review_id.length > 0);
}

function parseSiblingSuggestions(value: Json): ReviewWorkspaceSiblingSuggestion[] {
  if (!Array.isArray(value)) {
    return [];
  }

  return value
    .map((entry) => {
      if (!entry || typeof entry !== 'object' || Array.isArray(entry)) {
        return null;
      }

      const item = entry as Record<string, Json | undefined>;

      return {
        suggestion_id: String(item.suggestion_id ?? ''),
        version_number: toNumber(item.version_number),
        status: String(item.status ?? 'draft'),
        suggestion_text: String(item.suggestion_text ?? ''),
        author_id: item.author_id == null ? null : String(item.author_id),
        author_name: item.author_name == null ? null : String(item.author_name),
        author_username: item.author_username == null ? null : String(item.author_username),
        created_at: item.created_at == null ? null : String(item.created_at),
        supersedes_suggestion_id: item.supersedes_suggestion_id == null ? null : String(item.supersedes_suggestion_id)
      } satisfies ReviewWorkspaceSiblingSuggestion;
    })
    .filter((entry): entry is ReviewWorkspaceSiblingSuggestion => entry !== null && entry.suggestion_id.length > 0);
}

function parseGlossaryTerms(value: Json): ReviewWorkspaceGlossaryTerm[] {
  if (!Array.isArray(value)) {
    return [];
  }

  return value
    .map((entry) => {
      if (!entry || typeof entry !== 'object' || Array.isArray(entry)) {
        return null;
      }

      const item = entry as Record<string, Json | undefined>;

      return {
        id: String(item.id ?? ''),
        term: String(item.term ?? ''),
        definition: String(item.definition ?? ''),
        category: String(item.category ?? ''),
        subcategory: item.subcategory == null ? null : String(item.subcategory),
        aliases: toStringArray(item.aliases),
        tags: toStringArray(item.tags)
      } satisfies ReviewWorkspaceGlossaryTerm;
    })
    .filter((entry): entry is ReviewWorkspaceGlossaryTerm => entry !== null && entry.id.length > 0);
}

function parseItem(value: Json): ReviewWorkspaceItem | null {
  if (!value || typeof value !== 'object' || Array.isArray(value)) {
    return null;
  }

  const item = value as Record<string, Json | undefined>;

  return {
    suggestion_id: String(item.suggestion_id ?? ''),
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
    suggestion_text: String(item.suggestion_text ?? ''),
    rationale: item.rationale == null ? null : String(item.rationale),
    notes: item.notes == null ? null : String(item.notes),
    status: String(item.status ?? 'pending'),
    version_number: toNumber(item.version_number),
    author_id: item.author_id == null ? null : String(item.author_id),
    author_name: item.author_name == null ? null : String(item.author_name),
    author_username: item.author_username == null ? null : String(item.author_username),
    created_at: item.created_at == null ? null : String(item.created_at),
    review_history: parseHistory(item.review_history ?? null),
    other_suggestions: parseSiblingSuggestions(item.other_suggestions ?? null),
    glossary_terms: parseGlossaryTerms(item.glossary_terms ?? null)
  };
}

function parseItems(value: Json): ReviewWorkspaceItem[] {
  if (!Array.isArray(value)) {
    return [];
  }

  return value.map(parseItem).filter((item): item is ReviewWorkspaceItem => item !== null && item.suggestion_id.length > 0);
}

function normalizeSessionRow(row: ReviewWorkspaceSessionRow): ReviewWorkspaceSession {
  return {
    session_id: row.session_id,
    target_language_id: row.target_language_id,
    target_language_code: row.target_language_code,
    target_language_name: row.target_language_name,
    target_language_native_name: row.target_language_native_name,
    target_language_emoji: row.target_language_emoji,
    total_available: toNumber(row.total_available),
    loaded_count: toNumber(row.loaded_count),
    batch_size: toNumber(row.batch_size),
    session_offset: toNumber(row.session_offset),
    has_more: Boolean(row.has_more),
    items: parseItems(row.items)
  };
}

export async function fetchReviewWorkspaceSession(params: {
  targetLanguageCode?: string | null;
  batchSize?: number;
  sessionOffset?: number;
}): Promise<ReviewWorkspaceSession | null> {
  if (!supabase) {
    return null;
  }

  const { data, error } = await supabase.rpc('review_workspace_session', {
    target_language_code: params.targetLanguageCode ?? null,
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

export async function submitReviewWorkspaceDecision(params: {
  suggestionId: string;
  decision: 'approve' | 'request_changes' | 'reject' | 'flag';
  notes?: string | null;
  correctionText?: string | null;
}): Promise<{
  review_id: string;
  reviewed_suggestion_id: string;
  decision: string;
  correction_suggestion_id: string | null;
  created_at: string;
} | null> {
  if (!supabase) {
    throw new Error('Supabase is not configured.');
  }

  const { data, error } = await supabase.rpc('review_workspace_submit', {
    suggestion_id: params.suggestionId,
    decision: params.decision,
    notes: params.notes ?? null,
    correction_text: params.correctionText ?? null
  });

  if (error) {
    throw new Error(error.message);
  }

  const row = Array.isArray(data) ? data[0] : null;

  if (!row) {
    return null;
  }

  return {
    review_id: String(row.review_id),
    reviewed_suggestion_id: String(row.reviewed_suggestion_id),
    decision: String(row.decision),
    correction_suggestion_id: row.correction_suggestion_id == null ? null : String(row.correction_suggestion_id),
    created_at: String(row.created_at)
  };
}
