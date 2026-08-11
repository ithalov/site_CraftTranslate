import fs from 'node:fs';
import path from 'node:path';
import process from 'node:process';

const projectRoot = process.cwd();
const defaultSource = path.join(projectRoot, 'data', 'import', 'chattranslate_10000_source_strings.json');
const defaultOutputDir = path.join(projectRoot, 'supabase', 'import_one_shot');
const defaultSupportedTargets = ['pt-BR', 'fr', 'es', 'de', 'ru', 'ko', 'ja'];

function parseArgs(argv) {
  const args = new Map();
  for (let index = 2; index < argv.length; index += 1) {
    const current = argv[index];
    if (!current.startsWith('--')) {
      continue;
    }

    const next = argv[index + 1];
    if (!next || next.startsWith('--')) {
      args.set(current.slice(2), 'true');
      continue;
    }

    args.set(current.slice(2), next);
    index += 1;
  }

  return args;
}

function toArray(value, fallback = []) {
  if (!Array.isArray(value)) {
    return [...fallback];
  }

  const normalized = value
    .map((entry) => String(entry).trim())
    .filter((entry) => entry.length > 0);

  return normalized.length > 0 ? normalized : [...fallback];
}

function normalizeEntry(entry, index) {
  if (!entry || typeof entry !== 'object' || Array.isArray(entry)) {
    throw new Error(`Entrada invalida na posicao ${index + 1}.`);
  }

  const source = entry;
  const keyName = String(source.key_name ?? '').trim();
  const sourceText = String(source.source_text ?? '').trim();
  const category = String(source.category ?? '').trim();
  const subcategory = String(source.subcategory ?? '').trim();
  const context = String(source.context ?? '').trim();
  const notes = String(source.notes ?? '').trim();
  const protectedVariables = toArray(source.protected_variables);
  const protectedTerms = toArray(source.protected_terms);
  const supportedTargets = toArray(source.supported_targets, defaultSupportedTargets);

  if (!keyName || !sourceText || !category || !context) {
    throw new Error(
      `Entrada ${index + 1} incompleta. key_name, source_text, category e context sao obrigatorios.`
    );
  }

  return {
    key_name: keyName,
    original_text: sourceText,
    category,
    subcategory: subcategory.length > 0 ? subcategory : null,
    context,
    notes: notes.length > 0 ? notes : null,
    protected_variables: protectedVariables,
    protected_terms: protectedTerms,
    supported_targets: supportedTargets
  };
}

function dedupeByKey(entries) {
  const deduped = [];
  const seen = new Set();

  for (const entry of entries) {
    if (seen.has(entry.key_name)) {
      continue;
    }

    seen.add(entry.key_name);
    deduped.push(entry);
  }

  return deduped;
}

function chunk(values, size) {
  const result = [];
  for (let index = 0; index < values.length; index += size) {
    result.push(values.slice(index, index + size));
  }
  return result;
}

function renderBatchSql(batch) {
  const payload = JSON.stringify(batch, null, 2);
  return `insert into public.translation_keys (
  key_name,
  source_language_id,
  original_text,
  category,
  subcategory,
  context,
  protected_variables,
  protected_terms,
  notes,
  supported_targets,
  status
)
select
  src.key_name,
  (select id from public.languages where lower(code) = 'en' limit 1),
  src.original_text,
  src.category,
  nullif(src.subcategory, ''),
  nullif(src.context, ''),
  coalesce(src.protected_variables, '{}'::text[]),
  coalesce(src.protected_terms, '{}'::text[]),
  nullif(src.notes, ''),
  coalesce(src.supported_targets, '{}'::text[]),
  'active'::public.translation_key_status
from jsonb_to_recordset($$${payload}$$::jsonb) as src(
  key_name text,
  original_text text,
  category text,
  subcategory text,
  context text,
  notes text,
  protected_variables text[],
  protected_terms text[],
  supported_targets text[]
)
on conflict (key_name) do update set
  source_language_id = excluded.source_language_id,
  original_text = excluded.original_text,
  category = excluded.category,
  subcategory = excluded.subcategory,
  context = excluded.context,
  protected_variables = excluded.protected_variables,
  protected_terms = excluded.protected_terms,
  notes = excluded.notes,
  supported_targets = excluded.supported_targets,
  status = excluded.status,
  updated_at = timezone('utc', now());
`;
}

function renderSqlFile(batches, rowCount) {
  const parts = [
    `\\set ON_ERROR_STOP on`,
    `begin;`,
    `do $$`,
    `begin`,
    `  if not exists (`,
    `    select 1`,
    `    from public.languages`,
    `    where lower(code) = 'en'`,
    `  ) then`,
    `    raise exception 'Idioma EN nao encontrado em public.languages.';`,
    `  end if;`,
    `end $$;`,
    ``
  ];

  batches.forEach((batch, index) => {
    parts.push(`-- batch ${String(index + 1).padStart(2, '0')} of ${batches.length}`);
    parts.push(renderBatchSql(batch));
  });

  parts.push(`commit;`);
  parts.push(``);
  parts.push(`-- total_rows: ${rowCount}`);
  return parts.join('\n');
}

async function main() {
  const args = parseArgs(process.argv);
  const sourcePath = path.resolve(String(args.get('source') ?? defaultSource));
  const outputDir = path.resolve(String(args.get('out') ?? defaultOutputDir));
  const batchSize = Number(args.get('batch-size') ?? '500');

  if (!Number.isInteger(batchSize) || batchSize <= 0) {
    throw new Error('O batch-size precisa ser um numero inteiro positivo.');
  }

  const raw = fs.readFileSync(sourcePath, 'utf8');
  const parsed = JSON.parse(raw);
  if (!Array.isArray(parsed)) {
    throw new Error('O arquivo de origem precisa conter um array JSON.');
  }

  const normalized = parsed.map((entry, index) => normalizeEntry(entry, index));
  const deduped = dedupeByKey(normalized);
  const batches = chunk(deduped, batchSize);

  fs.mkdirSync(outputDir, { recursive: true });
  for (const file of fs.readdirSync(outputDir)) {
    fs.rmSync(path.join(outputDir, file), { force: true, recursive: true });
  }

  const sqlFileName = 'import_translation_keys.sql';
  const sqlPath = path.join(outputDir, sqlFileName);

  fs.writeFileSync(sqlPath, renderSqlFile(batches, deduped.length), 'utf8');

  const manifest = {
    source: path.relative(projectRoot, sourcePath).replace(/\\/g, '/'),
    output_dir: path.relative(projectRoot, outputDir).replace(/\\/g, '/'),
    batch_size: batchSize,
    total_rows: deduped.length,
    total_batches: batches.length,
    files: [sqlFileName],
    supported_targets_default: defaultSupportedTargets
  };

  fs.writeFileSync(path.join(outputDir, 'manifest.json'), JSON.stringify(manifest, null, 2), 'utf8');
  console.log(`Gerado arquivo unico com ${deduped.length} strings em ${sqlPath}`);
}

main().catch((error) => {
  console.error(error instanceof Error ? error.message : String(error));
  process.exitCode = 1;
});
