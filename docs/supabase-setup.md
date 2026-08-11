# Configuração do Supabase

Este guia explica, passo a passo, como criar o projeto no Supabase e deixar toda a base pronta para o ChatTranslate Web.

O objetivo aqui é sair da criação do projeto até o ponto em que:

- o projeto está configurado no Supabase
- a autenticação com Discord está pronta
- o banco está com as migrations aplicadas
- as políticas de RLS estão ativas
- as views públicas estão disponíveis
- o frontend pode usar apenas a `anon key`

## 1. Criar o projeto no Supabase

1. Entre em [supabase.com](https://supabase.com/).
2. Faça login na sua conta.
3. Clique em **New project**.
4. Selecione a organização onde o projeto vai ficar.
5. Dê um nome para o projeto, por exemplo:
   - `ChatTranslate Web`
6. Crie uma senha forte para o banco de dados.
7. Escolha a região mais próxima do seu público, de preferência uma região estável e próxima do Brasil.
8. Clique em **Create new project**.
9. Aguarde a criação terminar.

## 2. Guardar as credenciais corretas

Quando o projeto terminar de criar, você vai precisar copiar dois dados:

- a URL do projeto
- a `anon key`

Project URL
https://xjpjyjiqdjngnlxqgoff.supabase.co/
Key Publish
sb_publishable_NbgytIMLTf0y6aSrKtTaNg_CmFgAlJU

Esses são os únicos dados do Supabase que vão para o frontend.

### Onde encontrar

1. Abra o projeto no painel do Supabase.
2. Vá em **Project Settings**.
3. Abra **API**.
4. Copie:
   - **Project URL**
   - **anon public key**

### O que nunca copiar para o frontend

Não coloque em nenhum arquivo `.env` do frontend:

- `service_role key`
- senha do banco
- tokens privados
- chaves de serviço

Esses segredos não podem aparecer em `src`, `public` ou em variáveis `VITE_*`.

## 3. Configurar o arquivo `.env.local`

No projeto local, use um arquivo `.env.local` com os valores públicos.

Exemplo:

```env
VITE_APP_NAME=ChatTranslate Web
VITE_SUPABASE_URL=https://seu-projeto.supabase.co
VITE_SUPABASE_ANON_KEY=sua_anon_key
VITE_DISCORD_CLIENT_ID=seu_discord_client_id
VITE_DISCORD_REDIRECT_URI=https://ithalov.github.io/site_CraftTranslate/auth/callback
VITE_BASE_PATH=/site_CraftTranslate/
```

Depois de preencher, o frontend já consegue falar com o Supabase usando apenas a chave pública.

## 4. Habilitar a autenticação com Discord

Agora vamos configurar o login com Discord dentro do Supabase.

### 4.1 Criar o app no Discord

Se você ainda não criou o app do Discord, faça isso primeiro:

1. Abra o [Discord Developer Portal](https://discord.com/developers/applications).
2. Clique em **New Application**.
3. Dê o nome `ChatTranslate Web`.
4. Entre no app criado.
5. Vá até **OAuth2**.
6. Copie o **Client ID**.
7. Copie o **Client Secret** e guarde em local seguro.

### 4.2 Habilitar o provedor no Supabase

1. Volte para o painel do Supabase.
2. Abra o menu **Authentication**.
3. Clique em **Providers**.
4. Procure por **Discord**.
5. Ative o provedor.
6. Cole o `Client ID`.
7. Cole o `Client Secret`.
8. Salve as alterações.

### 4.3 Configurar as URLs de redirect

No Discord e no Supabase, adicione estas URLs:

- `http://localhost:5173/auth/callback`
- `https://ithalov.github.io/site_CraftTranslate/auth/callback`

Essas URLs precisam bater exatamente com o que o app usa.

## 5. Configurar as URLs do projeto no Supabase Auth

No painel do Supabase:

1. Acesse **Authentication**.
2. Abra **URL Configuration**.
3. Configure a **Site URL** com a URL final do app.
4. Adicione os redirect URLs permitidos.

### Em desenvolvimento local

Use:

```text
http://localhost:5173
```

### Em produção no GitHub Pages

Use a URL publicada do projeto, por exemplo:

```text
https://ithalov.github.io/site_CraftTranslate
```

## 6. Aplicar as migrations SQL

Agora vamos criar o banco de dados real do projeto.

Todas as migrations estão em:

```text
supabase/migrations/
```

## Ordem correta

Aplique nesta ordem:

1. `202608090001_init.sql`
2. `202608090002_seed_languages.sql`
3. `202608090003_schema_principal.sql`
4. `202608090004_rls_rigorous.sql`
5. `202608090005_public_views.sql`
6. `202608090006_discord_profiles.sql`
7. `202608090007_language_onboarding.sql`

## Como aplicar

Você pode fazer isso de duas formas:

### Opção 1: pelo SQL Editor

1. Abra o Supabase.
2. Entre em **SQL Editor**.
3. Cole o conteúdo de cada migration.
4. Execute uma por vez, na ordem correta.

### Opção 2: pelo Supabase CLI

Se você usa Supabase CLI:

1. Faça login com `supabase login`.
2. Conecte o projeto local ao projeto remoto.
3. Rode as migrations em ordem.

Se você estiver em dúvida, o caminho mais simples é usar o SQL Editor.

## 7. O que cada migration faz

### `202608090001_init.sql`

Cria a base inicial do projeto e prepara a estrutura principal.

### `202608090002_seed_languages.sql`

Insere os idiomas iniciais que o sistema vai oferecer.

### `202608090003_schema_principal.sql`

Cria as tabelas principais do projeto:

- `profiles`
- `languages`
- `user_languages`
- `language_members`
- `translation_keys`
- `translation_suggestions`
- `reviews`
- `translation_votes`
- `translation_comments`
- `glossary`
- `glossary_proposals`
- `badges`
- `user_badges`
- `reputation_events`
- `xp_events`
- `reports`
- `donations`

### `202608090004_rls_rigorous.sql`

Ativa e configura o Row Level Security para proteger os dados privados.

### `202608090005_public_views.sql`

Cria as views públicas seguras para ranking, perfis públicos e progresso.

### `202608090006_discord_profiles.sql`

Adiciona a integração de perfis com o Discord.

### `202608090007_language_onboarding.sql`

Adiciona a proficiência `fluent` para suportar o onboarding de idiomas.

## 8. Conferir se o RLS está ativo

Depois das migrations, confira se as tabelas sensíveis têm RLS habilitado.

O objetivo é este:

- visitante não pode ver dados privados
- usuário só acessa o que é dele
- tradutor só trabalha nos idiomas permitidos
- reviewer só vê filas permitidas
- moderador só controla os idiomas dele
- admin e owner podem administrar o sistema

Se algo estiver exposto demais, corrija antes de seguir.

## 9. Verificar as views públicas

Estas views são a forma segura de expor dados públicos sem abrir tabelas internas:

- `public_profile_cards_view`
- `public_leaderboard_view`
- `public_language_progress_view`

Elas devem ser usadas pelo frontend para:

- ranking
- progresso de idiomas
- cards públicos de perfil

## 10. Confirmar a tabela de idiomas e onboarding

## 11. Importar 10k strings sem pesar o banco

Para subir as strings grandes sem criar uma migration gigante, use o pacote em lotes.

### O que foi preparado no projeto

- o arquivo bruto com as 10k strings fica em `data/import/chattranslate_10000_source_strings.json`
- o gerador de lotes fica em `scripts/generate-translation-import.mjs`
- a importação vai para `supabase/import_batches/`
- a tabela `translation_keys` ganhou a coluna `supported_targets`
- a fila de tradução passa a respeitar os idiomas suportados por cada string

### Gerar os lotes

Rode no projeto local:

```bash
npm run generate:translation-import
```

Por padrão o script:

- lê o JSON de origem
- valida `key_name`, `source_text`, `category`, `context` e `supported_targets`
- remove duplicatas por `key_name`
- cria arquivos SQL pequenos com 500 itens por lote

### Onde os lotes ficam

Depois de gerar, os arquivos vão aparecer em:

```text
supabase/import_batches/
```

Você vai ver algo assim:

- `translation_keys_batch_001.sql`
- `translation_keys_batch_002.sql`
- `translation_keys_batch_003.sql`
- ...
- `manifest.json`

### Como importar no Supabase

1. Abra o Supabase.
2. Vá em **SQL Editor**.
3. Execute os arquivos na ordem, do `001` em diante.
4. Se preferir, cole um lote por vez e rode aos poucos.

### Por que isso nao pesa

Esse fluxo evita:

- uma migration enorme com 10k inserts
- um SQL Editor travando com um bloco gigante
- dependência do frontend para carregar a base inteira

Em vez disso, voce mantém:

- o arquivo bruto no GitHub
- a importação em lotes
- o banco com a fila real e filtrada por idioma suportado

### Regra da fila

Agora a fila só mostra uma string se:

- ela estiver ativa
- ela for da categoria escolhida
- o idioma destino existir no `supported_targets`

Se o array `supported_targets` vier vazio, a string continua valendo para todos os idiomas.

Confira se a tabela `user_languages` está funcionando corretamente.

Ela precisa guardar:

- idioma escolhido
- nível de proficiência
- idioma principal
- notas opcionais
- vínculo com o usuário

O onboarding do app depende disso para decidir quais tarefas o usuário pode receber.

## 11. Testar o fluxo de login

Depois de configurar o Supabase, o teste básico deve funcionar assim:

1. O usuário clica em `Continue with Discord`.
2. O Supabase abre o fluxo de autenticação.
3. O login volta para `/auth/callback`.
4. O app cria ou recupera a sessão.
5. O perfil é criado automaticamente no primeiro acesso.
6. Se o usuário ainda não tiver idiomas, ele vai para o onboarding.

## 12. Checklist final da parte Supabase

Antes de considerar o Supabase pronto, confirme:

- o projeto foi criado
- a `anon key` foi copiada para o `.env.local`
- o Discord OAuth está ativo
- os redirect URLs estão corretos
- as migrations foram aplicadas na ordem certa
- as políticas de RLS estão habilitadas
- as views públicas foram criadas
- o onboarding de idiomas funciona

## 13. O que deve ficar pronto ao final

Quando terminar esta parte, o Supabase já deve estar pronto para o app usar:

- login com Discord funcionando
- sessão persistente funcionando
- perfil automático funcionando
- idiomas do usuário salvos
- dados privados protegidos
- ranking e progresso expostos com segurança

Depois disso, o restante do desenvolvimento pode usar o banco sem precisar refazer a base.

## 14. Importacao rapida de 10 mil strings com `psql`

Se voce quer subir tudo em uma tacada so, a forma mais rapida e gerar um CSV e importar com `psql` usando `\\copy`.

### Gerar os arquivos de importacao

```bash
npm run generate:translation-psql
```

Isso cria:

- `supabase/import_psql/translation_keys_import.csv`
- `supabase/import_psql/import_translation_keys.psql`

### Rodar a importacao

Use a connection string do banco do Supabase:

```bash
psql "postgresql://postgres:SUA_SENHA@db.SEU-PROJETO.supabase.co:5432/postgres" -f supabase/import_psql/import_translation_keys.psql
```

Se quiser um atalho no Windows, use o script da raiz do projeto:

```powershell
.\import.ps1
```

Ou, para dar dois cliques no Windows:

```text
import.cmd
```

Se preferir passar a connection string sem digitar no prompt:

```powershell
$env:SUPABASE_DATABASE_URL="postgresql://postgres:SUA_SENHA@db.SEU-PROJETO.supabase.co:5432/postgres"
.\import.ps1
```

### Vantagens desse caminho

- o `\\copy` joga os dados muito mais rapido que inserts grandes no SQL Editor
- a tabela temporaria reduz o peso durante a carga
- o `ON CONFLICT (key_name)` evita duplicar os dados se voce rodar de novo

### Observacao importante

O script assume que existe um idioma com `code = 'en'` em `public.languages`.
Se no seu seed de idiomas esse codigo estiver diferente, ajuste a verificacao dentro do arquivo `.psql` antes de executar.

## 15. Opcao mais simples: um unico arquivo `.sql`

Se voce nao quer instalar nada e quer fazer tudo pelo navegador, use este caminho.

### Gerar o arquivo unico

```bash
npm run generate:translation-one-shot
```

Isso cria:

- `supabase/import_one_shot/import_translation_keys.sql`

### Como aplicar

1. Abra o arquivo gerado.
2. Copie todo o conteudo.
3. Cole no **SQL Editor** do Supabase.
4. Execute uma vez.

### Quando usar essa opcao

Use essa opcao se:

- voce quer o caminho mais simples possivel
- nao quer instalar `psql`
- prefere usar apenas o navegador

### Observacao

Esse arquivo ainda pode ficar grande, mas ele ja vem dividido em lotes internos para aliviar a execucao.

## 16. Um unico arquivo juntando os 20 lotes

Se voce ja tem os arquivos `translation_keys_batch_001.sql` ate `translation_keys_batch_020.sql`, pode juntar tudo em um arquivo master:

```bash
npm run merge:translation-batches
```

Ele gera:

- `supabase/import_batches/import_translation_keys_all.sql`

Esse arquivo e o mais pratico para colar no SQL Editor quando voce ja tem os lotes prontos.
