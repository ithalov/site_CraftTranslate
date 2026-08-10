import fs from 'node:fs';
import path from 'node:path';
import process from 'node:process';

const projectRoot = process.cwd();
const defaultSource = path.join(projectRoot, 'data', 'import', 'chattranslate_10000_source_strings.json');
const defaultOutputDir = path.join(projectRoot, 'supabase', 'import_batches');

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

function toArray(value) {
  if (!Array.isArray(value)) {
    return [];
  }

  return value.map((entry) => String(entry).trim()).filter((entry) => entry.length > 0);
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
  const supportedTargets = toArray(source.supported_targets);

  if (!keyName || !sourceText || !category || !context || supportedTargets.length === 0) {
    throw new Error(
      `Entrada ${index + 1} incompleta. key_name, source_text, category, context e supported_targets sao obrigatorios.`
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

function chunk(values, size) {
  const result = [];
  for (let index = 0; index < values.length; index += size) {
    result.push(values.slice(index, index + size));
  }
  return result;
}

function renderJsonBatch(batch) {
  return JSON.stringify(batch, null, 2);
}

function renderSqlBatch(batch, batchNumber, totalBatches) {
  const payload = renderJsonBatch(batch);
  return `begin;

  insert into public.translation_keys (
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

commit;
`;
}

function renderManifest(summary) {
  return JSON.stringify(summary, null, 2);
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
  const deduped = [];
  const seen = new Set();
  for (const entry of normalized) {
    if (seen.has(entry.key_name)) {
      continue;
    }
    seen.add(entry.key_name);
    deduped.push(entry);
  }

  fs.mkdirSync(outputDir, { recursive: true });
  for (const file of fs.readdirSync(outputDir)) {
    if (file.endsWith('.sql') || file === 'manifest.json') {
      fs.rmSync(path.join(outputDir, file), { force: true, recursive: true });
    }
  }

  const batches = chunk(deduped, batchSize);
  const createdFiles = [];

  batches.forEach((batch, index) => {
    const batchNumber = String(index + 1).padStart(3, '0');
    const fileName = `translation_keys_batch_${batchNumber}.sql`;
    const filePath = path.join(outputDir, fileName);
    fs.writeFileSync(filePath, renderSqlBatch(batch, index + 1, batches.length), 'utf8');
    createdFiles.push(fileName);
  });

  const manifest = {
    source: path.relative(projectRoot, sourcePath).replace(/\\/g, '/'),
    output_dir: path.relative(projectRoot, outputDir).replace(/\\/g, '/'),
    batch_size: batchSize,
    total_rows: deduped.length,
    total_batches: batches.length,
    files: createdFiles
  };

  fs.writeFileSync(path.join(outputDir, 'manifest.json'), renderManifest(manifest), 'utf8');

  console.log(`Gerados ${batches.length} lotes com ${deduped.length} strings em ${outputDir}`);
}

main().catch((error) => {
  console.error(error instanceof Error ? error.message : String(error));
  process.exitCode = 1;
});
