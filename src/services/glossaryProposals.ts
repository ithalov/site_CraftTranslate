import { supabase } from '@/services/supabase';
import type { Database } from '@/integrations/supabase/database.types';

type GlossaryProposalRow = Database['public']['Tables']['glossary_proposals']['Row'];
type GlossaryProposalEventRow = Database['public']['Functions']['glossary_proposal_history']['Returns'][number];
type PublicLanguageCatalogItem = Database['public']['Functions']['public_language_catalog']['Returns'][number];

export type GlossaryProposal = GlossaryProposalRow;
export type GlossaryProposalHistoryItem = GlossaryProposalEventRow;
export type PublicLanguageOption = PublicLanguageCatalogItem;

export type SubmitGlossaryProposalInput = {
  languageCode: string;
  originalTerm: string;
  recommendedTranslation: string;
  category: string;
  subcategory?: string;
  rule?: string;
  rationale?: string;
  notes?: string;
  doNotTranslate?: boolean;
  glossaryId?: string | null;
  sourceTranslationKeyId?: string | null;
};

export type ReviewGlossaryProposalInput = {
  proposalId: string;
  decision: 'approve' | 'reject' | 'request_changes';
  notes?: string;
};

function normalizeProposal(row: GlossaryProposalRow): GlossaryProposal {
  return {
    ...row,
    proposed_category: row.proposed_category ?? 'general',
    proposed_do_not_translate: Boolean(row.proposed_do_not_translate),
    proposed_notes: row.proposed_notes ?? row.rationale,
    proposed_original_term: row.proposed_original_term ?? row.proposed_term,
    proposed_recommended_translation: row.proposed_recommended_translation ?? row.proposed_definition,
    proposed_rule: row.proposed_rule ?? null,
    proposed_subcategory: row.proposed_subcategory ?? null,
    proposed_term: row.proposed_term ?? row.proposed_original_term ?? '',
    proposed_definition: row.proposed_definition ?? row.proposed_recommended_translation ?? ''
  };
}

export async function fetchGlossaryProposalLanguages(): Promise<PublicLanguageOption[]> {
  if (!supabase) {
    return [];
  }

  const { data, error } = await supabase.rpc('public_language_catalog');

  if (error) {
    throw new Error(error.message);
  }

  return Array.isArray(data) ? (data as PublicLanguageOption[]) : [];
}

export async function fetchGlossaryProposals(): Promise<GlossaryProposal[]> {
  if (!supabase) {
    return [];
  }

  const { data, error } = await supabase
    .from('glossary_proposals')
    .select('*')
    .order('created_at', { ascending: false });

  if (error) {
    throw new Error(error.message);
  }

  return (data ?? []).map(normalizeProposal);
}

export async function fetchGlossaryProposalHistory(proposalId: string): Promise<GlossaryProposalHistoryItem[]> {
  if (!supabase) {
    return [];
  }

  const { data, error } = await supabase.rpc('glossary_proposal_history', {
    proposal_id: proposalId
  });

  if (error) {
    throw new Error(error.message);
  }

  return Array.isArray(data) ? (data as GlossaryProposalHistoryItem[]) : [];
}

export async function submitGlossaryProposal(input: SubmitGlossaryProposalInput) {
  if (!supabase) {
    throw new Error('Supabase is not configured.');
  }

  const { data, error } = await supabase.rpc('submit_glossary_proposal', {
    language_code: input.languageCode,
    proposed_original_term: input.originalTerm,
    proposed_recommended_translation: input.recommendedTranslation,
    proposed_category: input.category,
    proposed_subcategory: input.subcategory ?? null,
    proposed_rule: input.rule ?? null,
    proposed_notes: input.notes ?? null,
    proposed_do_not_translate: input.doNotTranslate ?? false,
    rationale: input.rationale ?? null,
    glossary_id: input.glossaryId ?? null,
    source_translation_key_id: input.sourceTranslationKeyId ?? null
  });

  if (error) {
    throw new Error(error.message);
  }

  return Array.isArray(data) ? data[0] ?? null : null;
}

export async function reviewGlossaryProposal(input: ReviewGlossaryProposalInput) {
  if (!supabase) {
    throw new Error('Supabase is not configured.');
  }

  const { data, error } = await supabase.rpc('review_glossary_proposal', {
    proposal_id: input.proposalId,
    decision: input.decision,
    notes: input.notes ?? null
  });

  if (error) {
    throw new Error(error.message);
  }

  return Array.isArray(data) ? data[0] ?? null : null;
}
