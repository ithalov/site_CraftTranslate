import translationSeed from '@/data/translation-seed.json';
import { generatedTranslationContent } from '@/data/generated-translation-content';

export type WorkspaceSourceString = {
  id: string;
  key_name: string;
  source_text: string;
  category: string;
  subcategory: string | null;
  theme: string | null;
  context: string;
  notes: string;
  protected_variables: string[];
  protected_terms: string[];
  supported_targets: string[];
};

export type WorkspaceContentSummary = {
  localSeedCount: number;
  generatedCount: number;
  remoteCount: number;
  totalCount: number;
  remoteSourceUrl: string;
  remoteLoaded: boolean;
};

type RemoteWorkspaceSourceString = Partial<WorkspaceSourceString> & {
  id?: unknown;
  key_name?: unknown;
  source_text?: unknown;
  category?: unknown;
  subcategory?: unknown;
  theme?: unknown;
  context?: unknown;
  notes?: unknown;
  protected_variables?: unknown;
  protected_terms?: unknown;
  supported_targets?: unknown;
};

const DEFAULT_REMOTE_SOURCE_URL =
  'https://raw.githubusercontent.com/ithalov/site_CraftTranslate/main/data/import/chattranslate_10000_source_strings.json';

const REMOTE_SOURCE_URL = import.meta.env.VITE_TRANSLATION_CONTENT_URL?.trim() || DEFAULT_REMOTE_SOURCE_URL;

let remoteSourcePromise: Promise<WorkspaceSourceString[]> | null = null;
let workspaceSourcePromise: Promise<WorkspaceSourceString[]> | null = null;
let summaryPromise: Promise<WorkspaceContentSummary> | null = null;

function toStringArray(value: unknown) {
  if (!Array.isArray(value)) {
    return [];
  }

  return value.map((item) => String(item)).filter((item) => item.trim().length > 0);
}

function normalizeTargets(value: unknown) {
  const targets = toStringArray(value);

  if (targets.length > 0) {
    return targets;
  }

  return translationSeed.supported_targets;
}

function normalizeSourceString(value: unknown, fallbackId: string): WorkspaceSourceString | null {
  if (!value || typeof value !== 'object' || Array.isArray(value)) {
    return null;
  }

  const entry = value as RemoteWorkspaceSourceString;
  const id = String(entry.id ?? fallbackId).trim();
  const keyName = String(entry.key_name ?? id).trim();
  const sourceText = String(entry.source_text ?? '').trim();
  const category = String(entry.category ?? 'general').trim();
  const context = String(entry.context ?? '').trim();

  if (id.length === 0 || keyName.length === 0 || sourceText.length === 0) {
    return null;
  }

  return {
    id,
    key_name: keyName,
    source_text: sourceText,
    category,
    subcategory: entry.subcategory == null || String(entry.subcategory).trim().length === 0 ? null : String(entry.subcategory).trim(),
    theme: entry.theme == null || String(entry.theme).trim().length === 0 ? null : String(entry.theme).trim(),
    context,
    notes: String(entry.notes ?? '').trim(),
    protected_variables: toStringArray(entry.protected_variables),
    protected_terms: toStringArray(entry.protected_terms),
    supported_targets: normalizeTargets(entry.supported_targets)
  };
}

function dedupeSourceStrings(entries: WorkspaceSourceString[]) {
  const byKeyName = new Map<string, WorkspaceSourceString>();

  entries.forEach((entry) => {
    if (!byKeyName.has(entry.key_name)) {
      byKeyName.set(entry.key_name, entry);
      return;
    }

    byKeyName.set(entry.key_name, entry);
  });

  return [...byKeyName.values()];
}

async function loadRemoteSourceStrings() {
  if (!remoteSourcePromise) {
    remoteSourcePromise = (async () => {
      try {
        const response = await fetch(REMOTE_SOURCE_URL, {
          headers: {
            Accept: 'application/json'
          }
        });

        if (!response.ok) {
          return [];
        }

        const payload = (await response.json()) as unknown;
        const sourceArray = Array.isArray(payload)
          ? payload
          : payload && typeof payload === 'object' && Array.isArray((payload as { strings?: unknown }).strings)
            ? ((payload as { strings: unknown[] }).strings as unknown[])
            : [];

        return sourceArray
          .map((item, index) => normalizeSourceString(item, `remote-${index + 1}`))
          .filter((item): item is WorkspaceSourceString => item !== null);
      } catch {
        return [];
      }
    })();
  }

  return remoteSourcePromise;
}

export async function loadWorkspaceSourceStrings() {
  if (!workspaceSourcePromise) {
    workspaceSourcePromise = (async () => {
      const remoteStrings = await loadRemoteSourceStrings();
      const localStrings = [...translationSeed.strings, ...generatedTranslationContent];

      return dedupeSourceStrings([...localStrings, ...remoteStrings]);
    })();
  }

  return workspaceSourcePromise;
}

export async function getWorkspaceContentSummary() {
  if (!summaryPromise) {
    summaryPromise = (async () => {
      const remoteStrings = await loadRemoteSourceStrings();
      const localSeedCount = translationSeed.strings.length;
      const generatedCount = generatedTranslationContent.length;
      const totalCount = dedupeSourceStrings([
        ...translationSeed.strings,
        ...generatedTranslationContent,
        ...remoteStrings
      ]).length;

      return {
        localSeedCount,
        generatedCount,
        remoteCount: remoteStrings.length,
        totalCount,
        remoteSourceUrl: REMOTE_SOURCE_URL,
        remoteLoaded: remoteStrings.length > 0
      };
    })();
  }

  return summaryPromise;
}

