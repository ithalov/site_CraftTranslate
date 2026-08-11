import fs from 'node:fs';
import path from 'node:path';
import process from 'node:process';

const projectRoot = process.cwd();
const batchesDir = path.join(projectRoot, 'supabase', 'import_batches');
const outputFile = path.join(batchesDir, 'import_translation_keys_all.sql');
const manifestFile = path.join(batchesDir, 'manifest.json');

function main() {
  if (!fs.existsSync(batchesDir)) {
    throw new Error('A pasta supabase/import_batches nao existe.');
  }

  const manifest = JSON.parse(fs.readFileSync(manifestFile, 'utf8'));
  const files = Array.isArray(manifest.files) ? manifest.files : [];
  if (files.length === 0) {
    throw new Error('O manifest nao tem arquivos de lote.');
  }

  const parts = [
    `-- Arquivo consolidado gerado a partir de ${files.length} lotes`,
    `-- Total de linhas: ${manifest.total_rows ?? 'desconhecido'}`,
    ``
  ];

  for (const fileName of files) {
    const batchPath = path.join(batchesDir, fileName);
    if (!fs.existsSync(batchPath)) {
      throw new Error(`Lote nao encontrado: ${fileName}`);
    }

    parts.push(`-- ===== ${fileName} =====`);
    parts.push(fs.readFileSync(batchPath, 'utf8').trimEnd());
    parts.push(``);
  }

  fs.writeFileSync(outputFile, `${parts.join('\n')}\n`, 'utf8');
  console.log(`Arquivo consolidado gerado em ${outputFile}`);
}

main();
