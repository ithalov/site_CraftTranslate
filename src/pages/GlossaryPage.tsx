import { useEffect, useMemo, useState, type FormEvent } from 'react';
import { Card } from '@/components/ui/Card';
import { Badge } from '@/components/ui/Badge';
import { useLocale } from '@/hooks/useLocale';
import { classNames } from '@/utils/classNames';
import type { LocaleCode } from '@/types/locale';
import {
  fetchGlossaryProposalHistory,
  fetchGlossaryProposalLanguages,
  fetchGlossaryProposals,
  reviewGlossaryProposal,
  submitGlossaryProposal,
  type GlossaryProposal,
  type GlossaryProposalHistoryItem,
  type PublicLanguageOption
} from '@/services/glossaryProposals';

type Copy = {
  eyebrow: string;
  title: string;
  description: string;
  formTitle: string;
  formHint: string;
  listTitle: string;
  listHint: string;
  historyTitle: string;
  emptyState: string;
  submit: string;
  approve: string;
  reject: string;
  requestChanges: string;
  history: string;
  language: string;
  original: string;
  translation: string;
  category: string;
  subcategory: string;
  rule: string;
  rationale: string;
  notes: string;
  doNotTranslate: string;
  status: string;
  createdAt: string;
  decisionNotes: string;
  loadError: string;
  saved: string;
  approvedGlossary: string;
  pending: string;
  approved: string;
  rejected: string;
  needsChanges: string;
};

const copyByLocale: Record<LocaleCode, Copy> = {
  'pt-BR': {
    eyebrow: 'Glossario comunitario',
    title: 'Propostas de termos oficiais',
    description:
      'Tradutores sugerem termos e justificativas. Reviewers e Language Moderators aprovam, rejeitam ou pedem ajustes sem editar o glossario oficial direto.',
    formTitle: 'Nova proposta',
    formHint: 'Sugira um termo oficial com contexto claro para a comunidade.',
    listTitle: 'Fila de propostas',
    listHint: 'O que voce pode ver depende do seu papel. Historico e decisoes ficam registrados.',
    historyTitle: 'Historico da proposta',
    emptyState: 'Ainda nao ha propostas visiveis para voce.',
    submit: 'Enviar proposta',
    approve: 'Aprovar',
    reject: 'Rejeitar',
    requestChanges: 'Pedir ajustes',
    history: 'Historico',
    language: 'Idioma',
    original: 'Original',
    translation: 'Tradução recomendada',
    category: 'Categoria',
    subcategory: 'Subcategoria',
    rule: 'Regra',
    rationale: 'Justificativa',
    notes: 'Notas',
    doNotTranslate: 'Nao traduzir',
    status: 'Status',
    createdAt: 'Criada em',
    decisionNotes: 'Comentario da decisao',
    loadError: 'Nao foi possivel carregar as propostas agora.',
    saved: 'Proposta enviada com sucesso.',
    approvedGlossary: 'Glossario oficial vinculado',
    pending: 'Pendente',
    approved: 'Aprovada',
    rejected: 'Rejeitada',
    needsChanges: 'Precisa de ajustes'
  },
  en: {
    eyebrow: 'Community glossary',
    title: 'Official term proposals',
    description:
      'Translators suggest terms and rationale. Reviewers and Language Moderators can approve, reject, or request changes without editing the official glossary directly.',
    formTitle: 'New proposal',
    formHint: 'Suggest an official term with clear context for the community.',
    listTitle: 'Proposal queue',
    listHint: 'What you see depends on your role. History and decisions stay recorded.',
    historyTitle: 'Proposal history',
    emptyState: 'No proposals are visible to you yet.',
    submit: 'Submit proposal',
    approve: 'Approve',
    reject: 'Reject',
    requestChanges: 'Request changes',
    history: 'History',
    language: 'Language',
    original: 'Original',
    translation: 'Recommended translation',
    category: 'Category',
    subcategory: 'Subcategory',
    rule: 'Rule',
    rationale: 'Rationale',
    notes: 'Notes',
    doNotTranslate: 'Do not translate',
    status: 'Status',
    createdAt: 'Created at',
    decisionNotes: 'Decision note',
    loadError: 'We could not load proposals right now.',
    saved: 'Proposal submitted successfully.',
    approvedGlossary: 'Linked official glossary entry',
    pending: 'Pending',
    approved: 'Approved',
    rejected: 'Rejected',
    needsChanges: 'Needs changes'
  },
  es: {
    eyebrow: 'Glosario comunitario',
    title: 'Propuestas de terminos oficiales',
    description:
      'Los traductores sugieren terminos y justificacion. Reviewers y Language Moderators pueden aprobar, rechazar o pedir cambios sin editar directamente el glosario oficial.',
    formTitle: 'Nueva propuesta',
    formHint: 'Sugiere un termino oficial con contexto claro para la comunidad.',
    listTitle: 'Cola de propuestas',
    listHint: 'Lo que ves depende de tu rol. El historial y las decisiones quedan registradas.',
    historyTitle: 'Historial de la propuesta',
    emptyState: 'Aun no hay propuestas visibles para ti.',
    submit: 'Enviar propuesta',
    approve: 'Aprobar',
    reject: 'Rechazar',
    requestChanges: 'Pedir cambios',
    history: 'Historial',
    language: 'Idioma',
    original: 'Original',
    translation: 'Traduccion recomendada',
    category: 'Categoria',
    subcategory: 'Subcategoria',
    rule: 'Regla',
    rationale: 'Justificacion',
    notes: 'Notas',
    doNotTranslate: 'No traducir',
    status: 'Estado',
    createdAt: 'Creada en',
    decisionNotes: 'Comentario de la decision',
    loadError: 'No pudimos cargar las propuestas ahora.',
    saved: 'Propuesta enviada con exito.',
    approvedGlossary: 'Entrada oficial vinculada',
    pending: 'Pendiente',
    approved: 'Aprobada',
    rejected: 'Rechazada',
    needsChanges: 'Necesita cambios'
  }
};

type ProposalFormState = {
  languageCode: string;
  originalTerm: string;
  recommendedTranslation: string;
  category: string;
  subcategory: string;
  rule: string;
  rationale: string;
  notes: string;
  doNotTranslate: boolean;
};

type Notice = {
  tone: 'success' | 'warning' | 'danger';
  text: string;
} | null;

const initialForm = (languageCode = 'pt-BR'): ProposalFormState => ({
  languageCode,
  originalTerm: '',
  recommendedTranslation: '',
  category: 'general',
  subcategory: '',
  rule: '',
  rationale: '',
  notes: '',
  doNotTranslate: false
});

const categorySuggestions = ['general', 'minecraft', 'pvp', 'mmorpg', 'economy', 'trading', 'commands', 'system messages', 'mods'];

function formatStatusLabel(value: string, copy: Copy) {
  switch (value) {
    case 'approved':
      return copy.approved;
    case 'rejected':
      return copy.rejected;
    case 'needs_changes':
      return copy.needsChanges;
    default:
      return copy.pending;
  }
}

function toneForStatus(value: string) {
  switch (value) {
    case 'approved':
      return 'success';
    case 'rejected':
      return 'danger';
    case 'needs_changes':
      return 'warning';
    default:
      return 'neutral';
  }
}

function formatDate(value: string, locale: LocaleCode) {
  return new Intl.DateTimeFormat(locale === 'pt-BR' ? 'pt-BR' : locale, {
    dateStyle: 'medium',
    timeStyle: 'short'
  }).format(new Date(value));
}

function fieldClassName() {
  return 'w-full rounded-2xl border-2 border-[#dfe3ea] bg-white px-4 py-3 text-sm text-[#101114] outline-none transition placeholder:text-[#8a94a6] focus:border-[#5652ff]';
}

function reviewButtonClass(tone: 'approve' | 'reject' | 'changes') {
  const base =
    'rounded-full border-2 px-4 py-2 text-sm font-bold transition duration-200 hover:-translate-y-0.5';

  if (tone === 'approve') {
    return classNames(base, 'border-[#2da44e] bg-[#e4f5e8] text-[#187638] hover:shadow-[3px_3px_0_#2da44e]');
  }

  if (tone === 'reject') {
    return classNames(base, 'border-[#ff6b5f] bg-[#fff0ee] text-[#a83c34] hover:shadow-[3px_3px_0_#ff6b5f]');
  }

  return classNames(base, 'border-[#e59b32] bg-[#fff1d6] text-[#8c5510] hover:shadow-[3px_3px_0_#e59b32]');
}

export function GlossaryPage() {
  const { locale } = useLocale();
  const copy = copyByLocale[locale];

  const [languages, setLanguages] = useState<PublicLanguageOption[]>([]);
  const [proposals, setProposals] = useState<GlossaryProposal[]>([]);
  const [historyByProposal, setHistoryByProposal] = useState<Record<string, GlossaryProposalHistoryItem[]>>({});
  const [expandedProposalId, setExpandedProposalId] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [submittingReviewId, setSubmittingReviewId] = useState<string | null>(null);
  const [notice, setNotice] = useState<Notice>(null);
  const [form, setForm] = useState<ProposalFormState>(initialForm());
  const [reviewNotes, setReviewNotes] = useState<Record<string, string>>({});

  const languageMap = useMemo(() => {
    return new Map(languages.map((language) => [language.language_id, language]));
  }, [languages]);

  const visibleCount = proposals.length;
  const pendingCount = proposals.filter((proposal) => proposal.status === 'pending').length;
  const reviewedCount = proposals.filter((proposal) => proposal.status === 'approved' || proposal.status === 'rejected').length;

  useEffect(() => {
    let active = true;

    async function load() {
      setLoading(true);

      try {
        const [languageList, proposalList] = await Promise.all([
          fetchGlossaryProposalLanguages(),
          fetchGlossaryProposals()
        ]);

        if (!active) {
          return;
        }

        setLanguages(languageList);
        setProposals(proposalList);
        setForm((current) => ({
          ...current,
          languageCode: current.languageCode || languageList[0]?.code || 'pt-BR'
        }));
        setNotice(null);
      } catch (error) {
        if (active) {
          setNotice({
            tone: 'danger',
            text: error instanceof Error ? error.message : copy.loadError
          });
        }
      } finally {
        if (active) {
          setLoading(false);
        }
      }
    }

    load();

    return () => {
      active = false;
    };
  }, [copy.loadError]);

  async function refreshProposals() {
    const next = await fetchGlossaryProposals();
    setProposals(next);
  }

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();

    if (!form.originalTerm.trim() || !form.recommendedTranslation.trim()) {
      setNotice({
        tone: 'warning',
        text: locale === 'pt-BR'
          ? 'Preencha o termo original e a tradução recomendada.'
          : locale === 'es'
            ? 'Completa el termino original y la traduccion recomendada.'
            : 'Fill in the original term and the recommended translation.'
      });
      return;
    }

    setSaving(true);

    try {
      await submitGlossaryProposal({
        languageCode: form.languageCode,
        originalTerm: form.originalTerm.trim(),
        recommendedTranslation: form.recommendedTranslation.trim(),
        category: form.category.trim() || 'general',
        subcategory: form.subcategory.trim() || undefined,
        rule: form.rule.trim() || undefined,
        rationale: form.rationale.trim() || undefined,
        notes: form.notes.trim() || undefined,
        doNotTranslate: form.doNotTranslate
      });

      setNotice({
        tone: 'success',
        text: copy.saved
      });
      setForm(initialForm(form.languageCode));
      await refreshProposals();
    } catch (error) {
      setNotice({
        tone: 'danger',
        text: error instanceof Error ? error.message : copy.loadError
      });
    } finally {
      setSaving(false);
    }
  }

  async function handleReview(proposalId: string, decision: 'approve' | 'reject' | 'request_changes') {
    const notes = reviewNotes[proposalId] ?? '';

    setSubmittingReviewId(proposalId);

    try {
      await reviewGlossaryProposal({
        proposalId,
        decision,
        notes: notes.trim() || undefined
      });

      setNotice({
        tone: 'success',
        text:
          locale === 'pt-BR'
            ? 'Decisao registrada com historico.'
            : locale === 'es'
              ? 'Decision registrada con historial.'
              : 'Decision recorded with history.'
      });
      await refreshProposals();
      if (expandedProposalId === proposalId) {
        const history = await fetchGlossaryProposalHistory(proposalId);
        setHistoryByProposal((current) => ({ ...current, [proposalId]: history }));
      }
    } catch (error) {
      setNotice({
        tone: 'danger',
        text: error instanceof Error ? error.message : copy.loadError
      });
    } finally {
      setSubmittingReviewId(null);
    }
  }

  async function toggleHistory(proposalId: string) {
    setExpandedProposalId((current) => (current === proposalId ? null : proposalId));

    if (!historyByProposal[proposalId]) {
      try {
        const history = await fetchGlossaryProposalHistory(proposalId);
        setHistoryByProposal((current) => ({ ...current, [proposalId]: history }));
      } catch {
        setHistoryByProposal((current) => ({ ...current, [proposalId]: [] }));
      }
    }
  }

  return (
    <div className="space-y-6 pb-10">
      <Card elevated className="overflow-hidden bg-[#101114] text-white">
        <div className="grid gap-8 p-6 lg:grid-cols-[1.2fr_.8fr] lg:p-8">
          <div className="space-y-4">
            <Badge tone="accent" className="w-fit">
              {copy.eyebrow}
            </Badge>
            <div className="space-y-3">
              <h1 className="text-4xl font-black leading-tight md:text-5xl">{copy.title}</h1>
              <p className="max-w-2xl text-base leading-7 text-[#d6d8e0]">{copy.description}</p>
            </div>
            <div className="flex flex-wrap gap-3 pt-2 text-sm text-[#101114]">
              <div className="rounded-full bg-[#c7f464] px-4 py-2 font-bold">+ {visibleCount} proposals</div>
              <div className="rounded-full border border-white/20 bg-white/10 px-4 py-2 text-white">
                {pendingCount} {copy.pending.toLowerCase()}
              </div>
              <div className="rounded-full border border-white/20 bg-white/10 px-4 py-2 text-white">
                {reviewedCount} reviewed
              </div>
            </div>
          </div>

          <div className="rounded-[28px] border border-white/10 bg-white/5 p-5 shadow-[0_20px_60px_rgba(0,0,0,.25)]">
            <p className="pixel-label text-[10px] text-[#c7f464]">{copy.formHint}</p>
            <div className="mt-4 grid gap-3 text-sm text-[#d6d8e0]">
              <div className="rounded-2xl border border-white/10 bg-black/20 p-4">
                <p className="pixel-label text-[10px] text-[#c7f464]">1</p>
                <p className="mt-2">Envie termos novos sem tocar no glossario oficial.</p>
              </div>
              <div className="rounded-2xl border border-white/10 bg-black/20 p-4">
                <p className="pixel-label text-[10px] text-[#c7f464]">2</p>
                <p className="mt-2">Reviewers registram decisao e comentario em historico.</p>
              </div>
              <div className="rounded-2xl border border-white/10 bg-black/20 p-4">
                <p className="pixel-label text-[10px] text-[#c7f464]">3</p>
                <p className="mt-2">Aprovacoes criam o termo oficial automaticamente.</p>
              </div>
            </div>
          </div>
        </div>
      </Card>

      {notice ? (
        <div
          className={classNames(
            'rounded-2xl border-2 px-4 py-3 text-sm font-semibold',
            notice.tone === 'success'
              ? 'border-[#2da44e] bg-[#e4f5e8] text-[#187638]'
              : notice.tone === 'warning'
                ? 'border-[#e59b32] bg-[#fff1d6] text-[#8c5510]'
                : 'border-[#ff6b5f] bg-[#fff0ee] text-[#a83c34]'
          )}
        >
          {notice.text}
        </div>
      ) : null}

      <div className="grid gap-6 xl:grid-cols-[1.04fr_.96fr]">
        <Card className="p-5 md:p-6" elevated>
          <div className="flex flex-wrap items-center justify-between gap-3">
            <div>
              <p className="pixel-label text-[10px] text-[#566172]">{copy.formTitle}</p>
              <h2 className="mt-2 text-2xl font-bold text-[#101114]">{copy.submit}</h2>
            </div>
            <Badge tone="success">{copy.pending}</Badge>
          </div>

          <form onSubmit={handleSubmit} className="mt-5 grid gap-4">
            <div className="grid gap-4 md:grid-cols-2">
              <label className="block">
                <span className="pixel-label text-[10px] text-[#566172]">{copy.language}</span>
                <select
                  value={form.languageCode}
                  onChange={(event) => setForm((current) => ({ ...current, languageCode: event.target.value }))}
                  className={fieldClassName()}
                >
                  {languages.map((language) => (
                    <option key={language.language_id} value={language.code}>
                      {language.code} - {language.name}
                    </option>
                  ))}
                </select>
              </label>
              <label className="block">
                <span className="pixel-label text-[10px] text-[#566172]">{copy.category}</span>
                <select
                  value={form.category}
                  onChange={(event) => setForm((current) => ({ ...current, category: event.target.value }))}
                  className={fieldClassName()}
                >
                  {categorySuggestions.map((category) => (
                    <option key={category} value={category}>
                      {category}
                    </option>
                  ))}
                </select>
              </label>
            </div>

            <div className="grid gap-4 md:grid-cols-2">
              <label className="block">
                <span className="pixel-label text-[10px] text-[#566172]">{copy.original}</span>
                <input
                  value={form.originalTerm}
                  onChange={(event) => setForm((current) => ({ ...current, originalTerm: event.target.value }))}
                  placeholder="Party"
                  className={fieldClassName()}
                />
              </label>
              <label className="block">
                <span className="pixel-label text-[10px] text-[#566172]">{copy.translation}</span>
                <input
                  value={form.recommendedTranslation}
                  onChange={(event) =>
                    setForm((current) => ({ ...current, recommendedTranslation: event.target.value }))
                  }
                  placeholder="Grupo"
                  className={fieldClassName()}
                />
              </label>
            </div>

            <div className="grid gap-4 md:grid-cols-2">
              <label className="block">
                <span className="pixel-label text-[10px] text-[#566172]">{copy.subcategory}</span>
                <input
                  value={form.subcategory}
                  onChange={(event) => setForm((current) => ({ ...current, subcategory: event.target.value }))}
                  placeholder="Social / Commands / System"
                  className={fieldClassName()}
                />
              </label>
              <label className="block">
                <span className="pixel-label text-[10px] text-[#566172]">{copy.rule}</span>
                <input
                  value={form.rule}
                  onChange={(event) => setForm((current) => ({ ...current, rule: event.target.value }))}
                  placeholder="Preserve the meaning of the player group."
                  className={fieldClassName()}
                />
              </label>
            </div>

            <label className="block">
              <span className="pixel-label text-[10px] text-[#566172]">{copy.rationale}</span>
              <textarea
                value={form.rationale}
                onChange={(event) => setForm((current) => ({ ...current, rationale: event.target.value }))}
                placeholder={locale === 'pt-BR' ? 'Explique a escolha da traduçao' : locale === 'es' ? 'Explica la eleccion de la traduccion' : 'Explain the translation choice'}
                className="min-h-[120px] w-full rounded-2xl border-2 border-[#dfe3ea] bg-white px-4 py-3 text-sm text-[#101114] outline-none transition placeholder:text-[#8a94a6] focus:border-[#5652ff]"
              />
            </label>

            <label className="block">
              <span className="pixel-label text-[10px] text-[#566172]">{copy.notes}</span>
              <textarea
                value={form.notes}
                onChange={(event) => setForm((current) => ({ ...current, notes: event.target.value }))}
                placeholder={locale === 'pt-BR' ? 'Observacoes adicionais opcionais' : locale === 'es' ? 'Notas adicionales opcionales' : 'Optional additional notes'}
                className="min-h-[100px] w-full rounded-2xl border-2 border-[#dfe3ea] bg-white px-4 py-3 text-sm text-[#101114] outline-none transition placeholder:text-[#8a94a6] focus:border-[#5652ff]"
              />
            </label>

            <label className="flex items-center gap-3 rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] px-4 py-3 text-sm font-bold text-[#101114]">
              <input
                type="checkbox"
                checked={form.doNotTranslate}
                onChange={(event) => setForm((current) => ({ ...current, doNotTranslate: event.target.checked }))}
                className="h-4 w-4 rounded border-[#c6cfdb] text-[#5652ff] focus:ring-[#5652ff]"
              />
              <span>{copy.doNotTranslate}</span>
            </label>

            <button
              type="submit"
              disabled={saving}
              className="w-fit rounded-2xl border-2 border-[#101114] bg-[#c7f464] px-5 py-3 text-sm font-black text-[#101114] transition duration-200 hover:-translate-y-0.5 hover:shadow-[4px_4px_0_#101114] disabled:cursor-not-allowed disabled:opacity-60"
            >
              {saving ? '...' : copy.submit}
            </button>
          </form>
        </Card>

        <Card className="p-5 md:p-6" elevated>
          <div className="flex flex-wrap items-center justify-between gap-3">
            <div>
              <p className="pixel-label text-[10px] text-[#566172]">{copy.listTitle}</p>
              <h2 className="mt-2 text-2xl font-bold text-[#101114]">{copy.listHint}</h2>
            </div>
            <Badge tone="neutral">{visibleCount}</Badge>
          </div>

          <div className="mt-5 space-y-4">
            {loading ? (
              <div className="rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-6 text-sm text-[#566172]">
                Loading proposals...
              </div>
            ) : proposals.length > 0 ? (
              proposals.map((proposal) => {
                const language = languageMap.get(proposal.language_id);
                const history = historyByProposal[proposal.id] ?? [];
                const isExpanded = expandedProposalId === proposal.id;
                const isReviewable = proposal.status === 'pending' || proposal.status === 'needs_changes';

                return (
                  <article
                    key={proposal.id}
                    className="rounded-[28px] border-2 border-[#101114] bg-white p-4 shadow-[5px_5px_0_#101114]"
                  >
                    <div className="flex flex-wrap items-start justify-between gap-3">
                      <div>
                        <div className="flex flex-wrap items-center gap-2">
                          <h3 className="text-lg font-black text-[#101114]">{proposal.proposed_original_term}</h3>
                          <Badge tone={toneForStatus(proposal.status) as 'accent' | 'neutral' | 'success' | 'warning' | 'danger'}>
                            {formatStatusLabel(proposal.status, copy)}
                          </Badge>
                        </div>
                        <p className="mt-2 text-sm text-[#566172]">
                          {copy.translation}: <span className="font-bold text-[#101114]">{proposal.proposed_recommended_translation}</span>
                        </p>
                        <p className="mt-1 text-sm text-[#566172]">
                          {copy.language}: <span className="font-bold text-[#101114]">{language ? `${language.code} - ${language.name}` : proposal.language_id}</span>
                        </p>
                      </div>

                      <div className="flex flex-wrap gap-2">
                        <Badge tone={proposal.proposed_do_not_translate ? 'warning' : 'neutral'}>
                          {proposal.proposed_do_not_translate ? copy.doNotTranslate : proposal.proposed_category}
                        </Badge>
                        {proposal.proposed_subcategory ? <Badge tone="neutral">{proposal.proposed_subcategory}</Badge> : null}
                      </div>
                    </div>

                    <div className="mt-4 grid gap-3 md:grid-cols-2">
                      <div className="rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-4">
                        <p className="pixel-label text-[10px] text-[#566172]">{copy.rationale}</p>
                        <p className="mt-2 text-sm leading-6 text-[#101114]">
                          {proposal.proposed_notes ?? proposal.rationale ?? '-'}
                        </p>
                      </div>
                      <div className="rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-4">
                        <p className="pixel-label text-[10px] text-[#566172]">{copy.rule}</p>
                        <p className="mt-2 text-sm leading-6 text-[#101114]">{proposal.proposed_rule ?? '-'}</p>
                      </div>
                    </div>

                    <div className="mt-4 flex flex-wrap items-center justify-between gap-3">
                      <p className="text-xs font-bold uppercase tracking-[0.25em] text-[#566172]">
                        {copy.createdAt}: {formatDate(proposal.created_at, locale)}
                      </p>
                      {proposal.glossary_id ? (
                        <Badge tone="success">{copy.approvedGlossary}</Badge>
                      ) : null}
                    </div>

                    <div className="mt-4 flex flex-wrap gap-2">
                      <button
                        type="button"
                        onClick={() => toggleHistory(proposal.id)}
                        className="rounded-full border-2 border-[#101114] bg-[#f7f8fb] px-4 py-2 text-sm font-bold text-[#101114] transition hover:-translate-y-0.5"
                      >
                        {copy.history}
                      </button>
                      {isReviewable ? (
                        <>
                          <button
                            type="button"
                            onClick={() => handleReview(proposal.id, 'approve')}
                            disabled={submittingReviewId === proposal.id}
                            className={reviewButtonClass('approve')}
                          >
                            {copy.approve}
                          </button>
                          <button
                            type="button"
                            onClick={() => handleReview(proposal.id, 'request_changes')}
                            disabled={submittingReviewId === proposal.id}
                            className={reviewButtonClass('changes')}
                          >
                            {copy.requestChanges}
                          </button>
                          <button
                            type="button"
                            onClick={() => handleReview(proposal.id, 'reject')}
                            disabled={submittingReviewId === proposal.id}
                            className={reviewButtonClass('reject')}
                          >
                            {copy.reject}
                          </button>
                        </>
                      ) : null}
                    </div>

                    {isReviewable ? (
                      <label className="mt-4 block">
                        <span className="pixel-label text-[10px] text-[#566172]">{copy.decisionNotes}</span>
                        <textarea
                          value={reviewNotes[proposal.id] ?? ''}
                          onChange={(event) =>
                            setReviewNotes((current) => ({ ...current, [proposal.id]: event.target.value }))
                          }
                          placeholder={locale === 'pt-BR' ? 'Explique a decisao antes de aprovar ou rejeitar' : locale === 'es' ? 'Explica la decision antes de aprobar o rechazar' : 'Explain the decision before approving or rejecting'}
                          className="mt-2 min-h-[92px] w-full rounded-2xl border-2 border-[#dfe3ea] bg-white px-4 py-3 text-sm text-[#101114] outline-none transition placeholder:text-[#8a94a6] focus:border-[#5652ff]"
                        />
                      </label>
                    ) : null}

                    {isExpanded ? (
                      <div className="mt-4 rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-4">
                        <p className="pixel-label text-[10px] text-[#566172]">{copy.historyTitle}</p>
                        {history.length > 0 ? (
                          <div className="mt-3 space-y-3">
                            {history.map((item) => (
                              <div key={item.event_id} className="rounded-2xl border border-[#dfe3ea] bg-white p-3">
                                <div className="flex flex-wrap items-center justify-between gap-2">
                                  <p className="text-sm font-bold text-[#101114]">
                                    {item.actor_name ?? item.actor_username ?? item.actor_id}
                                  </p>
                                  <Badge tone="neutral">{item.action}</Badge>
                                </div>
                                <p className="mt-2 text-sm text-[#566172]">
                                  {item.previous_status} → {item.new_status}
                                </p>
                                {item.notes ? <p className="mt-1 text-sm text-[#566172]">{item.notes}</p> : null}
                                <p className="mt-1 text-xs font-bold uppercase tracking-[0.24em] text-[#8a94a6]">
                                  {formatDate(item.created_at, locale)}
                                </p>
                              </div>
                            ))}
                          </div>
                        ) : (
                          <p className="mt-2 text-sm text-[#566172]">No history yet.</p>
                        )}
                      </div>
                    ) : null}
                  </article>
                );
              })
            ) : (
              <div className="rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-6 text-sm text-[#566172]">
                {copy.emptyState}
              </div>
            )}
          </div>
        </Card>
      </div>
    </div>
  );
}
