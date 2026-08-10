import { useEffect, useMemo, useState } from 'react';
import { Badge } from '@/components/ui/Badge';
import { Card } from '@/components/ui/Card';
import { classNames } from '@/utils/classNames';
import { useLocale } from '@/hooks/useLocale';
import {
  createEmptyPreference,
  loadLanguagePreferences,
  saveLanguagePreferences,
  type LanguagePreferenceDraft,
  type LanguageRow,
  type UserLanguageRow
} from '@/services/languagePreferences';
import {
  formatLanguageLevel,
  getLanguageWorkAccess,
  proficiencyDescriptions
} from '@/utils/languageCompatibility';

type LanguagePreferencesEditorProps = {
  userId: string;
  mode?: 'onboarding' | 'profile';
  onSaved?: (rows: UserLanguageRow[]) => void;
};

const editableProficiencies = ['beginner', 'intermediate', 'fluent', 'native'] as const;

const localizedCopy = {
  'pt-BR': {
    onboarding: 'Configuracao inicial', languages: 'Idiomas', onboardingTitle: 'Quais idiomas voce conhece?', profileTitle: 'Edite seus idiomas',
    onboardingLead: 'Usamos estas informacoes para enviar tarefas de traducao e revisao compativeis com seus idiomas e permissoes.',
    profileLead: 'Mantenha os idiomas atualizados para que tarefas e filas de revisao correspondam as suas habilidades reais.',
    language: 'Idioma', choose: 'Selecione um idioma', proficiency: 'Nivel de dominio', notes: 'Observacoes', notesPlaceholder: 'Opcional: dialeto, contexto ou nivel de conforto',
    primary: 'Principal', selected: 'Idioma principal do seu perfil', setPrimary: 'Definir como idioma principal', remove: 'Remover idioma', add: 'Adicionar outro idioma',
    saving: 'Salvando...', finish: 'Concluir configuracao', save: 'Salvar idiomas', chooseLanguage: 'Selecione um idioma',
    primarySummary: 'Idioma principal exibido no perfil.', secondarySummary: 'Idioma adicional para tarefas.', loadError: 'Nao foi possivel carregar os idiomas.',
    savedOnboarding: 'Idiomas salvos. A configuracao inicial foi concluida.', savedProfile: 'Preferencias de idioma atualizadas.', saveError: 'Nao foi possivel salvar.',
    levels: { beginner: 'Iniciante', intermediate: 'Intermediario', fluent: 'Fluente', native: 'Nativo' },
    access: { beginner: 'Treinamento', intermediate: 'Traducao', fluent: 'Traducao e revisao', native: 'Traducao e revisao' }
  },
  en: {
    onboarding: 'Onboarding', languages: 'Languages', onboardingTitle: 'Which languages do you know?', profileTitle: 'Edit your languages',
    onboardingLead: 'We use this to send translation and review tasks compatible with your languages and roles.',
    profileLead: 'Keep this current so tasks and review queues match your real language skills.',
    language: 'Language', choose: 'Choose a language', proficiency: 'Proficiency', notes: 'Notes', notesPlaceholder: 'Optional: dialect, context, or comfort level',
    primary: 'Primary', selected: 'Primary language for your profile', setPrimary: 'Set as primary language', remove: 'Remove language', add: 'Add another language',
    saving: 'Saving...', finish: 'Finish onboarding', save: 'Save languages', chooseLanguage: 'Choose a language', primarySummary: 'Primary language shown on the profile.', secondarySummary: 'Additional language for assignments.', loadError: 'Unable to load languages.',
    savedOnboarding: 'Languages saved. Onboarding is complete.', savedProfile: 'Language preferences updated.', saveError: 'Unable to save.',
    levels: { beginner: 'Beginner', intermediate: 'Intermediate', fluent: 'Fluent', native: 'Native' },
    access: { beginner: 'Training only', intermediate: 'Translation', fluent: 'Translation and review', native: 'Translation and review' }
  },
  es: {
    onboarding: 'Configuracion inicial', languages: 'Idiomas', onboardingTitle: 'Que idiomas conoces?', profileTitle: 'Edita tus idiomas',
    onboardingLead: 'Usamos esto para enviar tareas de traduccion y revision compatibles con tus idiomas y roles.',
    profileLead: 'Mantenlos actualizados para que las tareas y colas coincidan con tus habilidades reales.',
    language: 'Idioma', choose: 'Elige un idioma', proficiency: 'Nivel', notes: 'Notas', notesPlaceholder: 'Opcional: dialecto, contexto o nivel de comodidad',
    primary: 'Principal', selected: 'Idioma principal de tu perfil', setPrimary: 'Definir como idioma principal', remove: 'Eliminar idioma', add: 'Agregar otro idioma',
    saving: 'Guardando...', finish: 'Finalizar configuracion', save: 'Guardar idiomas', chooseLanguage: 'Elige un idioma', primarySummary: 'Idioma principal mostrado en el perfil.', secondarySummary: 'Idioma adicional para tareas.', loadError: 'No se pudieron cargar los idiomas.',
    savedOnboarding: 'Idiomas guardados. La configuracion inicial termino.', savedProfile: 'Preferencias de idioma actualizadas.', saveError: 'No se pudo guardar.',
    levels: { beginner: 'Principiante', intermediate: 'Intermedio', fluent: 'Fluido', native: 'Nativo' },
    access: { beginner: 'Solo entrenamiento', intermediate: 'Traduccion', fluent: 'Traduccion y revision', native: 'Traduccion y revision' }
  }
} as const;

function languageLabel(language: LanguageRow) {
  const parts = [language.emoji, language.name, language.native_name].filter(Boolean);
  return parts.join(' - ');
}

function rowTitle(row: LanguagePreferenceDraft, languages: LanguageRow[]) {
  const selectedLanguage = languages.find((language) => language.id === row.language_id);

  if (!selectedLanguage) {
    return 'Choose a language';
  }

  return languageLabel(selectedLanguage);
}

export function LanguagePreferencesEditor({
  userId,
  mode = 'profile',
  onSaved
}: LanguagePreferencesEditorProps) {
  const { locale } = useLocale();
  const copy = localizedCopy[locale];
  const [languages, setLanguages] = useState<LanguageRow[]>([]);
  const [rows, setRows] = useState<LanguagePreferenceDraft[]>([createEmptyPreference()]);
  const [persistedRows, setPersistedRows] = useState<UserLanguageRow[]>([]);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);

  useEffect(() => {
    let active = true;

    async function loadData() {
      try {
        setLoading(true);
        setError(null);

        const { languages: languageRows, preferences, rows: languageRowsPersisted } =
          await loadLanguagePreferences(userId);

        if (!active) {
          return;
        }

        setLanguages(languageRows);
        setPersistedRows(languageRowsPersisted);
        setRows(preferences.length > 0 ? preferences : [createEmptyPreference()]);
      } catch (loadError) {
        if (active) {
          setError(loadError instanceof Error ? loadError.message : copy.loadError);
        }
      } finally {
        if (active) {
          setLoading(false);
        }
      }
    }

    void loadData();

    return () => {
      active = false;
    };
  }, [copy.loadError, userId]);

  const selectedLanguageIds = useMemo(
    () => rows.map((row) => row.language_id).filter(Boolean),
    [rows]
  );

  const selectedLanguageSet = useMemo(() => new Set(selectedLanguageIds), [selectedLanguageIds]);

  function updateRow(index: number, update: Partial<LanguagePreferenceDraft>) {
    setRows((current) =>
      current.map((row, currentIndex) => {
        if (currentIndex !== index) {
          return row;
        }

        const nextRow = { ...row, ...update };

        if (update.proficiency === 'native') {
          nextRow.is_primary = true;
        }

        return nextRow;
      })
    );
    setSuccess(null);
  }

  function addRow() {
    setRows((current) => [
      ...current,
      {
        ...createEmptyPreference(),
        is_primary: current.length === 0
      }
    ]);
    setSuccess(null);
  }

  function removeRow(index: number) {
    setRows((current) => {
      if (current.length === 1) {
        return [createEmptyPreference()];
      }

      const nextRows = current.filter((_, currentIndex) => currentIndex !== index);

      if (!nextRows.some((row) => row.is_primary)) {
        nextRows[0] = {
          ...nextRows[0],
          is_primary: true
        };
      }

      return nextRows;
    });
    setSuccess(null);
  }

  function setPrimary(index: number) {
    setRows((current) =>
      current.map((row, currentIndex) => ({
        ...row,
        is_primary: currentIndex === index
      }))
    );
    setSuccess(null);
  }

  async function handleSubmit() {
    const chosenLanguages = rows.filter((row) => row.language_id.trim().length > 0);

    if (chosenLanguages.length === 0) {
      setError('Escolha pelo menos um idioma para continuar.');
      return;
    }

    try {
      setSaving(true);
      setError(null);
      setSuccess(null);

      const savedRows = await saveLanguagePreferences(userId, rows, persistedRows);

      setPersistedRows(savedRows);
      setRows(
        savedRows.length > 0
          ? savedRows.map((row) => ({
              id: row.id,
              language_id: row.language_id,
              proficiency: row.proficiency === 'advanced' ? 'fluent' : row.proficiency,
              is_primary: row.is_primary,
              notes: row.notes ?? ''
            }))
          : [createEmptyPreference()]
      );
      setSuccess(mode === 'onboarding' ? copy.savedOnboarding : copy.savedProfile);
      onSaved?.(savedRows);
    } catch (saveError) {
      setError(saveError instanceof Error ? saveError.message : copy.saveError);
    } finally {
      setSaving(false);
    }
  }

  if (loading) {
    return (
      <Card className="p-6 md:p-8">
        <div className="space-y-4">
          <div className="h-4 w-36 animate-pulse rounded-full bg-white/10" />
          <div className="h-20 animate-pulse rounded-2xl border border-white/10 bg-white/5" />
          <div className="h-20 animate-pulse rounded-2xl border border-white/10 bg-white/5" />
        </div>
      </Card>
    );
  }

  return (
    <Card className="p-6 md:p-8">
      <div className="flex flex-col gap-3 md:flex-row md:items-end md:justify-between">
        <div>
          <p className="pixel-label text-[10px] text-[#566172]">
            {mode === 'onboarding' ? copy.onboarding : copy.languages}
          </p>
          <h2 className="minecraft-title mt-2 text-3xl text-[#101114]">
            {mode === 'onboarding' ? copy.onboardingTitle : copy.profileTitle}
          </h2>
          <p className="mt-3 max-w-2xl text-sm leading-7 text-[#566172]">
            {mode === 'onboarding'
              ? copy.onboardingLead
              : copy.profileLead}
          </p>
        </div>

        <div className="flex flex-wrap gap-2">
          <Badge tone="neutral">{copy.levels.native}</Badge>
          <Badge tone="neutral">{copy.levels.fluent}</Badge>
          <Badge tone="neutral">{copy.levels.intermediate}</Badge>
          <Badge tone="neutral">{copy.levels.beginner}</Badge>
        </div>
      </div>

      <div className="mt-6 grid gap-4">
        {rows.map((row, index) => {
          const currentLanguage = languages.find((language) => language.id === row.language_id);
          const access = getLanguageWorkAccess(row.proficiency);

          return (
            <div
              key={row.id ?? `${index}-${row.language_id || 'new'}`}
              className="rounded-2xl border-2 border-[#101114] bg-[#fdfdfd] p-4 shadow-[4px_4px_0_#101114] transition duration-200 hover:-translate-y-0.5 hover:shadow-[6px_6px_0_#101114]"
            >
              <div className="flex flex-col gap-4 md:flex-row md:items-start md:justify-between">
                <div className="grid flex-1 gap-4 md:grid-cols-[minmax(0,1.5fr)_minmax(0,1fr)]">
                  <label className="grid gap-2">
                    <span className="text-[10px] uppercase tracking-[0.3em] text-[#566172]">
                      {copy.language}
                    </span>
                    <select
                      value={row.language_id}
                      onChange={(event) => updateRow(index, { language_id: event.target.value })}
                      className="w-full rounded-lg border-2 border-[#101114] bg-white px-3 py-3 text-sm font-medium text-[#101114] outline-none transition focus:border-[#4cc9f0]"
                    >
                      <option value="">{copy.choose}</option>
                      {languages.map((language) => (
                        <option
                          key={language.id}
                          value={language.id}
                          disabled={selectedLanguageSet.has(language.id) && language.id !== row.language_id}
                        >
                          {languageLabel(language)}
                        </option>
                      ))}
                    </select>
                  </label>

                  <label className="grid gap-2">
                    <span className="text-[10px] uppercase tracking-[0.3em] text-[#566172]">
                      {copy.proficiency}
                    </span>
                    <select
                      value={row.proficiency}
                      onChange={(event) =>
                        updateRow(index, {
                          proficiency: event.target.value as LanguagePreferenceDraft['proficiency']
                        })
                      }
                      className="w-full rounded-lg border-2 border-[#101114] bg-white px-3 py-3 text-sm font-medium text-[#101114] outline-none transition focus:border-[#4cc9f0]"
                    >
                      {editableProficiencies.map((proficiency) => (
                        <option key={proficiency} value={proficiency}>
                          {copy.levels[proficiency] ?? formatLanguageLevel(proficiency)}
                        </option>
                      ))}
                    </select>
                  </label>

                  <label className="grid gap-2 md:col-span-2">
                    <span className="text-[10px] uppercase tracking-[0.3em] text-[#566172]">
                      {copy.notes}
                    </span>
                    <input
                      value={row.notes}
                      onChange={(event) => updateRow(index, { notes: event.target.value })}
                      placeholder={copy.notesPlaceholder}
                      className="w-full rounded-lg border-2 border-[#101114] bg-white px-3 py-3 text-sm text-[#101114] outline-none transition placeholder:text-[#9aa3b2] focus:border-[#4cc9f0]"
                    />
                  </label>
                </div>

                <div className="flex min-w-[220px] flex-col gap-3">
                  <div className="flex flex-wrap gap-2">
                    <Badge tone={access.canReview ? 'success' : access.canTranslate ? 'warning' : 'neutral'}>
                      {copy.access[row.proficiency === 'advanced' ? 'fluent' : row.proficiency] ?? access.description}
                    </Badge>
                    {currentLanguage ? <Badge tone="neutral">{currentLanguage.code}</Badge> : null}
                  </div>

                  <button
                    type="button"
                    onClick={() => setPrimary(index)}
                    className={classNames(
                      'rounded-lg border-2 px-4 py-3 text-left text-sm font-bold transition',
                      row.is_primary
                        ? 'border-[#101114] bg-[#c7f464] text-[#101114]'
                        : 'border-[#101114] bg-white text-[#101114] hover:bg-[#f3f6fa]'
                    )}
                  >
                    <span className="block text-[10px] uppercase tracking-[0.3em] text-[#566172]">
                      {copy.primary}
                    </span>
                    <span className="mt-1 block">
                      {row.is_primary ? copy.selected : copy.setPrimary}
                    </span>
                  </button>

                  <button
                    type="button"
                    onClick={() => removeRow(index)}
                    className="rounded-lg border-2 border-[#ff6b5f] bg-[#fff0ee] px-4 py-3 text-sm font-bold text-[#a83c34] transition hover:bg-[#ffe4df]"
                  >
                    {copy.remove}
                  </button>
                </div>
              </div>
            </div>
          );
        })}
      </div>

      <div className="mt-5 flex flex-wrap items-center gap-3">
        <button
          type="button"
          onClick={addRow}
          className="rounded-lg border-2 border-[#101114] bg-white px-4 py-3 text-sm font-bold text-[#101114] transition hover:bg-[#f3f6fa]"
        >
          {copy.add}
        </button>

        <button
          type="button"
          onClick={() => void handleSubmit()}
          disabled={saving}
          className={classNames(
            'rounded-lg border-2 border-[#101114] px-5 py-3 text-sm font-bold transition',
            saving
              ? 'cursor-wait bg-[#d8dde6] text-[#566172]'
              : 'bg-[#101114] text-white hover:bg-[#1d2028]'
          )}
        >
          {saving
            ? copy.saving
            : mode === 'onboarding'
              ? copy.finish
              : copy.save}
        </button>
      </div>

      <div className="mt-5 grid gap-3 md:grid-cols-2">
        {rows.map((row, index) => (
          <div key={`${row.language_id || 'empty'}-${index}`} className="rounded-xl border border-[#dfe3ea] bg-[#f7f8fb] p-4">
            <p className="text-[10px] uppercase tracking-[0.3em] text-[#566172]">
              {rowTitle(row, languages)}
            </p>
            <p className="mt-2 text-sm font-bold text-[#101114]">
              {proficiencyDescriptions[row.proficiency]}
            </p>
            <p className="mt-1 text-sm text-[#566172]">
              {row.is_primary ? copy.primarySummary : copy.secondarySummary}
            </p>
          </div>
        ))}
      </div>

      {error ? (
        <p className="mt-4 rounded-xl border-2 border-[#ff6b5f] bg-[#fff0ee] px-4 py-3 text-sm font-medium text-[#a83c34]">
          {error}
        </p>
      ) : null}

      {success ? (
        <p className="mt-4 rounded-xl border-2 border-[#2da44e] bg-[#e4f5e8] px-4 py-3 text-sm font-medium text-[#187638]">
          {success}
        </p>
      ) : null}
    </Card>
  );
}
