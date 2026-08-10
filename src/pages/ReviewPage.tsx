import { useEffect, useMemo, useState } from 'react';
import { Link, useSearchParams } from 'react-router-dom';
import { Badge } from '@/components/ui/Badge';
import { Card } from '@/components/ui/Card';
import { PageShell } from '@/components/page/PageShell';
import { useLocale } from '@/hooks/useLocale';
import { paths } from '@/navigation/paths';
import {
  fetchReviewWorkspaceSession,
  submitReviewWorkspaceDecision,
  type ReviewWorkspaceConfidence,
  type ReviewWorkspaceItem,
  type ReviewWorkspaceSession
} from '@/services/reviewWorkspace';

type Copy = {
  eyebrow: string;
  title: string;
  description: string;
  sessionLabel: string;
  loading: string;
  error: string;
  noSession: string;
  noItems: string;
  source: string;
  target: string;
  category: string;
  subcategory: string;
  context: string;
  contextPack: string;
  suggestion: string;
  glossary: string;
  placeholders: string;
  reviewHistory: string;
  otherSuggestions: string;
  reviewNotes: string;
  correctionText: string;
  approve: string;
  needsChanges: string;
  reject: string;
  suggestCorrection: string;
  submitting: string;
  loadingMore: string;
  loadMore: string;
  backToLanguages: string;
  batchProgress: string;
  totalAvailable: string;
  remaining: string;
  pending: string;
  approved: string;
  needsChangesCount: string;
  rejected: string;
  compatible: string;
  confidence: string;
  confidenceRule: string;
  confidenceLevel: string;
  confidenceScore: string;
  confidenceReviews: string;
  confidenceAgreement: string;
  confidenceTrust: string;
  confidenceReports: string;
  confidenceVerifiedReady: string;
  notesRequired: string;
  correctionRequired: string;
  noReviewHistory: string;
  noOtherSuggestions: string;
};

const copyByLocale: Record<'pt-BR' | 'en' | 'es', Copy> = {
  'pt-BR': {
    eyebrow: 'Revisar',
    title: 'Review Workspace',
    description: 'Fila segura de traducoes pendentes para revisar com contexto, historico e sugestoes relacionadas.',
    sessionLabel: 'Sessao de revisao',
    loading: 'Carregando fila de revisao...',
    error: 'Nao foi possivel carregar a fila de revisao.',
    noSession: 'Escolha um idioma para abrir uma fila de revisao.',
    noItems: 'Nao ha traducoes pendentes nesta fila agora.',
    source: 'Origem',
    target: 'Destino',
    category: 'Categoria',
    subcategory: 'Subcategoria',
    context: 'Contexto',
    contextPack: 'Context Pack',
    suggestion: 'Traducao proposta',
    glossary: 'Glossario relevante',
    placeholders: 'Placeholders',
    reviewHistory: 'Historico de revisoes',
    otherSuggestions: 'Outras sugestoes',
    reviewNotes: 'Comentario da revisao',
    correctionText: 'Suggest Correction',
    approve: 'Approve',
    needsChanges: 'Needs Changes',
    reject: 'Reject',
    suggestCorrection: 'Suggest Correction',
    submitting: 'Enviando...',
    loadingMore: 'Carregando mais...',
    loadMore: 'Carregar proxima sessao',
    backToLanguages: 'Voltar para idiomas',
    batchProgress: 'Progresso do lote',
    totalAvailable: 'Disponiveis',
    remaining: 'Restantes',
    pending: 'Pendentes',
    approved: 'Aprovadas',
    needsChangesCount: 'Com ajustes',
    rejected: 'Rejeitadas',
    compatible: 'Compativel com sua funcao',
    confidence: 'Confidence de traducao',
    confidenceRule: 'Regra transparente: volume de revisoes validas + concordancia + reputacao dos revisores - reports abertos. Nao e IA.',
    confidenceLevel: 'Nivel',
    confidenceScore: 'Pontuacao',
    confidenceReviews: 'Revisoes validas',
    confidenceAgreement: 'Concordancia',
    confidenceTrust: 'Confianca dos revisores',
    confidenceReports: 'Reports abertos',
    confidenceVerifiedReady: 'Pronto para VERIFIED',
    notesRequired: 'Um comentario e necessario para essa decisao.',
    correctionRequired: 'Digite uma sugestao corrigida para continuar.',
    noReviewHistory: 'Ainda sem historico de revisoes.',
    noOtherSuggestions: 'Nenhuma outra sugestao relacionada encontrada.',
  },
  en: {
    eyebrow: 'Review',
    title: 'Review Workspace',
    description: 'Secure queue of pending translations with context, history, and related suggestions.',
    sessionLabel: 'Review session',
    loading: 'Loading review queue...',
    error: 'Unable to load the review queue.',
    noSession: 'Choose a language to open a review queue.',
    noItems: 'There are no pending translations in this queue right now.',
    source: 'Source',
    target: 'Target',
    category: 'Category',
    subcategory: 'Subcategory',
    context: 'Context',
    contextPack: 'Context Pack',
    suggestion: 'Suggested translation',
    glossary: 'Relevant glossary',
    placeholders: 'Placeholders',
    reviewHistory: 'Review history',
    otherSuggestions: 'Other suggestions',
    reviewNotes: 'Review comment',
    correctionText: 'Suggest Correction',
    approve: 'Approve',
    needsChanges: 'Needs Changes',
    reject: 'Reject',
    suggestCorrection: 'Suggest Correction',
    submitting: 'Submitting...',
    loadingMore: 'Loading more...',
    loadMore: 'Load next session',
    backToLanguages: 'Back to languages',
    batchProgress: 'Batch progress',
    totalAvailable: 'Available',
    remaining: 'Remaining',
    pending: 'Pending',
    approved: 'Approved',
    needsChangesCount: 'Needs changes',
    rejected: 'Rejected',
    compatible: 'Compatible with your role',
    confidence: 'Translation confidence',
    confidenceRule: 'Transparent rule: valid review volume + agreement + reviewer reputation - open reports. This is not AI.',
    confidenceLevel: 'Level',
    confidenceScore: 'Score',
    confidenceReviews: 'Valid reviews',
    confidenceAgreement: 'Agreement',
    confidenceTrust: 'Reviewer trust',
    confidenceReports: 'Open reports',
    confidenceVerifiedReady: 'Ready for VERIFIED',
    notesRequired: 'A comment is required for this decision.',
    correctionRequired: 'Enter a correction suggestion to continue.',
    noReviewHistory: 'No review history yet.',
    noOtherSuggestions: 'No related suggestions found.',
  },
  es: {
    eyebrow: 'Revisar',
    title: 'Review Workspace',
    description: 'Cola segura de traducciones pendientes con contexto, historial y sugerencias relacionadas.',
    sessionLabel: 'Sesion de revision',
    loading: 'Cargando cola de revision...',
    error: 'No fue posible cargar la cola de revision.',
    noSession: 'Elige un idioma para abrir una cola de revision.',
    noItems: 'No hay traducciones pendientes en esta cola ahora.',
    source: 'Origen',
    target: 'Destino',
    category: 'Categoria',
    subcategory: 'Subcategoria',
    context: 'Contexto',
    contextPack: 'Context Pack',
    suggestion: 'Traduccion propuesta',
    glossary: 'Glosario relevante',
    placeholders: 'Placeholders',
    reviewHistory: 'Historial de revisiones',
    otherSuggestions: 'Otras sugerencias',
    reviewNotes: 'Comentario de revision',
    correctionText: 'Suggest Correction',
    approve: 'Approve',
    needsChanges: 'Needs Changes',
    reject: 'Reject',
    suggestCorrection: 'Suggest Correction',
    submitting: 'Enviando...',
    loadingMore: 'Cargando mas...',
    loadMore: 'Cargar siguiente sesion',
    backToLanguages: 'Volver a idiomas',
    batchProgress: 'Progreso del lote',
    totalAvailable: 'Disponibles',
    remaining: 'Restantes',
    pending: 'Pendientes',
    approved: 'Aprobadas',
    needsChangesCount: 'Con cambios',
    rejected: 'Rechazadas',
    compatible: 'Compatible con tu rol',
    confidence: 'Confianza de traduccion',
    confidenceRule: 'Regla transparente: volumen de revisiones validas + acuerdo + reputacion de revisores - reports abiertos. No es IA.',
    confidenceLevel: 'Nivel',
    confidenceScore: 'Puntuacion',
    confidenceReviews: 'Revisiones validas',
    confidenceAgreement: 'Acuerdo',
    confidenceTrust: 'Confianza de revisores',
    confidenceReports: 'Reports abiertos',
    confidenceVerifiedReady: 'Listo para VERIFIED',
    notesRequired: 'Se requiere un comentario para esta decision.',
    correctionRequired: 'Escribe una sugerencia corregida para continuar.',
    noReviewHistory: 'Aun no hay historial de revisiones.',
    noOtherSuggestions: 'No se encontraron otras sugerencias relacionadas.',
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

function formatStatusLabel(value: string) {
  return value
    .replace(/_/g, ' ')
    .replace(/\b\w/g, (char) => char.toUpperCase());
}

function normalizeConfidenceLevel(value: ReviewWorkspaceConfidence['confidence_level'] | undefined) {
  const level = String(value ?? 'LOW').toUpperCase();

  if (level === 'VERIFIED') {
    return { label: 'VERIFIED', className: 'border-emerald-500/30 bg-emerald-500/15 text-emerald-700' };
  }

  if (level === 'HIGH') {
    return { label: 'HIGH', className: 'border-sky-500/30 bg-sky-500/15 text-sky-700' };
  }

  if (level === 'MEDIUM') {
    return { label: 'MEDIUM', className: 'border-amber-500/30 bg-amber-500/15 text-amber-700' };
  }

  return { label: 'LOW', className: 'border-slate-400/30 bg-slate-200 text-slate-700' };
}

function formatPercent(value: number) {
  const normalized = Number.isFinite(value) ? value : 0;
  return `${normalized.toFixed(0)}%`;
}

export function ReviewPage() {
  const { locale } = useLocale();
  const copy = copyByLocale[locale];
  const [searchParams] = useSearchParams();
  const languageCode = searchParams.get('language')?.trim() ?? '';
  const [session, setSession] = useState<ReviewWorkspaceSession | null>(null);
  const [loading, setLoading] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [activeIndex, setActiveIndex] = useState(0);
  const [approvedCount, setApprovedCount] = useState(0);
  const [changedCount, setChangedCount] = useState(0);
  const [rejectedCount, setRejectedCount] = useState(0);
  const [reviewNotes, setReviewNotes] = useState('');
  const [correctionText, setCorrectionText] = useState('');
  const [submitting, setSubmitting] = useState(false);

  const currentItem: ReviewWorkspaceItem | null = session?.items[activeIndex] ?? null;
  const currentConfidence = currentItem?.confidence ?? null;
  const confidenceBadge = normalizeConfidenceLevel(currentConfidence?.confidence_level);

  async function loadSession(offset = 0, append = false) {
    try {
      setError(null);
      setLoading(append ? false : true);
      setLoadingMore(append);

      const result = await fetchReviewWorkspaceSession({
        targetLanguageCode: languageCode || null,
        batchSize: 10,
        sessionOffset: offset
      });

      setSession(result);
      setActiveIndex(0);
      setApprovedCount(0);
      setChangedCount(0);
      setRejectedCount(0);
      setReviewNotes('');
      setCorrectionText('');
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
  }, [languageCode]);

  useEffect(() => {
    if (!currentItem) {
      return;
    }

    setReviewNotes('');
    setCorrectionText(currentItem.suggestion_text);
  }, [currentItem]);

  const progressLabel = useMemo(() => {
    if (!session) {
      return '0/0';
    }

    return `${Math.min(activeIndex + 1, session.loaded_count)}/${session.loaded_count}`;
  }, [activeIndex, session]);

  const processedCount = approvedCount + changedCount + rejectedCount;
  const remainingCount = session ? Math.max(session.loaded_count - processedCount, 0) : 0;

  async function goToNextSession() {
    if (!session?.has_more) {
      return;
    }

    await loadSession(session.session_offset + session.batch_size, true);
  }

  async function handleDecision(
    decision: 'approve' | 'request_changes' | 'reject' | 'flag',
    options?: { correctionText?: string }
  ) {
    if (!session || !currentItem) {
      return;
    }

    const trimmedNotes = reviewNotes.trim();
    const trimmedCorrection = (options?.correctionText ?? correctionText).trim();

    if ((decision === 'request_changes' || decision === 'reject') && trimmedNotes.length === 0) {
      setError(copy.notesRequired);
      return;
    }

    if (decision === 'flag' && trimmedCorrection.length === 0) {
      setError(copy.correctionRequired);
      return;
    }

    try {
      setSubmitting(true);
      setError(null);

      await submitReviewWorkspaceDecision({
        suggestionId: currentItem.suggestion_id,
        decision,
        notes: trimmedNotes.length > 0 ? trimmedNotes : null,
        correctionText: decision === 'flag' ? trimmedCorrection : null
      });

      if (decision === 'approve') {
        setApprovedCount((value) => value + 1);
      } else if (decision === 'request_changes') {
        setChangedCount((value) => value + 1);
      } else if (decision === 'reject') {
        setRejectedCount((value) => value + 1);
      } else {
        setChangedCount((value) => value + 1);
      }

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

  const sessionBadge = languageCode || copy.compatible;

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
                  <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">
                    {sessionBadge}
                  </Badge>
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
                  <p className="pixel-label text-[10px] text-[#566172]">{copy.suggestion}</p>
                  <h2 className="mt-2 text-2xl font-bold text-[#101114]">{currentItem.key_name}</h2>
                  <p className="mt-2 text-sm leading-7 text-[#566172]">{currentItem.suggestion_text}</p>
                </div>
                <div className="flex flex-wrap items-center gap-2">
                  <Badge tone="accent">{formatStatusLabel(currentItem.status)}</Badge>
                  {currentConfidence ? (
                    <span
                      className={`inline-flex items-center rounded-full border px-3 py-1 text-[11px] font-extrabold uppercase tracking-[0.18em] ${confidenceBadge.className}`}
                    >
                      {confidenceBadge.label}
                    </span>
                  ) : null}
                </div>
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

              <div className="mt-6 rounded-2xl border-2 border-[#101114] bg-[#f7f8fb] p-4">
                <div className="flex flex-wrap items-center justify-between gap-3">
                  <p className="pixel-label text-[10px] text-[#566172]">{copy.contextPack}</p>
                  <Badge tone="neutral">{copy.compatible}</Badge>
                </div>
                <div className="mt-4 grid gap-4 md:grid-cols-2">
                  <div className="rounded-2xl border border-[#dfe3ea] bg-white p-4">
                    <p className="pixel-label text-[10px] text-[#566172]">{copy.placeholders}</p>
                    <p className="mt-2 text-sm leading-7 text-[#101114]">
                      {formatList([...currentItem.protected_variables, ...currentItem.protected_terms])}
                    </p>
                  </div>
                  <div className="rounded-2xl border border-[#dfe3ea] bg-white p-4">
                    <p className="pixel-label text-[10px] text-[#566172]">{copy.suggestion}</p>
                    <p className="mt-2 text-sm leading-7 text-[#101114]">{currentItem.suggestion_text}</p>
                  </div>
                </div>
              </div>

              <div className="mt-6 rounded-2xl border-2 border-[#101114] bg-[#101114] p-4 text-white shadow-[4px_4px_0_#c7f464]">
                <div className="flex flex-wrap items-center justify-between gap-3">
                  <p className="pixel-label text-[10px] text-[#c7f464]">{copy.confidence}</p>
                  <span
                    className={`inline-flex items-center rounded-full border px-3 py-1 text-[11px] font-extrabold uppercase tracking-[0.18em] ${confidenceBadge.className}`}
                  >
                    {confidenceBadge.label}
                  </span>
                </div>

                <p className="mt-3 max-w-3xl text-sm leading-6 text-white/75">{copy.confidenceRule}</p>

                <div className="mt-5 grid gap-3 md:grid-cols-2 xl:grid-cols-3">
                  <div className="rounded-2xl border border-white/10 bg-white/[.06] p-4">
                    <p className="text-[10px] uppercase tracking-[0.24em] text-white/50">{copy.confidenceScore}</p>
                    <p className="mt-2 text-3xl font-extrabold text-white">
                      {currentConfidence ? `${currentConfidence.confidence_score.toFixed(0)}` : '0'}
                    </p>
                  </div>
                  <div className="rounded-2xl border border-white/10 bg-white/[.06] p-4">
                    <p className="text-[10px] uppercase tracking-[0.24em] text-white/50">{copy.confidenceReviews}</p>
                    <p className="mt-2 text-3xl font-extrabold text-white">{currentConfidence?.valid_reviews ?? 0}</p>
                  </div>
                  <div className="rounded-2xl border border-white/10 bg-white/[.06] p-4">
                    <p className="text-[10px] uppercase tracking-[0.24em] text-white/50">{copy.confidenceAgreement}</p>
                    <p className="mt-2 text-3xl font-extrabold text-white">
                      {formatPercent(currentConfidence?.agreement_rate ?? 0)}
                    </p>
                  </div>
                  <div className="rounded-2xl border border-white/10 bg-white/[.06] p-4">
                    <p className="text-[10px] uppercase tracking-[0.24em] text-white/50">{copy.confidenceTrust}</p>
                    <p className="mt-2 text-3xl font-extrabold text-white">
                      {formatPercent(currentConfidence?.reviewer_trust_score ?? 0)}
                    </p>
                  </div>
                  <div className="rounded-2xl border border-white/10 bg-white/[.06] p-4">
                    <p className="text-[10px] uppercase tracking-[0.24em] text-white/50">{copy.confidenceReports}</p>
                    <p className="mt-2 text-3xl font-extrabold text-white">{currentConfidence?.open_reports ?? 0}</p>
                  </div>
                  <div className="rounded-2xl border border-white/10 bg-white/[.06] p-4">
                    <p className="text-[10px] uppercase tracking-[0.24em] text-white/50">{copy.confidenceVerifiedReady}</p>
                    <p className="mt-2 text-base font-bold text-white">
                      {currentConfidence?.verified_ready ? 'YES' : 'NO'}
                    </p>
                  </div>
                </div>

                <div className="mt-4 rounded-2xl border border-white/10 bg-white/[.06] p-4">
                  <p className="text-[10px] uppercase tracking-[0.24em] text-white/50">Signals</p>
                  <div className="mt-3 grid gap-3 sm:grid-cols-2">
                    <div className="rounded-xl border border-white/10 bg-black/20 p-3">
                      <p className="text-[10px] uppercase tracking-[0.2em] text-white/45">Final status</p>
                      <p className="mt-2 text-sm font-semibold text-white">{currentConfidence?.final_status ?? '-'}</p>
                    </div>
                    <div className="rounded-xl border border-white/10 bg-black/20 p-3">
                      <p className="text-[10px] uppercase tracking-[0.2em] text-white/45">{copy.confidenceLevel}</p>
                      <p className="mt-2 text-sm font-semibold text-white">{currentConfidence?.confidence_level ?? 'LOW'}</p>
                    </div>
                  </div>
                </div>
              </div>

              <div className="mt-6 grid gap-4 md:grid-cols-2">
                <div className="rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-4">
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
                      <p className="text-sm text-[#566172]">{copy.noOtherSuggestions}</p>
                    )}
                  </div>
                </div>

                <div className="rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-4">
                  <p className="pixel-label text-[10px] text-[#566172]">{copy.reviewHistory}</p>
                  <div className="mt-4 grid gap-3">
                    {currentItem.review_history.length > 0 ? (
                      currentItem.review_history.map((entry) => (
                        <div key={entry.review_id} className="rounded-2xl border border-[#dfe3ea] bg-white p-4">
                          <div className="flex flex-wrap items-center justify-between gap-3">
                            <p className="text-sm font-bold text-[#101114]">
                              {entry.reviewer_name ?? entry.reviewer_username ?? '-'}
                            </p>
                            <Badge tone="neutral">{entry.decision}</Badge>
                          </div>
                          <p className="mt-2 text-xs text-[#566172]">{formatTimestamp(entry.reviewed_at, locale)}</p>
                          <p className="mt-2 text-sm leading-6 text-[#566172]">{entry.notes ?? '-'}</p>
                        </div>
                      ))
                    ) : (
                      <p className="text-sm text-[#566172]">{copy.noReviewHistory}</p>
                    )}
                  </div>
                </div>
              </div>

              <div className="mt-6 rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-4">
                <p className="pixel-label text-[10px] text-[#566172]">{copy.otherSuggestions}</p>
                <div className="mt-4 grid gap-3">
                  {currentItem.other_suggestions.length > 0 ? (
                    currentItem.other_suggestions.map((item) => (
                      <div key={item.suggestion_id} className="rounded-2xl border border-[#dfe3ea] bg-white p-4">
                        <div className="flex flex-wrap items-center justify-between gap-3">
                          <p className="text-sm font-bold text-[#101114]">
                            v{item.version_number} · {item.author_name ?? item.author_username ?? '-'}
                          </p>
                          <Badge tone="neutral">{item.status}</Badge>
                        </div>
                        <p className="mt-2 text-sm leading-6 text-[#566172]">{item.suggestion_text}</p>
                      </div>
                    ))
                  ) : (
                    <p className="text-sm text-[#566172]">{copy.noOtherSuggestions}</p>
                  )}
                </div>
              </div>
            </Card>

            <Card className="p-5 md:p-6">
              <div className="flex flex-wrap items-center justify-between gap-3">
                <div>
                  <p className="pixel-label text-[10px] text-[#566172]">{copy.sessionLabel}</p>
                  <h2 className="mt-2 text-2xl font-bold text-[#101114]">{copy.reviewNotes}</h2>
                </div>
                <Badge tone="success">{progressLabel}</Badge>
              </div>

              <div className="mt-5 space-y-4">
                <label className="block">
                  <span className="pixel-label text-[10px] text-[#566172]">{copy.reviewNotes}</span>
                  <textarea
                    value={reviewNotes}
                    onChange={(event) => setReviewNotes(event.target.value)}
                    placeholder={locale === 'pt-BR' ? 'Explique a decisao, o tom e o motivo da aprovacao ou rejeicao' : locale === 'es' ? 'Explica la decision, el tono y el motivo' : 'Explain the decision, tone, and rationale'}
                    className="min-h-[120px] w-full rounded-2xl border-2 border-[#101114] bg-white px-4 py-3 text-sm text-[#101114] outline-none transition placeholder:text-[#8a94a6] focus:border-[#5652ff]"
                  />
                </label>

                <label className="block">
                  <span className="pixel-label text-[10px] text-[#566172]">{copy.correctionText}</span>
                  <textarea
                    value={correctionText}
                    onChange={(event) => setCorrectionText(event.target.value)}
                    placeholder={locale === 'pt-BR' ? 'Sugestao corrigida para o texto revisado' : locale === 'es' ? 'Sugerencia corregida para el texto revisado' : 'Corrected suggestion for the reviewed text'}
                    className="min-h-[120px] w-full rounded-2xl border-2 border-[#dfe3ea] bg-white px-4 py-3 text-sm text-[#101114] outline-none transition placeholder:text-[#8a94a6] focus:border-[#5652ff]"
                  />
                </label>
              </div>

              <div className="mt-6 grid gap-3 sm:grid-cols-2">
                <button
                  type="button"
                  onClick={() => void handleDecision('approve')}
                  disabled={submitting}
                  className="rounded-2xl border-2 border-[#101114] bg-[#c7f464] px-4 py-3 font-[var(--font-display)] text-sm font-bold text-[#101114] transition hover:-translate-y-1 hover:shadow-[4px_4px_0_#101114] disabled:cursor-not-allowed disabled:opacity-60"
                >
                  {submitting ? copy.submitting : copy.approve}
                </button>
                <button
                  type="button"
                  onClick={() => void handleDecision('request_changes')}
                  disabled={submitting || reviewNotes.trim().length === 0}
                  className="rounded-2xl border-2 border-[#101114] bg-white px-4 py-3 font-[var(--font-display)] text-sm font-bold text-[#101114] transition hover:-translate-y-1 hover:shadow-[4px_4px_0_#101114] disabled:cursor-not-allowed disabled:opacity-60"
                >
                  {copy.needsChanges}
                </button>
                <button
                  type="button"
                  onClick={() => void handleDecision('reject')}
                  disabled={submitting || reviewNotes.trim().length === 0}
                  className="rounded-2xl border-2 border-[#ff6b5f] bg-[#fff0ee] px-4 py-3 font-[var(--font-display)] text-sm font-bold text-[#a83c34] transition hover:-translate-y-1 hover:shadow-[4px_4px_0_#a83c34] disabled:cursor-not-allowed disabled:opacity-60"
                >
                  {copy.reject}
                </button>
                <button
                  type="button"
                  onClick={() => void handleDecision('flag', { correctionText })}
                  disabled={submitting || correctionText.trim().length === 0}
                  className="rounded-2xl border-2 border-[#e59b32] bg-[#fff1d6] px-4 py-3 font-[var(--font-display)] text-sm font-bold text-[#8c5510] transition hover:-translate-y-1 hover:shadow-[4px_4px_0_#8c5510] disabled:cursor-not-allowed disabled:opacity-60"
                >
                  {copy.suggestCorrection}
                </button>
              </div>

              <div className="mt-6 rounded-2xl border-2 border-[#101114] bg-[#101114] p-4 text-white">
                <div className="flex items-center justify-between gap-3">
                  <p className="pixel-label text-[10px] text-[#c7f464]">{copy.batchProgress}</p>
                  <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">
                    {progressLabel}
                  </Badge>
                </div>
                <div className="mt-4 grid grid-cols-4 gap-3">
                  <div className="rounded-xl border border-white/10 bg-white/5 p-3.5">
                    <p className="text-[10px] uppercase tracking-[0.28em] text-white/50">{copy.pending}</p>
                    <p className="mt-2 text-2xl font-bold">{remainingCount}</p>
                  </div>
                  <div className="rounded-xl border border-white/10 bg-white/5 p-3.5">
                    <p className="text-[10px] uppercase tracking-[0.28em] text-white/50">{copy.approved}</p>
                    <p className="mt-2 text-2xl font-bold">{approvedCount}</p>
                  </div>
                  <div className="rounded-xl border border-white/10 bg-white/5 p-3.5">
                    <p className="text-[10px] uppercase tracking-[0.28em] text-white/50">{copy.needsChangesCount}</p>
                    <p className="mt-2 text-2xl font-bold">{changedCount}</p>
                  </div>
                  <div className="rounded-xl border border-white/10 bg-white/5 p-3.5">
                    <p className="text-[10px] uppercase tracking-[0.28em] text-white/50">{copy.rejected}</p>
                    <p className="mt-2 text-2xl font-bold">{rejectedCount}</p>
                  </div>
                </div>
              </div>

              <div className="mt-6 flex flex-wrap gap-3">
                <Link to={paths.languages} className="block-button-secondary inline-flex px-5 py-3 text-sm">
                  {copy.backToLanguages}
                </Link>
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
