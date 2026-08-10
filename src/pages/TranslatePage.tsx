import { useEffect, useMemo, useState } from 'react';
import { Link, useSearchParams } from 'react-router-dom';
import { Badge } from '@/components/ui/Badge';
import { Card } from '@/components/ui/Card';
import { PageShell } from '@/components/page/PageShell';
import { useLocale } from '@/hooks/useLocale';
import { paths } from '@/navigation/paths';
import {
  fetchTranslationWorkspaceSession,
  submitTranslationWorkspaceSuggestion,
  type TranslationWorkspaceSession
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
  glossary: string;
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
    glossary: 'Glossario',
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
    glossary: 'Glossary',
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
    glossary: 'Glosario',
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
  }
};

function formatCategoryLabel(value: string) {
  return value
    .replace(/_/g, ' ')
    .replace(/\b\w/g, (char) => char.toUpperCase());
}

function formatList(values: string[]) {
  return values.length > 0 ? values.join(', ') : '-';
}

function textareaClassName() {
  return 'min-h-[140px] w-full rounded-2xl border-2 border-[#101114] bg-white px-4 py-3 text-sm text-[#101114] outline-none transition placeholder:text-[#8a94a6] focus:border-[#5652ff]';
}

export function TranslatePage() {
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

  const currentItem = session?.items[activeIndex] ?? null;

  async function loadSession(offset = 0, nextSession = false) {
    try {
      setError(null);
      setLoading(nextSession ? false : true);
      setLoadingMore(nextSession);

      const result = await fetchTranslationWorkspaceSession({
        targetLanguageCode: languageCode || null,
        categorySlug: categorySlug || null,
        batchSize: 10,
        sessionOffset: offset
      });

      setSession(result);
      setActiveIndex(0);
      setSubmittedCount(0);
      setSkippedCount(0);

      const firstItem = result?.items[0] ?? null;
      setTranslation(firstItem?.my_suggestion?.suggestion_text ?? firstItem?.auto_suggestion?.suggestion_text ?? '');
      setRationale(firstItem?.my_suggestion?.rationale ?? '');
      setNotes(firstItem?.my_suggestion?.notes ?? '');
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
  }, [languageCode, categorySlug]);

  useEffect(() => {
    if (!currentItem) {
      return;
    }

    setTranslation(currentItem.my_suggestion?.suggestion_text ?? currentItem.auto_suggestion?.suggestion_text ?? '');
    setRationale(currentItem.my_suggestion?.rationale ?? '');
    setNotes(currentItem.my_suggestion?.notes ?? '');
  }, [currentItem]);

  const progressLabel = useMemo(() => {
    if (!session) {
      return '0/0';
    }

    return `${Math.min(activeIndex + 1, session.loaded_count)}/${session.loaded_count}`;
  }, [activeIndex, session]);

  const processedCount = submittedCount + skippedCount;
  const remainingCount = session ? Math.max(session.loaded_count - processedCount, 0) : 0;

  async function goToNextSession() {
    if (!session?.has_more) {
      return;
    }

    await loadSession(session.session_offset + session.batch_size, true);
  }

  async function handleSubmit() {
    if (!session || !currentItem || translation.trim().length === 0) {
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
        notes: notes.trim().length > 0 ? notes : null
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

  const sessionBadge = categorySlug ? formatCategoryLabel(categorySlug) : copy.complete;

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
          <div className="grid gap-6 xl:grid-cols-[1.08fr_.92fr]">
            <Card className="p-5 md:p-6">
              <div className="flex flex-wrap items-start justify-between gap-4">
                <div>
                  <p className="pixel-label text-[10px] text-[#566172]">{copy.preview}</p>
                  <h2 className="mt-2 text-2xl font-bold text-[#101114]">{currentItem.key_name}</h2>
                  <p className="mt-2 text-sm leading-7 text-[#566172]">{currentItem.original_text}</p>
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

              <div className="mt-6 grid gap-4 md:grid-cols-2">
                <div className="rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-4">
                  <p className="pixel-label text-[10px] text-[#566172]">{copy.protectedVars}</p>
                  <p className="mt-2 text-sm leading-7 text-[#101114]">{formatList(currentItem.protected_variables)}</p>
                </div>
                <div className="rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-4">
                  <p className="pixel-label text-[10px] text-[#566172]">{copy.protectedTerms}</p>
                  <p className="mt-2 text-sm leading-7 text-[#101114]">{formatList(currentItem.protected_terms)}</p>
                </div>
              </div>

              <div className="mt-6 rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-4">
                <p className="pixel-label text-[10px] text-[#566172]">{copy.glossary}</p>
                <div className="mt-4 grid gap-3">
                  {currentItem.glossary_terms.length > 0 ? (
                    currentItem.glossary_terms.map((term) => (
                      <div key={term.id} className="rounded-2xl border border-[#dfe3ea] bg-white p-4">
                        <div className="flex flex-wrap items-center justify-between gap-3">
                          <p className="font-[var(--font-display)] text-sm font-bold text-[#101114]">{term.term}</p>
                          <Badge tone="neutral">{term.category}</Badge>
                        </div>
                        <p className="mt-2 text-sm leading-6 text-[#566172]">{term.definition}</p>
                      </div>
                    ))
                  ) : (
                    <p className="text-sm text-[#566172]">{copy.noSuggestion}</p>
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
                  onClick={() => void handleSubmit()}
                  disabled={submitting || translation.trim().length === 0}
                  className="rounded-2xl border-2 border-[#101114] bg-[#c7f464] px-4 py-3 font-[var(--font-display)] text-sm font-bold text-[#101114] transition hover:-translate-y-1 hover:shadow-[4px_4px_0_#101114] disabled:cursor-not-allowed disabled:opacity-60"
                >
                  {submitting ? copy.submitting : copy.submit}
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
        ) : null}
      </div>
    </PageShell>
  );
}
