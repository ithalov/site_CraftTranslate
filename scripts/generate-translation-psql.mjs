import fs from 'node:fs';
import path from 'node:path';
import process from 'node:process';

const projectRoot = process.cwd();
const defaultSource = path.join(projectRoot, 'data', 'import', 'chattranslate_10000_source_strings.json');
const defaultOutputDir = path.join(projectRoot, 'supabase', 'import_psql');
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

function escapeCsv(value) {
  const stringValue = String(value ?? '');
  if (/[",\r\n]/.test(stringValue)) {
    return `"${stringValue.replace(/"/g, '""')}"`;
  }

  return stringValue;
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
    protected_variables_json: JSON.stringify(protectedVariables),
    protected_terms_json: JSON.stringify(protectedTerms),
    supported_targets_json: JSON.stringify(supportedTargets)
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

function renderCsv(rows) {
  const header = [
    'key_name',
    'original_text',
    'category',
    'subcategory',
    'context',
    'notes',
    'protected_variables_json',
    'protected_terms_json',
    'supported_targets_json'
  ];

  const lines = [header.map(escapeCsv).join(',')];

  for (const row of rows) {
    lines.push(
      [
        row.key_name,
        row.original_text,
        row.category,
        row.subcategory ?? '',
        row.context,
        row.notes ?? '',
        row.protected_variables_json,
        row.protected_terms_json,
        row.supported_targets_json
      ]
        .map(escapeCsv)
        .join(',')
    );
  }

  return `${lines.join('\n')}\n`;
}

function renderPsqlScript(csvRelativePath, rowCount) {
  return `\\set ON_ERROR_STOP on
\\echo 'Importando ${rowCount} strings com \\\\copy...'

begin;

do $$
begin
  if not exists (
    select 1
    from public.languages
    where lower(code) = 'en'
  ) then
    raise exception 'Idioma EN nao encontrado em public.languages.';
  end if;
end $$;

create temporary table translation_keys_import_stage (
  key_name text not null,
  original_text text not null,
  category text not null,
  subcategory text,
  context text not null,
  notes text,
  protected_variables_json text,
  protected_terms_json text,
  supported_targets_json text
) on commit drop;

\\copy translation_keys_import_stage (
  key_name,
  original_text,
  category,
  subcategory,
  context,
  notes,
  protected_variables_json,
  protected_terms_json,
  supported_targets_json
) from '${csvRelativePath}' with (format csv, header true, encoding 'UTF8')

with parsed as (
  select
    s.key_name,
    s.original_text,
    s.category,
    nullif(s.subcategory, '') as subcategory,
    nullif(s.context, '') as context,
    nullif(s.notes, '') as notes,
    coalesce(
      (
        select array_agg(value)
        from jsonb_array_elements_text(nullif(s.protected_variables_json, '')::jsonb) as value
      ),
      '{}'::text[]
    ) as protected_variables,
    coalesce(
      (
        select array_agg(value)
        from jsonb_array_elements_text(nullif(s.protected_terms_json, '')::jsonb) as value
      ),
      '{}'::text[]
    ) as protected_terms,
    coalesce(
      (
        select array_agg(value)
        from jsonb_array_elements_text(nullif(s.supported_targets_json, '')::jsonb) as value
      ),
      '{}'::text[]
    ) as supported_targets
  from translation_keys_import_stage s
)
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
  p.key_name,
  (select id from public.languages where lower(code) = 'en' limit 1),
  p.original_text,
  p.category,
  p.subcategory,
  p.context,
  p.protected_variables,
  p.protected_terms,
  p.notes,
  p.supported_targets,
  'active'::public.translation_key_status
from parsed p
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

  const raw = fs.readFileSync(sourcePath, 'utf8');
  const parsed = JSON.parse(raw);
  if (!Array.isArray(parsed)) {
    throw new Error('O arquivo de origem precisa conter um array JSON.');
  }

  const normalized = parsed.map((entry, index) => normalizeEntry(entry, index));
  const deduped = dedupeByKey(normalized);

  fs.mkdirSync(outputDir, { recursive: true });
  for (const file of fs.readdirSync(outputDir)) {
    fs.rmSync(path.join(outputDir, file), { force: true, recursive: true });
  }

  const csvFileName = 'translation_keys_import.csv';
  const psqlFileName = 'import_translation_keys.psql';
  const csvPath = path.join(outputDir, csvFileName);
  const psqlPath = path.join(outputDir, psqlFileName);

  fs.writeFileSync(csvPath, renderCsv(deduped), 'utf8');
  fs.writeFileSync(psqlPath, renderPsqlScript(`supabase/import_psql/${csvFileName}`, deduped.length), 'utf8');

  const manifest = {
    source: path.relative(projectRoot, sourcePath).replace(/\\/g, '/'),
    output_dir: path.relative(projectRoot, outputDir).replace(/\\/g, '/'),
    total_rows: deduped.length,
    files: [csvFileName, psqlFileName],
    supported_targets_default: defaultSupportedTargets
  };

  fs.writeFileSync(path.join(outputDir, 'manifest.json'), renderManifest(manifest), 'utf8');

  console.log(`Gerados ${deduped.length} registros em ${outputDir}`);
}

main().catch((error) => {
  console.error(error instanceof Error ? error.message : String(error));
  process.exitCode = 1;
});
