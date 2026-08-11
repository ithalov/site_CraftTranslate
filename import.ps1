param(
  [string]$DatabaseUrl = $env:SUPABASE_DATABASE_URL,
  [string]$PsqlPath = $env:PSQL_PATH,
  [string]$SourcePath = "data/import/chattranslate_10000_source_strings.json",
  [string]$OutputDir = "supabase/import_psql",
  [switch]$SkipGeneration,
  [switch]$NoPause
)

$ErrorActionPreference = "Stop"
$script:ExitCode = 0

function Write-Info([string]$Message) {
  Write-Host "[ChatTranslate] $Message" -ForegroundColor Cyan
}

function Write-Warn([string]$Message) {
  Write-Host "[ChatTranslate] $Message" -ForegroundColor Yellow
}

function Fail([string]$Message) {
  Write-Host "[ChatTranslate] $Message" -ForegroundColor Red
  $script:ExitCode = 1
  throw $Message
}

function Get-PsqlPath {
  param(
    [string]$ExplicitPath
  )

  if (-not [string]::IsNullOrWhiteSpace($ExplicitPath) -and (Test-Path $ExplicitPath)) {
    return (Resolve-Path $ExplicitPath).Path
  }

  $command = Get-Command psql -ErrorAction SilentlyContinue
  if (-not $command) {
    $commonRoots = @(
      'C:\Program Files\PostgreSQL',
      'C:\Program Files (x86)\PostgreSQL'
    )

    foreach ($root in $commonRoots) {
      if (-not (Test-Path $root)) {
        continue
      }

      $candidate = Get-ChildItem -Path $root -Recurse -Filter psql.exe -ErrorAction SilentlyContinue |
        Select-Object -First 1 -ExpandProperty FullName

      if ($candidate) {
        return $candidate
      }
    }

    return $null
  }

  if ($command.Path) {
    return $command.Path
  }

  if ($command.Source) {
    return $command.Source
  }

  return $command.Name
}

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptRoot

try {
  Write-Info "Raiz do projeto: $scriptRoot"

  $sourceFullPath = Join-Path $scriptRoot $SourcePath
  $outputFullPath = Join-Path $scriptRoot $OutputDir
  $psqlScriptPath = Join-Path $outputFullPath "import_translation_keys.psql"

  if (-not (Test-Path $sourceFullPath)) {
    Fail "Nao encontrei o arquivo de origem em $SourcePath"
  }

  if (-not $SkipGeneration) {
    Write-Info "Gerando o pacote de importacao..."
    npm run generate:translation-psql
    if ($LASTEXITCODE -ne 0) {
      Fail "Falha ao gerar o pacote de importacao."
    }
  }

  if (-not (Test-Path $psqlScriptPath)) {
    Fail "Nao encontrei o script $psqlScriptPath. Rode a geracao primeiro."
  }

  if ([string]::IsNullOrWhiteSpace($DatabaseUrl)) {
    $DatabaseUrl = Read-Host "Cole a connection string do banco Supabase"
  }

  if ([string]::IsNullOrWhiteSpace($DatabaseUrl)) {
    Fail "Connection string vazia."
  }

  $psqlPath = Get-PsqlPath -ExplicitPath $PsqlPath
  if (-not $psqlPath) {
    Fail @"
O comando psql nao foi encontrado.

O que fazer:
1. Instale o PostgreSQL Client Tools ou o PostgreSQL completo.
2. Garanta que o arquivo psql.exe exista.
3. Se ele estiver instalado em um caminho diferente, use:
   -PsqlPath "C:\caminho\para\psql.exe"

Exemplo comum:
C:\Program Files\PostgreSQL\16\bin\psql.exe
"@
  }

  Write-Info "Usando psql em: $psqlPath"
  Write-Warn "Se aparecer prompt do Windows Firewall ou do cliente PostgreSQL, confirme para continuar."
  Write-Info "Iniciando importacao..."

  & $psqlPath $DatabaseUrl -f $psqlScriptPath

  if ($LASTEXITCODE -ne 0) {
    Fail "A importacao terminou com erro. Verifique a saida acima."
  }

  Write-Info "Importacao concluida com sucesso."
}
catch {
  if ($script:ExitCode -eq 0) {
    $script:ExitCode = 1
  }

  Write-Host ""
  Write-Host "[ChatTranslate] Detalhe do erro:" -ForegroundColor Red
  Write-Host $_.Exception.Message -ForegroundColor Red
}
finally {
  if (-not $NoPause -and $Host.Name -eq 'ConsoleHost') {
    Write-Host ""
    Read-Host "Pressione Enter para fechar"
  }
  exit $script:ExitCode
}
