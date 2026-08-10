import { Fragment, useEffect, useMemo, useState, type ReactNode } from 'react';
import { Link, useSearchParams } from 'react-router-dom';
import { Badge } from '@/components/ui/Badge';
import { Card } from '@/components/ui/Card';
import { PageShell } from '@/components/page/PageShell';
import { useAuth } from '@/hooks/useAuth';
import { useLocale } from '@/hooks/useLocale';
import { paths } from '@/navigation/paths';
import translationSeed from '@/data/translation-seed.json';
import {
  agreeTranslationWorkspaceSuggestion,
  findTranslationWorkspaceDuplicate,
  fetchTranslationWorkspaceSession,
  submitTranslationWorkspaceSuggestion,
  type TranslationWorkspaceDuplicateSuggestion,
  type TranslationWorkspaceSession,
  validateProtectedTerms,
  validateTranslationPlaceholders
} from '@/services/translationWorkspace';

type Copy = {
  eyebrow: string;
  title: string;
  description: string;
  sessionLabel: string;
  loading: string;
  error: string;
  noSession: string;
  noItems: string;
  complete: string;
  source: string;
  target: string;
  category: string;
  subcategory: string;
  context: string;
  contextPack: string;
  glossary: string;
  glossaryFound: string;
  glossaryOriginal: string;
  glossaryRecommended: string;
  glossaryRule: string;
  glossaryNotes: string;
  glossaryProtected: string;
  glossaryMatchedAs: string;
  glossaryNoMatches: string;
  protectedVars: string;
  protectedTerms: string;
  autoSuggestion: string;
  currentDraft: string;
  translationField: string;
  rationaleField: string;
  notesField: string;
  skip: string;
  submit: string;
  submitting: string;
  loadingMore: string;
  loadMore: string;
  translated: string;
  skipped: string;
  remaining: string;
  openLanguage: string;
  backToLanguages: string;
  preview: string;
  sourceOriginal: string;
  destination: string;
  batchProgress: string;
  totalAvailable: string;
  compatible: string;
  noSuggestion: string;
  duplicateTitle: string;
  duplicateDescription: string;
  duplicateAgree: string;
  duplicateImprove: string;
  duplicateAuthor: string;
  duplicateCreatedAt: string;
  duplicateEquivalent: string;
  duplicateHint: string;
  placeholderGuardTitle: string;
  placeholderGuardBlocked: string;
  placeholderGuardPreserve: string;
  placeholderGuardMissing: string;
  placeholderGuardExtra: string;
  protectedTermGuardTitle: string;
  protectedTermGuardBlocked: string;
  protectedTermGuardPreserve: string;
  protectedTermGuardMissing: string;
  protectedTermGuardModified: string;
};

const copyByLocale: Record<'pt-BR' | 'en' | 'es', Copy> = {
  'pt-BR': {
    eyebrow: 'Traduzir',
    title: 'Translation Workspace',
    description: 'Fila segura por lotes pequenos, mostrando somente strings compatíveis com seu idioma e suas permissoes.',
    sessionLabel: 'Sessao de trabalho',
    loading: 'Carregando fila segura...',
    error: 'Nao foi possivel carregar a fila de traducao.',
    noSession: 'Escolha um idioma e uma categoria para abrir uma sessao.',
    noItems: 'Nao ha strings nesta fila agora.',
    complete: 'Sessao concluida',
    source: 'Origem',
    target: 'Destino',
    category: 'Categoria',
    subcategory: 'Subcategoria',
    context: 'Contexto',
    contextPack: 'Context Pack',
    glossary: 'Glossario',
    glossaryFound: 'Termos relevantes encontrados',
    glossaryOriginal: 'Original',
    glossaryRecommended: 'Traducao recomendada',
    glossaryRule: 'Regra',
    glossaryNotes: 'Notas',
    glossaryProtected: 'Nao traduzir',
    glossaryMatchedAs: 'Encontrado como',
    glossaryNoMatches: 'Nenhum termo relevante encontrado para esta string.',
    protectedVars: 'Variaveis protegidas',
    protectedTerms: 'Termos protegidos',
    autoSuggestion: 'Sugestao automatica',
    currentDraft: 'Seu rascunho atual',
    translationField: 'Sua traducao',
    rationaleField: 'Racional opcional',
    notesField: 'Notas opcionais',
    skip: 'Skip',
    submit: 'Submit',
    submitting: 'Enviando...',
    loadingMore: 'Carregando mais...',
    loadMore: 'Carregar proxima sessao',
    translated: 'Traduzidas',
    skipped: 'Puladas',
    remaining: 'Restantes',
    openLanguage: 'Abrir idioma',
    backToLanguages: 'Voltar para idiomas',
    preview: 'Preview da fila',
    sourceOriginal: 'Texto original',
    destination: 'Idioma destino',
    batchProgress: 'Progresso do lote',
    totalAvailable: 'Disponiveis',
    compatible: 'Compativel com seu perfil',
    noSuggestion: 'Nenhuma sugestao automatica disponivel.',
    duplicateTitle: 'Sugestao equivalente encontrada',
    duplicateDescription: 'Ja existe uma traducao muito parecida para esta string. Use Agree se ela estiver correta, ou Suggest Improvement se quiser propor uma versao melhorada.',
    duplicateAgree: 'Agree',
    duplicateImprove: 'Suggest Improvement',
    duplicateAuthor: 'Autoria',
    duplicateCreatedAt: 'Criada em',
    duplicateEquivalent: 'Equivalente',
    duplicateHint: 'Para evitar duplicacao, aprove a sugestao existente ou envie uma melhoria vinculada a ela.',
    placeholderGuardTitle: 'Variaveis protegidas',
    placeholderGuardBlocked: 'A traducao foi bloqueada porque um placeholder obrigatorio foi removido ou alterado.',
    placeholderGuardPreserve: 'Preserve exatamente estes tokens:',
    placeholderGuardMissing: 'Faltando na traducao:',
    placeholderGuardExtra: 'Tokens inesperados:',
    protectedTermGuardTitle: 'Termos protegidos',
    protectedTermGuardBlocked: 'A traducao foi bloqueada porque um termo protegido foi removido ou modificado.',
    protectedTermGuardPreserve: 'Preserve exatamente estes termos:',
    protectedTermGuardMissing: 'Termos ausentes na traducao:',
    protectedTermGuardModified: 'Termos modificados:',
  },
  en: {
    eyebrow: 'Translate',
    title: 'Translation Workspace',
    description: 'A secure small-batch queue that only shows strings compatible with your language permissions.',
    sessionLabel: 'Work session',
    loading: 'Loading secure queue...',
    error: 'Unable to load the translation queue.',
    noSession: 'Choose a language and a category to open a session.',
    noItems: 'There are no strings in this queue right now.',
    complete: 'Session complete',
    source: 'Source',
    target: 'Target',
    category: 'Category',
    subcategory: 'Subcategory',
    context: 'Context',
    contextPack: 'Context Pack',
    glossary: 'Glossary',
    glossaryFound: 'Relevant terms found',
    glossaryOriginal: 'Original',
    glossaryRecommended: 'Recommended translation',
    glossaryRule: 'Rule',
    glossaryNotes: 'Notes',
    glossaryProtected: 'Do not translate',
    glossaryMatchedAs: 'Matched as',
    glossaryNoMatches: 'No relevant terms found for this string.',
    protectedVars: 'Protected variables',
    protectedTerms: 'Protected terms',
    autoSuggestion: 'Automatic suggestion',
    currentDraft: 'Your current draft',
    translationField: 'Your translation',
    rationaleField: 'Optional rationale',
    notesField: 'Optional notes',
    skip: 'Skip',
    submit: 'Submit',
    submitting: 'Submitting...',
    loadingMore: 'Loading more...',
    loadMore: 'Load next session',
    translated: 'Translated',
    skipped: 'Skipped',
    remaining: 'Remaining',
    openLanguage: 'Open language',
    backToLanguages: 'Back to languages',
    preview: 'Queue preview',
    sourceOriginal: 'Original text',
    destination: 'Target language',
    batchProgress: 'Batch progress',
    totalAvailable: 'Available',
    compatible: 'Compatible with your profile',
    noSuggestion: 'No automatic suggestion is available.',
    duplicateTitle: 'Equivalent suggestion found',
    duplicateDescription: 'A very similar translation already exists for this string. Use Agree if it is correct, or Suggest Improvement if you want to propose a refined version.',
    duplicateAgree: 'Agree',
    duplicateImprove: 'Suggest Improvement',
    duplicateAuthor: 'Author',
    duplicateCreatedAt: 'Created at',
    duplicateEquivalent: 'Equivalent',
    duplicateHint: 'To avoid duplication, approve the existing suggestion or submit an improvement linked to it.',
    placeholderGuardTitle: 'Protected variables',
    placeholderGuardBlocked: 'The translation was blocked because a required placeholder was removed or changed.',
    placeholderGuardPreserve: 'Preserve these tokens exactly:',
    placeholderGuardMissing: 'Missing from translation:',
    placeholderGuardExtra: 'Unexpected tokens:',
    protectedTermGuardTitle: 'Protected terms',
    protectedTermGuardBlocked: 'The translation was blocked because a protected term was removed or modified.',
    protectedTermGuardPreserve: 'Preserve these terms exactly:',
    protectedTermGuardMissing: 'Missing from translation:',
    protectedTermGuardModified: 'Modified terms:',
  },
  es: {
    eyebrow: 'Traducir',
    title: 'Translation Workspace',
    description: 'Una cola segura en lotes pequenos que solo muestra strings compatibles con tus permisos.',
    sessionLabel: 'Sesion de trabajo',
    loading: 'Cargando cola segura...',
    error: 'No fue posible cargar la cola de traduccion.',
    noSession: 'Elige un idioma y una categoria para abrir una sesion.',
    noItems: 'No hay strings en esta cola ahora.',
    complete: 'Sesion completa',
    source: 'Origen',
    target: 'Destino',
    category: 'Categoria',
    subcategory: 'Subcategoria',
    context: 'Contexto',
    contextPack: 'Context Pack',
    glossary: 'Glosario',
    glossaryFound: 'Terminos relevantes encontrados',
    glossaryOriginal: 'Original',
    glossaryRecommended: 'Traduccion recomendada',
    glossaryRule: 'Regla',
    glossaryNotes: 'Notas',
    glossaryProtected: 'No traducir',
    glossaryMatchedAs: 'Encontrado como',
    glossaryNoMatches: 'No se encontraron terminos relevantes para esta string.',
    protectedVars: 'Variables protegidas',
    protectedTerms: 'Terminos protegidos',
    autoSuggestion: 'Sugerencia automatica',
    currentDraft: 'Tu borrador actual',
    translationField: 'Tu traduccion',
    rationaleField: 'Razon opcional',
    notesField: 'Notas opcionales',
    skip: 'Skip',
    submit: 'Submit',
    submitting: 'Enviando...',
    loadingMore: 'Cargando mas...',
    loadMore: 'Cargar siguiente sesion',
    translated: 'Traducidas',
    skipped: 'Omitidas',
    remaining: 'Restantes',
    openLanguage: 'Abrir idioma',
    backToLanguages: 'Volver a idiomas',
    preview: 'Vista previa de la cola',
    sourceOriginal: 'Texto original',
    destination: 'Idioma destino',
    batchProgress: 'Progreso del lote',
    totalAvailable: 'Disponibles',
    compatible: 'Compatible con tu perfil',
    noSuggestion: 'No hay sugerencia automatica disponible.',
    duplicateTitle: 'Sugerencia equivalente encontrada',
    duplicateDescription: 'Ya existe una traduccion muy parecida para esta string. Usa Agree si esta correcta, o Suggest Improvement si quieres proponer una version mejorada.',
    duplicateAgree: 'Agree',
    duplicateImprove: 'Suggest Improvement',
    duplicateAuthor: 'Autor',
    duplicateCreatedAt: 'Creada en',
    duplicateEquivalent: 'Equivalente',
    duplicateHint: 'Para evitar duplicacion, aprueba la sugerencia existente o envia una mejora vinculada a ella.',
    placeholderGuardTitle: 'Variables protegidas',
    placeholderGuardBlocked: 'La traduccion fue bloqueada porque un placeholder obligatorio fue removido o modificado.',
    placeholderGuardPreserve: 'Preserva exactamente estos tokens:',
    placeholderGuardMissing: 'Faltan en la traduccion:',
    placeholderGuardExtra: 'Tokens inesperados:',
    protectedTermGuardTitle: 'Terminos protegidos',
    protectedTermGuardBlocked: 'La traduccion fue bloqueada porque un termino protegido fue removido o modificado.',
    protectedTermGuardPreserve: 'Preserva exactamente estos terminos:',
    protectedTermGuardMissing: 'Faltan en la traduccion:',
    protectedTermGuardModified: 'Terminos modificados:',
  }
};

function formatCategoryLabel(value: string) {
  return value
    .replace(/_/g, ' ')
    .replace(/\b\w/g, (char) => char.toUpperCase());
}

function formatMatchReason(value: string) {
  return value
    .replace(/_/g, ' ')
    .replace(/\b\w/g, (char) => char.toUpperCase());
}

function formatList(values: string[]) {
  return values.length > 0 ? values.join(', ') : '-';
}

function renderHighlightedProtectedTerms(text: string, protectedTerms: string[]) {
  const normalizedText = text.toLowerCase();
  const terms = [...new Set(protectedTerms.map((term) => term.trim()).filter((term) => term.length > 0))]
    .sort((left, right) => right.length - left.length);

  if (terms.length === 0 || text.length === 0) {
    return text;
  }

  const matches: Array<{ start: number; end: number; term: string }> = [];

  terms.forEach((term) => {
    const needle = term.toLowerCase();
    if (needle.length === 0) {
      return;
    }

    let index = normalizedText.indexOf(needle);
    while (index !== -1) {
      matches.push({ start: index, end: index + term.length, term });
      index = normalizedText.indexOf(needle, index + Math.max(needle.length, 1));
    }
  });

  if (matches.length === 0) {
    return text;
  }

  const sortedMatches = matches.sort((left, right) => {
    if (left.start !== right.start) {
      return left.start - right.start;
    }

    return right.end - left.end;
  });

  const segments: ReactNode[] = [];
  let cursor = 0;
  let keyIndex = 0;

  sortedMatches.forEach((match) => {
    if (match.start < cursor) {
      return;
    }

    if (match.start > cursor) {
      segments.push(text.slice(cursor, match.start));
    }

    const matchedText = text.slice(match.start, match.end);
    segments.push(
      <mark
        key={`protected-${keyIndex++}-${match.term}`}
        className="rounded-md border border-[#e59b32] bg-[#fff1d6] px-1.5 py-0.5 font-bold text-[#8c5510]"
        title={match.term}
      >
        {matchedText}
      </mark>
    );
    cursor = match.end;
  });

  if (cursor < text.length) {
    segments.push(text.slice(cursor));
  }

  return <>{segments.map((segment, index) => <Fragment key={index}>{segment}</Fragment>)}</>;
}

function textareaClassName() {
  return 'min-h-[140px] w-full rounded-2xl border-2 border-[#101114] bg-white px-4 py-3 text-sm text-[#101114] outline-none transition placeholder:text-[#8a94a6] focus:border-[#5652ff]';
}

function formatTimestamp(value: string | null, locale: 'pt-BR' | 'en' | 'es') {
  if (!value) {
    return '-';
  }

  const date = new Date(value);

  if (Number.isNaN(date.getTime())) {
    return value;
  }

  return new Intl.DateTimeFormat(locale === 'pt-BR' ? 'pt-BR' : locale === 'es' ? 'es-ES' : 'en-US', {
    dateStyle: 'medium',
    timeStyle: 'short'
  }).format(date);
}

type CommunityPhraseProposal = {
  id: string;
  source_language: string;
  target_languages: string[];
  source_text: string;
  key_name: string;
  theme: string;
  category: string;
  subcategory: string;
  context: string;
  notes: string;
  protected_variables: string;
  protected_terms: string;
  created_at: string;
};

const COMMUNITY_PROPOSALS_STORAGE_KEY = 'chattranslate-community-phrase-proposals-v1';

function loadCommunityPhraseProposals(): CommunityPhraseProposal[] {
  if (typeof window === 'undefined') {
    return [];
  }

  try {
    const raw = window.localStorage.getItem(COMMUNITY_PROPOSALS_STORAGE_KEY);

    if (!raw) {
      return [];
    }

    const parsed = JSON.parse(raw) as unknown;

    if (!Array.isArray(parsed)) {
      return [];
    }

    return parsed
      .map((item) => {
        if (!item || typeof item !== 'object' || Array.isArray(item)) {
          return null;
        }

        const proposal = item as Record<string, unknown>;

        return {
          id: String(proposal.id ?? ''),
          source_language: String(proposal.source_language ?? 'en'),
          target_languages: Array.isArray(proposal.target_languages) ? proposal.target_languages.map((value) => String(value)) : [],
          source_text: String(proposal.source_text ?? ''),
          key_name: String(proposal.key_name ?? ''),
          theme: String(proposal.theme ?? ''),
          category: String(proposal.category ?? ''),
          subcategory: String(proposal.subcategory ?? ''),
          context: String(proposal.context ?? ''),
          notes: String(proposal.notes ?? ''),
          protected_variables: String(proposal.protected_variables ?? ''),
          protected_terms: String(proposal.protected_terms ?? ''),
          created_at: String(proposal.created_at ?? '')
        } satisfies CommunityPhraseProposal;
      })
      .filter((item): item is CommunityPhraseProposal => item !== null && item.id.length > 0);
  } catch {
    return [];
  }
}

function saveCommunityPhraseProposals(proposals: CommunityPhraseProposal[]) {
  if (typeof window === 'undefined') {
    return;
  }

  window.localStorage.setItem(COMMUNITY_PROPOSALS_STORAGE_KEY, JSON.stringify(proposals));
}

export function TranslatePage() {
  const { user } = useAuth();
  const { locale } = useLocale();
  const copy = copyByLocale[locale];
  const [searchParams] = useSearchParams();
  const languageCode = searchParams.get('language')?.trim() ?? '';
  const categorySlug = searchParams.get('category')?.trim() ?? '';
  const [session, setSession] = useState<TranslationWorkspaceSession | null>(null);
  const [loading, setLoading] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [activeIndex, setActiveIndex] = useState(0);
  const [submittedCount, setSubmittedCount] = useState(0);
  const [skippedCount, setSkippedCount] = useState(0);
  const [translation, setTranslation] = useState('');
  const [rationale, setRationale] = useState('');
  const [notes, setNotes] = useState('');
  const [submitting, setSubmitting] = useState(false);
  const [duplicateSuggestion, setDuplicateSuggestion] = useState<TranslationWorkspaceDuplicateSuggestion | null>(null);
  const [duplicateLoading, setDuplicateLoading] = useState(false);
  const [communityProposals, setCommunityProposals] = useState<CommunityPhraseProposal[]>(() => loadCommunityPhraseProposals());
  const [showCommunityIntake, setShowCommunityIntake] = useState(false);
  const [communityProposalForm, setCommunityProposalForm] = useState({
    source_text: '',
    key_name: '',
    theme: '',
    category: '',
    subcategory: '',
    context: '',
    notes: '',
    protected_variables: '',
    protected_terms: '',
    target_languages: ['pt-BR']
  });

  const currentItem = session?.items[activeIndex] ?? null;
  const placeholderValidation = useMemo(() => {
    if (!currentItem) {
      return null;
    }

    return validateTranslationPlaceholders(currentItem.original_text, translation);
  }, [currentItem, translation]);
  const protectedTermsValidation = useMemo(() => {
    if (!currentItem) {
      return null;
    }

    return validateProtectedTerms(translation, currentItem.protected_terms);
  }, [currentItem, translation]);

  async function loadSession(offset = 0, nextSession = false) {
    try {
      setError(null);
      setLoading(nextSession ? false : true);
      setLoadingMore(nextSession);

      const result = await fetchTranslationWorkspaceSession({
        targetLanguageCode: languageCode || null,
        categorySlug: categorySlug || null,
        batchSize: 10,
        sessionOffset: offset,
        viewerUserId: user?.id ?? null
      });

      setSession(result);
      setActiveIndex(0);
      setSubmittedCount(0);
      setSkippedCount(0);

      const firstItem = result?.items[0] ?? null;
      setTranslation(firstItem?.my_suggestion?.suggestion_text ?? firstItem?.auto_suggestion?.suggestion_text ?? '');
      setRationale(firstItem?.my_suggestion?.rationale ?? '');
      setNotes(firstItem?.my_suggestion?.notes ?? '');
      setDuplicateSuggestion(null);
    } catch (loadError) {
      setSession(null);
      setError(loadError instanceof Error ? loadError.message : copy.error);
    } finally {
      setLoading(false);
      setLoadingMore(false);
    }
  }

  useEffect(() => {
    void loadSession(0, false);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [languageCode, categorySlug, user?.id]);

  useEffect(() => {
    if (!currentItem) {
      setDuplicateSuggestion(null);
      return;
    }

    setTranslation(currentItem.my_suggestion?.suggestion_text ?? currentItem.auto_suggestion?.suggestion_text ?? '');
    setRationale(currentItem.my_suggestion?.rationale ?? '');
    setNotes(currentItem.my_suggestion?.notes ?? '');
  }, [currentItem]);

  useEffect(() => {
    if (!currentItem || translation.trim().length === 0) {
      setDuplicateSuggestion(null);
      return;
    }

    let mounted = true;
    const timeout = window.setTimeout(() => {
      setDuplicateLoading(true);

      void findTranslationWorkspaceDuplicate({
        translationKeyId: currentItem.translation_key_id,
        targetLanguageCode: currentItem.target_language_code,
        suggestionText: translation
      })
        .then((result) => {
          if (mounted) {
            setDuplicateSuggestion(result);
          }
        })
        .catch(() => {
          if (mounted) {
            setDuplicateSuggestion(null);
          }
        })
        .finally(() => {
          if (mounted) {
            setDuplicateLoading(false);
          }
        });
    }, 350);

    return () => {
      mounted = false;
      window.clearTimeout(timeout);
    };
  }, [currentItem, translation]);

  useEffect(() => {
    saveCommunityPhraseProposals(communityProposals);
  }, [communityProposals]);

  const progressLabel = useMemo(() => {
    if (!session) {
      return '0/0';
    }

    return `${Math.min(activeIndex + 1, session.loaded_count)}/${session.loaded_count}`;
  }, [activeIndex, session]);

  const processedCount = submittedCount + skippedCount;
  const remainingCount = session ? Math.max(session.loaded_count - processedCount, 0) : 0;
  const seedStringCount = translationSeed.strings.length;
  const proposalRuleCount = translationSeed.proposal_rules.length;

  function handleProposalTargetToggle(code: string) {
    setCommunityProposalForm((current) => {
      const exists = current.target_languages.includes(code);

      return {
        ...current,
        target_languages: exists
          ? current.target_languages.filter((item) => item !== code)
          : [...current.target_languages, code]
      };
    });
  }

  function exportCommunityProposals() {
    const payload = {
      version: 1,
      source_language: 'en',
      generated_at: new Date().toISOString(),
      proposals: communityProposals
    };

    const blob = new Blob([JSON.stringify(payload, null, 2)], { type: 'application/json;charset=utf-8' });
    const url = window.URL.createObjectURL(blob);
    const anchor = document.createElement('a');

    anchor.href = url;
    anchor.download = 'translation-proposals.json';
    anchor.click();
    window.URL.revokeObjectURL(url);
  }

  function handleAddCommunityProposal() {
    if (
      communityProposalForm.source_text.trim().length === 0 ||
      communityProposalForm.key_name.trim().length === 0 ||
      communityProposalForm.theme.trim().length === 0 ||
      communityProposalForm.category.trim().length === 0 ||
      communityProposalForm.context.trim().length === 0 ||
      communityProposalForm.target_languages.length === 0
    ) {
      setError(locale === 'pt-BR' ? 'Preencha texto, chave, tema, categoria, contexto e pelo menos um idioma alvo.' : locale === 'es' ? 'Completa texto, clave, tema, categoria, contexto y al menos un idioma destino.' : 'Fill in the text, key, theme, category, context, and at least one target language.');
      return;
    }

    const proposal: CommunityPhraseProposal = {
      id: `proposal-${crypto.randomUUID()}`,
      source_language: 'en',
      target_languages: communityProposalForm.target_languages,
      source_text: communityProposalForm.source_text.trim(),
      key_name: communityProposalForm.key_name.trim(),
      theme: communityProposalForm.theme.trim(),
      category: communityProposalForm.category.trim(),
      subcategory: communityProposalForm.subcategory.trim(),
      context: communityProposalForm.context.trim(),
      notes: communityProposalForm.notes.trim(),
      protected_variables: communityProposalForm.protected_variables.trim(),
      protected_terms: communityProposalForm.protected_terms.trim(),
      created_at: new Date().toISOString()
    };

    setCommunityProposals((current) => [proposal, ...current]);
    setCommunityProposalForm({
      source_text: '',
      key_name: '',
      theme: '',
      category: '',
      subcategory: '',
      context: '',
      notes: '',
      protected_variables: '',
      protected_terms: '',
      target_languages: ['pt-BR']
    });
    setError(null);
  }

  async function goToNextSession() {
    if (!session?.has_more) {
      return;
    }

    await loadSession(session.session_offset + session.batch_size, true);
  }

  async function handleSubmit(options?: { supersedesSuggestionId?: string | null }) {
    if (!session || !currentItem || translation.trim().length === 0) {
      return;
    }

    if (placeholderValidation && !placeholderValidation.valid) {
      setError(copy.placeholderGuardBlocked);
      return;
    }

    if (protectedTermsValidation && !protectedTermsValidation.valid) {
      setError(copy.protectedTermGuardBlocked);
      return;
    }

    try {
      setSubmitting(true);
      setError(null);

      await submitTranslationWorkspaceSuggestion({
        translationKeyId: currentItem.translation_key_id,
        targetLanguageCode: session.target_language_code,
        suggestionText: translation,
        rationale: rationale.trim().length > 0 ? rationale : null,
        notes: notes.trim().length > 0 ? notes : null,
        supersedesSuggestionId: options?.supersedesSuggestionId ?? null
      });

      setSubmittedCount((value) => value + 1);

      if (activeIndex + 1 < session.items.length) {
        setActiveIndex((value) => value + 1);
        return;
      }

      if (session.has_more) {
        await goToNextSession();
        return;
      }

      setSession((current) => (current ? { ...current, items: [] } : current));
    } catch (submitError) {
      setError(submitError instanceof Error ? submitError.message : copy.error);
    } finally {
      setSubmitting(false);
    }
  }

  async function handleAgree() {
    if (!duplicateSuggestion) {
      return;
    }

    try {
      setSubmitting(true);
      setError(null);
      await agreeTranslationWorkspaceSuggestion({ suggestionId: duplicateSuggestion.suggestion_id });
      setSkippedCount((value) => value + 1);

      if (session && activeIndex + 1 < session.items.length) {
        setActiveIndex((value) => value + 1);
        return;
      }

      if (session?.has_more) {
        await goToNextSession();
      }
    } catch (agreeError) {
      setError(agreeError instanceof Error ? agreeError.message : copy.error);
    } finally {
      setSubmitting(false);
    }
  }

  async function handleSkip() {
    if (!session || !currentItem) {
      return;
    }

    setSkippedCount((value) => value + 1);

    if (activeIndex + 1 < session.items.length) {
      setActiveIndex((value) => value + 1);
      return;
    }

    if (session.has_more) {
      await goToNextSession();
    }
  }

  const sessionBadge = session
    ? session.category_slug === 'all'
      ? 'All strings'
      : formatCategoryLabel(session.category_slug)
    : categorySlug
      ? formatCategoryLabel(categorySlug)
      : copy.complete;
  const hasPlaceholderWarning = Boolean(placeholderValidation && !placeholderValidation.valid);
  const hasProtectedTermWarning = Boolean(protectedTermsValidation && !protectedTermsValidation.valid);
  const hasValidationWarning = hasPlaceholderWarning || hasProtectedTermWarning;

  return (
    <PageShell eyebrow={copy.eyebrow} title={copy.title} description={copy.description}>
      <div className="space-y-6">
        <Card className="overflow-hidden border-2 border-[#101114] bg-[#101114] p-0 text-white shadow-[8px_8px_0_#c7f464]">
          <div className="relative overflow-hidden px-6 py-7 md:px-8 md:py-8">
            <div className="absolute inset-0 bg-[radial-gradient(circle_at_12%_18%,rgba(199,244,100,.2),transparent_30%),radial-gradient(circle_at_88%_22%,rgba(76,201,240,.18),transparent_28%),radial-gradient(circle_at_66%_82%,rgba(255,184,107,.12),transparent_30%)]" />
            <div className="relative flex flex-col gap-6 lg:flex-row lg:items-center lg:justify-between">
              <div>
                <p className="pixel-label text-[10px] text-[#c7f464]">{copy.sessionLabel}</p>
                <h1 className="minecraft-title mt-3 text-4xl leading-none md:text-6xl">{copy.title}</h1>
                <p className="mt-4 max-w-2xl text-sm leading-7 text-white/72 md:text-base">{copy.description}</p>
                <div className="mt-5 flex flex-wrap gap-2">
                  {languageCode ? <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">{languageCode}</Badge> : null}
                  <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">{sessionBadge}</Badge>
                  <Badge tone="success">{copy.compatible}</Badge>
                  <Badge tone="warning">{`${seedStringCount} seed strings`}</Badge>
                  <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">{`${proposalRuleCount} proposal rules`}</Badge>
                </div>
              </div>

              <div className="grid gap-3 sm:grid-cols-3 lg:min-w-[420px] lg:grid-cols-1">
                <div className="rounded-2xl border border-white/10 bg-white/[.06] p-4">
                  <p className="text-xs uppercase tracking-[0.24em] text-white/50">{copy.batchProgress}</p>
                  <p className="mt-2 text-3xl font-extrabold text-white">{progressLabel}</p>
                </div>
                <div className="rounded-2xl border border-white/10 bg-white/[.06] p-4">
                  <p className="text-xs uppercase tracking-[0.24em] text-white/50">{copy.totalAvailable}</p>
                  <p className="mt-2 text-3xl font-extrabold text-white">{session?.total_available ?? 0}</p>
                </div>
                <div className="rounded-2xl border border-white/10 bg-white/[.06] p-4">
                  <p className="text-xs uppercase tracking-[0.24em] text-white/50">{copy.remaining}</p>
                  <p className="mt-2 text-3xl font-extrabold text-white">{remainingCount}</p>
                </div>
              </div>
            </div>
          </div>
        </Card>

        {loading ? (
          <Card className="p-8 text-center">
            <p className="minecraft-title text-2xl text-[#101114]">{copy.loading}</p>
          </Card>
        ) : error ? (
          <Card className="p-8 text-center">
            <p className="minecraft-title text-2xl text-[#101114]">{copy.error}</p>
            <p className="mt-3 text-sm text-[#566172]">{error}</p>
          </Card>
        ) : !session ? (
          <Card className="p-8 text-center">
            <p className="minecraft-title text-2xl text-[#101114]">{copy.noSession}</p>
            <div className="mt-6 flex flex-wrap justify-center gap-3">
              <Link to={paths.languages} className="block-button inline-flex px-5 py-3 text-sm">
                {copy.backToLanguages}
              </Link>
            </div>
          </Card>
        ) : session.items.length === 0 ? (
          <Card className="p-8 text-center">
            <p className="minecraft-title text-2xl text-[#101114]">{copy.noItems}</p>
            <div className="mt-6 flex flex-wrap justify-center gap-3">
              {session.has_more ? (
                <button
                  type="button"
                  onClick={() => void goToNextSession()}
                  className="block-button inline-flex px-5 py-3 text-sm"
                >
                  {loadingMore ? copy.loadingMore : copy.loadMore}
                </button>
              ) : (
                <Link to={paths.languages} className="block-button inline-flex px-5 py-3 text-sm">
                  {copy.backToLanguages}
                </Link>
              )}
            </div>
          </Card>
        ) : currentItem ? (
          <>
            <div className="grid gap-6 xl:grid-cols-[1.08fr_.92fr]">
            <Card className="p-5 md:p-6">
              <div className="flex flex-wrap items-start justify-between gap-4">
                <div>
                  <p className="pixel-label text-[10px] text-[#566172]">{copy.preview}</p>
                  <h2 className="mt-2 text-2xl font-bold text-[#101114]">{currentItem.key_name}</h2>
                  <p className="mt-2 text-sm leading-7 text-[#566172]">
                    {renderHighlightedProtectedTerms(currentItem.original_text, currentItem.protected_terms)}
                  </p>
                </div>
                <Badge tone="accent">{copy.compatible}</Badge>
              </div>

              <div className="mt-6 grid gap-4 md:grid-cols-2">
                <div className="rounded-2xl border-2 border-[#101114] bg-[#f7f8fb] p-4">
                  <p className="pixel-label text-[10px] text-[#566172]">{copy.source}</p>
                  <p className="mt-2 text-lg font-bold text-[#101114]">{currentItem.source_language_name}</p>
                  <p className="mt-1 text-sm text-[#566172]">{currentItem.source_language_code}</p>
                </div>
                <div className="rounded-2xl border-2 border-[#101114] bg-[#f7f8fb] p-4">
                  <p className="pixel-label text-[10px] text-[#566172]">{copy.target}</p>
                  <p className="mt-2 text-lg font-bold text-[#101114]">{currentItem.target_language_name}</p>
                  <p className="mt-1 text-sm text-[#566172]">{currentItem.target_language_code}</p>
                </div>
              </div>

              <div className="mt-6 grid gap-4 md:grid-cols-3">
                <div className="rounded-2xl border border-[#dfe3ea] bg-white p-4">
                  <p className="pixel-label text-[10px] text-[#566172]">{copy.category}</p>
                  <p className="mt-2 text-base font-bold text-[#101114]">{formatCategoryLabel(currentItem.category)}</p>
                </div>
                <div className="rounded-2xl border border-[#dfe3ea] bg-white p-4">
                  <p className="pixel-label text-[10px] text-[#566172]">{copy.subcategory}</p>
                  <p className="mt-2 text-base font-bold text-[#101114]">
                    {currentItem.subcategory ? formatCategoryLabel(currentItem.subcategory) : '-'}
                  </p>
                </div>
                <div className="rounded-2xl border border-[#dfe3ea] bg-white p-4">
                  <p className="pixel-label text-[10px] text-[#566172]">{copy.context}</p>
                  <p className="mt-2 text-sm leading-6 text-[#101114]">{currentItem.context ?? '-'}</p>
                </div>
              </div>

              <div className="mt-6 grid gap-4 md:grid-cols-2">
                <div className="rounded-2xl border-2 border-[#101114] bg-white p-4">
                  <div className="flex items-center justify-between gap-3">
                    <p className="pixel-label text-[10px] text-[#566172]">{copy.autoSuggestion}</p>
                    <Badge tone="neutral">{currentItem.auto_suggestion?.status ?? 'none'}</Badge>
                  </div>
                  <p className="mt-3 text-sm leading-7 text-[#101114]">
                    {currentItem.auto_suggestion?.suggestion_text ?? copy.noSuggestion}
                  </p>
                </div>
                <div className="rounded-2xl border-2 border-[#101114] bg-white p-4">
                  <p className="pixel-label text-[10px] text-[#566172]">{copy.currentDraft}</p>
                  <p className="mt-3 text-sm leading-7 text-[#101114]">
                    {currentItem.my_suggestion?.suggestion_text ?? copy.noSuggestion}
                  </p>
                </div>
              </div>

              {duplicateLoading ? (
                <div className="mt-6 rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-4 text-sm text-[#566172]">
                  {locale === 'pt-BR' ? 'Verificando sugestoes equivalentes...' : locale === 'es' ? 'Verificando sugerencias equivalentes...' : 'Checking equivalent suggestions...'}
                </div>
              ) : duplicateSuggestion ? (
                <div className="mt-6 rounded-2xl border-2 border-[#101114] bg-[#fff8df] p-4">
                  <div className="flex flex-wrap items-center justify-between gap-3">
                    <p className="pixel-label text-[10px] text-[#8c5510]">{copy.duplicateTitle}</p>
                    <Badge tone="warning">{copy.duplicateEquivalent}</Badge>
                  </div>
                  <p className="mt-3 text-sm leading-7 text-[#101114]">{copy.duplicateDescription}</p>
                  <div className="mt-4 grid gap-3 md:grid-cols-2">
                    <div className="rounded-2xl border border-[#e59b32] bg-white p-4">
                      <p className="pixel-label text-[10px] text-[#566172]">{copy.duplicateAuthor}</p>
                      <p className="mt-2 text-sm font-bold text-[#101114]">{duplicateSuggestion.author_name ?? duplicateSuggestion.author_username ?? '-'}</p>
                      <p className="mt-2 text-xs text-[#566172]">{formatTimestamp(duplicateSuggestion.created_at, locale)}</p>
                    </div>
                    <div className="rounded-2xl border border-[#e59b32] bg-white p-4">
                      <p className="pixel-label text-[10px] text-[#566172]">{copy.duplicateHint}</p>
                      <p className="mt-2 text-sm leading-7 text-[#101114]">{duplicateSuggestion.suggestion_text}</p>
                    </div>
                  </div>
                  <div className="mt-4 flex flex-wrap gap-3">
                    <button
                      type="button"
                      onClick={() => void handleAgree()}
                      disabled={submitting}
                      className="rounded-2xl border-2 border-[#101114] bg-white px-4 py-3 font-[var(--font-display)] text-sm font-bold text-[#101114] transition hover:-translate-y-1 hover:shadow-[4px_4px_0_#101114] disabled:cursor-not-allowed disabled:opacity-60"
                    >
                      {copy.duplicateAgree}
                    </button>
                    <button
                      type="button"
                      onClick={() => void handleSubmit({ supersedesSuggestionId: duplicateSuggestion.suggestion_id })}
                    disabled={submitting || translation.trim().length === 0 || hasValidationWarning}
                      className="rounded-2xl border-2 border-[#101114] bg-[#c7f464] px-4 py-3 font-[var(--font-display)] text-sm font-bold text-[#101114] transition hover:-translate-y-1 hover:shadow-[4px_4px_0_#101114] disabled:cursor-not-allowed disabled:opacity-60"
                    >
                      {submitting ? copy.submitting : copy.duplicateImprove}
                    </button>
                  </div>
                </div>
              ) : null}

              <div className="mt-6 rounded-2xl border-2 border-[#101114] bg-[#f7f8fb] p-4">
                <div className="flex flex-wrap items-center justify-between gap-3">
                  <p className="pixel-label text-[10px] text-[#566172]">{copy.contextPack}</p>
                  <Badge tone="neutral">{copy.placeholderGuardTitle}</Badge>
                </div>
                <div className="mt-4 grid gap-4 md:grid-cols-2">
                  <div className="rounded-2xl border border-[#dfe3ea] bg-white p-4">
                    <p className="pixel-label text-[10px] text-[#566172]">{copy.sourceOriginal}</p>
                    <p className="mt-2 text-sm leading-7 text-[#101114]">
                      {renderHighlightedProtectedTerms(currentItem.original_text, currentItem.protected_terms)}
                    </p>
                  </div>
                  <div className="rounded-2xl border border-[#dfe3ea] bg-white p-4">
                    <p className="pixel-label text-[10px] text-[#566172]">{copy.placeholderGuardPreserve}</p>
                    <div className="mt-3 flex flex-wrap gap-2">
                      {(placeholderValidation?.required ?? []).length > 0 ? (
                        placeholderValidation?.required.map((token) => (
                          <Badge key={token} tone={hasPlaceholderWarning ? 'warning' : 'success'}>
                            {token}
                          </Badge>
                        ))
                      ) : (
                        <span className="text-sm text-[#566172]">{copy.noSuggestion}</span>
                      )}
                    </div>
                  </div>
                </div>
                <div className="mt-4 grid gap-4 md:grid-cols-3">
                  <div className="rounded-2xl border border-[#dfe3ea] bg-white p-4">
                    <p className="pixel-label text-[10px] text-[#566172]">{copy.category}</p>
                    <p className="mt-2 text-sm font-bold text-[#101114]">{formatCategoryLabel(currentItem.category)}</p>
                  </div>
                  <div className="rounded-2xl border border-[#dfe3ea] bg-white p-4">
                    <p className="pixel-label text-[10px] text-[#566172]">{copy.subcategory}</p>
                    <p className="mt-2 text-sm font-bold text-[#101114]">
                      {currentItem.subcategory ? formatCategoryLabel(currentItem.subcategory) : '-'}
                    </p>
                  </div>
                  <div className="rounded-2xl border border-[#dfe3ea] bg-white p-4">
                    <p className="pixel-label text-[10px] text-[#566172]">{copy.context}</p>
                    <p className="mt-2 text-sm leading-6 text-[#101114]">{currentItem.context ?? '-'}</p>
                  </div>
                </div>
                {hasPlaceholderWarning ? (
                  <div className="mt-4 rounded-2xl border border-[#ff7b72] bg-[#fff4f2] p-4 text-sm text-[#b42318]">
                    <p className="font-bold">{copy.placeholderGuardBlocked}</p>
                    {placeholderValidation?.missing.length ? (
                      <p className="mt-2">
                        {copy.placeholderGuardMissing} {placeholderValidation.missing.join(', ')}
                      </p>
                    ) : null}
                    {placeholderValidation?.extra.length ? (
                      <p className="mt-2">
                        {copy.placeholderGuardExtra} {placeholderValidation.extra.join(', ')}
                      </p>
                    ) : null}
                  </div>
                ) : null}
                {hasProtectedTermWarning ? (
                  <div className="mt-4 rounded-2xl border border-[#e59b32] bg-[#fff8df] p-4 text-sm text-[#8c5510]">
                    <p className="font-bold">{copy.protectedTermGuardBlocked}</p>
                    {protectedTermsValidation?.missing.length ? (
                      <p className="mt-2">
                        {copy.protectedTermGuardMissing} {protectedTermsValidation.missing.join(', ')}
                      </p>
                    ) : null}
                    {protectedTermsValidation?.modified.length ? (
                      <p className="mt-2">
                        {copy.protectedTermGuardModified} {protectedTermsValidation.modified.join(', ')}
                      </p>
                    ) : null}
                  </div>
                ) : null}
              </div>

              <div className="mt-6 grid gap-4 md:grid-cols-2">
                <div className="rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-4">
                  <p className="pixel-label text-[10px] text-[#566172]">{copy.protectedVars}</p>
                  <p className="mt-2 text-sm leading-7 text-[#101114]">{formatList(currentItem.protected_variables)}</p>
                </div>
                <div className="rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-4">
                  <p className="pixel-label text-[10px] text-[#566172]">{copy.protectedTerms}</p>
                  <p className="mt-2 text-[11px] font-bold uppercase tracking-[0.24em] text-[#8c5510]">
                    {copy.protectedTermGuardPreserve}
                  </p>
                  <div className="mt-3 flex flex-wrap gap-2">
                    {currentItem.protected_terms.length > 0 ? (
                      currentItem.protected_terms.map((term) => {
                        const modified = protectedTermsValidation?.modified.includes(term) ?? false;
                        const missing = protectedTermsValidation?.missing.includes(term) ?? false;

                        return (
                          <Badge key={term} tone={missing ? 'danger' : modified ? 'warning' : 'success'}>
                            {term}
                          </Badge>
                        );
                      })
                    ) : (
                      <span className="text-sm text-[#101114]">-</span>
                    )}
                  </div>
                </div>
              </div>

              <div className="mt-6 rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-4">
                <div className="flex flex-wrap items-center justify-between gap-3">
                  <p className="pixel-label text-[10px] text-[#566172]">{copy.glossary}</p>
                  <Badge tone="success">{copy.glossaryFound}</Badge>
                </div>
                <div className="mt-4 grid gap-3">
                  {currentItem.glossary_terms.length > 0 ? (
                    currentItem.glossary_terms.map((term) => (
                      <div key={term.id} className="rounded-2xl border border-[#dfe3ea] bg-white p-4 shadow-[4px_4px_0_rgba(16,17,20,.06)]">
                        <div className="flex flex-wrap items-start justify-between gap-3">
                          <div>
                            <p className="font-[var(--font-display)] text-sm font-bold text-[#101114]">{term.original_term}</p>
                            <p className="mt-1 text-sm text-[#566172]">
                              {copy.glossaryRecommended}: <span className="font-bold text-[#101114]">{term.recommended_translation}</span>
                            </p>
                          </div>
                          <div className="flex flex-wrap gap-2">
                            <Badge tone={term.do_not_translate ? 'warning' : 'neutral'}>
                              {term.do_not_translate ? copy.glossaryProtected : term.category}
                            </Badge>
                            {term.match_reason ? <Badge tone="success">{`${copy.glossaryMatchedAs}: ${formatMatchReason(term.match_reason)}`}</Badge> : null}
                          </div>
                        </div>
                        {term.rule ? (
                          <p className="mt-3 text-sm leading-6 text-[#566172]">
                            <span className="font-bold text-[#101114]">{copy.glossaryRule}:</span> {term.rule}
                          </p>
                        ) : null}
                        {term.notes ? (
                          <p className="mt-2 text-sm leading-6 text-[#566172]">
                            <span className="font-bold text-[#101114]">{copy.glossaryNotes}:</span> {term.notes}
                          </p>
                        ) : null}
                        {term.aliases.length > 0 ? (
                          <div className="mt-3 flex flex-wrap gap-2">
                            {term.aliases.map((alias) => (
                              <Badge key={`${term.id}-${alias}`} tone="neutral">
                                {alias}
                              </Badge>
                            ))}
                          </div>
                        ) : null}
                      </div>
                    ))
                  ) : (
                    <p className="text-sm text-[#566172]">{copy.glossaryNoMatches}</p>
                  )}
                </div>
              </div>
            </Card>

            <Card className="p-5 md:p-6">
              <div className="flex flex-wrap items-center justify-between gap-3">
                <div>
                  <p className="pixel-label text-[10px] text-[#566172]">{copy.sessionLabel}</p>
                  <h2 className="mt-2 text-2xl font-bold text-[#101114]">{copy.translationField}</h2>
                </div>
                <Badge tone="success">{progressLabel}</Badge>
              </div>

              <div className="mt-5 space-y-4">
                <label className="block">
                  <span className="pixel-label text-[10px] text-[#566172]">{copy.translationField}</span>
                  <textarea
                    value={translation}
                    onChange={(event) => setTranslation(event.target.value)}
                    placeholder={currentItem.auto_suggestion?.suggestion_text ?? ''}
                    className={textareaClassName()}
                  />
                </label>

                <label className="block">
                  <span className="pixel-label text-[10px] text-[#566172]">{copy.rationaleField}</span>
                  <textarea
                    value={rationale}
                    onChange={(event) => setRationale(event.target.value)}
                    placeholder={locale === 'pt-BR' ? 'Explique escolhas de contexto, tom ou termo' : locale === 'es' ? 'Explica elecciones de contexto, tono o termino' : 'Explain context, tone, or terminology choices'}
                    className="min-h-[96px] w-full rounded-2xl border-2 border-[#dfe3ea] bg-white px-4 py-3 text-sm text-[#101114] outline-none transition placeholder:text-[#8a94a6] focus:border-[#5652ff]"
                  />
                </label>

                <label className="block">
                  <span className="pixel-label text-[10px] text-[#566172]">{copy.notesField}</span>
                  <textarea
                    value={notes}
                    onChange={(event) => setNotes(event.target.value)}
                    placeholder={locale === 'pt-BR' ? 'Observacoes internas ou duvidas' : locale === 'es' ? 'Notas internas o dudas' : 'Internal notes or questions'}
                    className="min-h-[96px] w-full rounded-2xl border-2 border-[#dfe3ea] bg-white px-4 py-3 text-sm text-[#101114] outline-none transition placeholder:text-[#8a94a6] focus:border-[#5652ff]"
                  />
                </label>
              </div>

              <div className="mt-6 grid gap-3 sm:grid-cols-2">
                <button
                  type="button"
                  onClick={() => void handleSkip()}
                  className="rounded-2xl border-2 border-[#101114] bg-white px-4 py-3 font-[var(--font-display)] text-sm font-bold text-[#101114] transition hover:-translate-y-1 hover:shadow-[4px_4px_0_#101114]"
                >
                  {copy.skip}
                </button>
                <button
                  type="button"
                  onClick={() => void handleSubmit(duplicateSuggestion ? { supersedesSuggestionId: duplicateSuggestion.suggestion_id } : undefined)}
                  disabled={submitting || translation.trim().length === 0 || hasValidationWarning}
                  className="rounded-2xl border-2 border-[#101114] bg-[#c7f464] px-4 py-3 font-[var(--font-display)] text-sm font-bold text-[#101114] transition hover:-translate-y-1 hover:shadow-[4px_4px_0_#101114] disabled:cursor-not-allowed disabled:opacity-60"
                >
                  {submitting ? copy.submitting : duplicateSuggestion ? copy.duplicateImprove : copy.submit}
                </button>
              </div>

              <div className="mt-6 rounded-2xl border-2 border-[#101114] bg-[#101114] p-4 text-white">
                <div className="flex items-center justify-between gap-3">
                  <p className="pixel-label text-[10px] text-[#c7f464]">{copy.batchProgress}</p>
                  <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">
                    {progressLabel}
                  </Badge>
                </div>
                <div className="mt-4 grid grid-cols-3 gap-3">
                  <div className="rounded-xl border border-white/10 bg-white/5 p-3.5">
                    <p className="text-[10px] uppercase tracking-[0.28em] text-white/50">{copy.translated}</p>
                    <p className="mt-2 text-2xl font-bold">{submittedCount}</p>
                  </div>
                  <div className="rounded-xl border border-white/10 bg-white/5 p-3.5">
                    <p className="text-[10px] uppercase tracking-[0.28em] text-white/50">{copy.skipped}</p>
                    <p className="mt-2 text-2xl font-bold">{skippedCount}</p>
                  </div>
                  <div className="rounded-xl border border-white/10 bg-white/5 p-3.5">
                    <p className="text-[10px] uppercase tracking-[0.28em] text-white/50">{copy.remaining}</p>
                    <p className="mt-2 text-2xl font-bold">{remainingCount}</p>
                  </div>
                </div>
              </div>

              <div className="mt-6 flex flex-wrap gap-3">
                <Link to={paths.languages} className="block-button-secondary inline-flex px-5 py-3 text-sm">
                  {copy.backToLanguages}
                </Link>
                {languageCode ? (
                  <Link
                    to={paths.languageDetail.replace(':code', encodeURIComponent(languageCode))}
                    className="rounded-xl border-2 border-[#101114] px-5 py-3 font-[var(--font-display)] text-sm font-bold text-[#101114] transition hover:-translate-y-1 hover:shadow-[4px_4px_0_#101114]"
                  >
                    {copy.openLanguage}
                  </Link>
                ) : null}
                {session.has_more ? (
                  <button
                    type="button"
                    onClick={() => void goToNextSession()}
                    className="rounded-xl border-2 border-[#101114] bg-white px-5 py-3 font-[var(--font-display)] text-sm font-bold text-[#101114] transition hover:-translate-y-1 hover:shadow-[4px_4px_0_#101114]"
                  >
                    {loadingMore ? copy.loadingMore : copy.loadMore}
                  </button>
                ) : null}
              </div>
            </Card>
          </div>

          <Card className="overflow-hidden border-2 border-[#101114] bg-[#fbfcfe] p-0">
            <div className="border-b border-[#dfe3ea] bg-[linear-gradient(180deg,#fcfdff_0%,#f4f7fb_100%)] px-5 py-4 md:px-6">
              <div className="flex flex-wrap items-center justify-between gap-4">
                <div className="min-w-0">
                  <p className="pixel-label text-[10px] text-[#566172]">Community intake</p>
                  <h2 className="mt-2 text-2xl font-bold text-[#101114]">Suggest new phrases</h2>
                  <p className="mt-2 max-w-2xl text-sm leading-7 text-[#566172]">
                    Lightweight intake for approved English phrases. Keep it open only when you want to add or review proposal drafts.
                  </p>
                </div>
                <div className="flex flex-wrap items-center gap-2">
                  <Badge tone="success">{`${translationSeed.strings.length} ready strings`}</Badge>
                  <Badge tone="neutral">{`${translationSeed.proposal_rules.length} rules`}</Badge>
                  <button
                    type="button"
                    onClick={() => setShowCommunityIntake((value) => !value)}
                    className="rounded-2xl border-2 border-[#101114] bg-white px-4 py-2.5 font-[var(--font-display)] text-sm font-bold text-[#101114] transition hover:-translate-y-1 hover:shadow-[4px_4px_0_#101114]"
                  >
                    {showCommunityIntake ? 'Hide intake' : 'Open intake'}
                  </button>
                </div>
              </div>
            </div>

            <div className="px-5 py-5 md:px-6 md:py-6">
              {showCommunityIntake ? (
                <div className="grid gap-4 xl:grid-cols-[minmax(0,1fr)_360px]">
                  <div className="rounded-3xl border border-[#dfe3ea] bg-white/90 p-4 shadow-[0_12px_40px_rgba(16,17,20,0.04)] md:p-5">
                    <div className="grid gap-4 md:grid-cols-2">
                      <label className="block md:col-span-2">
                        <span className="pixel-label text-[10px] text-[#566172]">English source text</span>
                        <textarea
                          value={communityProposalForm.source_text}
                          onChange={(event) => setCommunityProposalForm((current) => ({ ...current, source_text: event.target.value }))}
                          placeholder="Example: The server is restarting in {minutes} minutes."
                          className="min-h-[96px] w-full rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] px-4 py-3 text-sm text-[#101114] outline-none transition placeholder:text-[#8a94a6] focus:border-[#5652ff]"
                        />
                      </label>

                      <label className="block">
                        <span className="pixel-label text-[10px] text-[#566172]">Key name</span>
                        <input
                          value={communityProposalForm.key_name}
                          onChange={(event) => setCommunityProposalForm((current) => ({ ...current, key_name: event.target.value }))}
                          placeholder="minecraft.server.restart"
                          className="w-full rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] px-4 py-3 text-sm text-[#101114] outline-none transition placeholder:text-[#8a94a6] focus:border-[#5652ff]"
                        />
                      </label>

                      <label className="block">
                        <span className="pixel-label text-[10px] text-[#566172]">Theme</span>
                        <input
                          value={communityProposalForm.theme}
                          onChange={(event) => setCommunityProposalForm((current) => ({ ...current, theme: event.target.value }))}
                          placeholder="minecraft / community / review"
                          className="w-full rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] px-4 py-3 text-sm text-[#101114] outline-none transition placeholder:text-[#8a94a6] focus:border-[#5652ff]"
                        />
                      </label>

                      <label className="block">
                        <span className="pixel-label text-[10px] text-[#566172]">Category</span>
                        <input
                          value={communityProposalForm.category}
                          onChange={(event) => setCommunityProposalForm((current) => ({ ...current, category: event.target.value }))}
                          placeholder="minecraft / home / onboarding"
                          className="w-full rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] px-4 py-3 text-sm text-[#101114] outline-none transition placeholder:text-[#8a94a6] focus:border-[#5652ff]"
                        />
                      </label>

                      <label className="block">
                        <span className="pixel-label text-[10px] text-[#566172]">Subcategory</span>
                        <input
                          value={communityProposalForm.subcategory}
                          onChange={(event) => setCommunityProposalForm((current) => ({ ...current, subcategory: event.target.value }))}
                          placeholder="chat / hero / validation"
                          className="w-full rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] px-4 py-3 text-sm text-[#101114] outline-none transition placeholder:text-[#8a94a6] focus:border-[#5652ff]"
                        />
                      </label>

                      <label className="block">
                        <span className="pixel-label text-[10px] text-[#566172]">Target languages</span>
                        <div className="mt-3 flex flex-wrap gap-2">
                          {translationSeed.languages.map((language) => {
                            const active = communityProposalForm.target_languages.includes(language.code);

                            return (
                              <button
                                key={language.code}
                                type="button"
                                onClick={() => handleProposalTargetToggle(language.code)}
                                className={`rounded-full border-2 px-3 py-2 text-xs font-bold transition ${
                                  active
                                    ? 'border-[#101114] bg-[#c7f464] text-[#101114]'
                                    : 'border-[#dfe3ea] bg-white text-[#566172]'
                                }`}
                              >
                                {language.code}
                              </button>
                            );
                          })}
                        </div>
                      </label>

                      <label className="block md:col-span-2">
                        <span className="pixel-label text-[10px] text-[#566172]">Context</span>
                        <textarea
                          value={communityProposalForm.context}
                          onChange={(event) => setCommunityProposalForm((current) => ({ ...current, context: event.target.value }))}
                          placeholder="Where this string appears, who sees it, and what tone it should use."
                          className="min-h-[110px] w-full rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] px-4 py-3 text-sm text-[#101114] outline-none transition placeholder:text-[#8a94a6] focus:border-[#5652ff]"
                        />
                      </label>

                      <label className="block md:col-span-2">
                        <span className="pixel-label text-[10px] text-[#566172]">Notes</span>
                        <textarea
                          value={communityProposalForm.notes}
                          onChange={(event) => setCommunityProposalForm((current) => ({ ...current, notes: event.target.value }))}
                          placeholder="Tone hints, length hints, or extra implementation details."
                          className="min-h-[96px] w-full rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] px-4 py-3 text-sm text-[#101114] outline-none transition placeholder:text-[#8a94a6] focus:border-[#5652ff]"
                        />
                      </label>

                      <label className="block">
                        <span className="pixel-label text-[10px] text-[#566172]">Protected variables</span>
                        <input
                          value={communityProposalForm.protected_variables}
                          onChange={(event) => setCommunityProposalForm((current) => ({ ...current, protected_variables: event.target.value }))}
                          placeholder="{player}, {amount}, %s"
                          className="w-full rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] px-4 py-3 text-sm text-[#101114] outline-none transition placeholder:text-[#8a94a6] focus:border-[#5652ff]"
                        />
                      </label>

                      <label className="block">
                        <span className="pixel-label text-[10px] text-[#566172]">Protected terms</span>
                        <input
                          value={communityProposalForm.protected_terms}
                          onChange={(event) => setCommunityProposalForm((current) => ({ ...current, protected_terms: event.target.value }))}
                          placeholder="XP, TPS, Discord"
                          className="w-full rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] px-4 py-3 text-sm text-[#101114] outline-none transition placeholder:text-[#8a94a6] focus:border-[#5652ff]"
                        />
                      </label>
                    </div>

                    <div className="mt-5 flex flex-wrap gap-3">
                      <button
                        type="button"
                        onClick={handleAddCommunityProposal}
                        className="rounded-2xl border-2 border-[#101114] bg-[#c7f464] px-4 py-3 font-[var(--font-display)] text-sm font-bold text-[#101114] transition hover:-translate-y-1 hover:shadow-[4px_4px_0_#101114]"
                      >
                        Save proposal
                      </button>
                      <button
                        type="button"
                        onClick={exportCommunityProposals}
                        className="rounded-2xl border-2 border-[#101114] bg-white px-4 py-3 font-[var(--font-display)] text-sm font-bold text-[#101114] transition hover:-translate-y-1 hover:shadow-[4px_4px_0_#101114]"
                      >
                        Export JSON
                      </button>
                    </div>
                  </div>

                  <div className="space-y-4">
                    <div className="rounded-3xl border border-[#dfe3ea] bg-white/90 p-4 shadow-[0_12px_40px_rgba(16,17,20,0.04)]">
                      <p className="pixel-label text-[10px] text-[#566172]">Proposal rules</p>
                      <div className="mt-4 grid gap-3">
                        {translationSeed.proposal_rules.map((rule) => (
                          <div key={rule.id} className="rounded-2xl border border-[#edf0f4] bg-[#fbfcfe] p-4">
                            <p className="text-sm font-bold text-[#101114]">{rule.title}</p>
                            <p className="mt-2 text-sm leading-6 text-[#566172]">{rule.description}</p>
                          </div>
                        ))}
                      </div>
                    </div>

                    <div className="rounded-3xl border border-[#dfe3ea] bg-white/90 p-4 shadow-[0_12px_40px_rgba(16,17,20,0.04)]">
                      <div className="flex items-center justify-between gap-3">
                        <p className="pixel-label text-[10px] text-[#566172]">Saved proposals</p>
                        <Badge tone="accent">{communityProposals.length}</Badge>
                      </div>
                      <div className="mt-4 space-y-3">
                        {communityProposals.length > 0 ? (
                          communityProposals.map((proposal) => (
                            <div key={proposal.id} className="rounded-2xl border border-[#edf0f4] bg-[#fbfcfe] p-4">
                              <p className="text-sm font-bold text-[#101114]">{proposal.source_text}</p>
                              <p className="mt-2 text-xs uppercase tracking-[0.24em] text-[#566172]">
                                {proposal.theme} / {proposal.category}
                              </p>
                              <p className="mt-2 text-sm leading-6 text-[#566172]">{proposal.context}</p>
                              <div className="mt-3 flex flex-wrap gap-2">
                                {proposal.target_languages.map((code) => (
                                  <Badge key={`${proposal.id}-${code}`} tone="neutral">
                                    {code}
                                  </Badge>
                                ))}
                              </div>
                            </div>
                          ))
                        ) : (
                          <p className="text-sm leading-7 text-[#566172]">
                            No community proposals yet. Add a phrase and export the JSON when you want to move it into the admin pipeline.
                          </p>
                        )}
                      </div>
                    </div>
                  </div>
                </div>
              ) : (
                <div className="grid gap-3 md:grid-cols-3">
                  <div className="rounded-3xl border border-[#dfe3ea] bg-white/85 p-4">
                    <p className="pixel-label text-[10px] text-[#566172]">Ready strings</p>
                    <p className="mt-2 text-2xl font-extrabold text-[#101114]">{translationSeed.strings.length}</p>
                    <p className="mt-2 text-sm leading-6 text-[#566172]">Seed phrases are grouped by theme, category, and context.</p>
                  </div>
                  <div className="rounded-3xl border border-[#dfe3ea] bg-white/85 p-4">
                    <p className="pixel-label text-[10px] text-[#566172]">Proposal rules</p>
                    <p className="mt-2 text-2xl font-extrabold text-[#101114]">{translationSeed.proposal_rules.length}</p>
                    <p className="mt-2 text-sm leading-6 text-[#566172]">New phrases keep English source, context, and protected tokens.</p>
                  </div>
                  <div className="rounded-3xl border border-[#dfe3ea] bg-white/85 p-4">
                    <p className="pixel-label text-[10px] text-[#566172]">Local drafts</p>
                    <p className="mt-2 text-2xl font-extrabold text-[#101114]">{communityProposals.length}</p>
                    <p className="mt-2 text-sm leading-6 text-[#566172]">Your ideas stay local until you export the JSON.</p>
                  </div>
                </div>
              )}
            </div>
          </Card>
          </>
        ) : null}
      </div>
    </PageShell>
  );
}
