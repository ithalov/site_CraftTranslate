# Deploy no GitHub Pages

Este guia mostra como criar o repositório, subir o website para o GitHub e deixar o deploy automático funcionando no GitHub Pages.

O projeto já vem com um workflow em:

```text
.github/workflows/deploy.yml
```

Esse workflow faz o build e publica o site sempre que você faz push na branch `main`.

## 1. O que você precisa antes de começar

Antes de subir o projeto, confirme que você já tem:

- conta no GitHub
- projeto local funcionando
- `npm install` já executado
- `.env.local` configurado para desenvolvimento
- build local passando com `npm run build`

Se o build local não passar, corrija isso antes de seguir.

## 2. Criar o repositório no GitHub

1. Entre em [github.com](https://github.com/).
2. Clique em **New repository**.
3. Use o nome:

```text
site_CraftTranslate
```

4. Deixe o repositório como preferir:
   - público, se quiser que o site seja acessível e o projeto visível
   - privado, se o plano permitir o Pages do jeito que você pretende usar
5. Não marque para criar `README`, `.gitignore` ou licença se o projeto local já existe.
6. Clique em **Create repository**.

## 3. Conectar o projeto local ao GitHub

Se o projeto ainda não estiver versionado com Git, rode estes comandos na pasta do projeto:

```bash
git init
git add .
git commit -m "Initial commit"
```

Depois adicione o repositório remoto:

```bash
git remote add origin https://github.com/ithalov/site_CraftTranslate.git
```

Se o branch principal ainda não for `main`, renomeie:

```bash
git branch -M main
```

Agora envie tudo para o GitHub:

```bash
git push -u origin main
```

Se você já tiver commits anteriores, basta usar o `git push` correspondente ao seu fluxo.

## 4. Confirmar o build local antes do deploy

Antes de depender do GitHub Pages, confirme que o site compila localmente:

```bash
npm run build
```

Esse comando gera a versão final do site na pasta `dist`. Se der erro aqui, não vale a pena subir para o GitHub ainda.

Se quiser testar o resultado do build:

```bash
npm run preview
```

O `preview` abre uma versão local do que foi gerado pelo build, ajudando a conferir se as rotas e a tela de login continuam funcionando antes do deploy.

## 5. Como o deploy automático funciona

Este projeto já tem um workflow de GitHub Actions que:

- instala as dependências
- faz o build
- publica a pasta `dist`
- envia o site para o GitHub Pages

O workflow roda quando você faz push na branch `main`.

Se quiser disparar manualmente, também existe suporte a `workflow_dispatch`.

## 6. Configurar o GitHub Pages no repositório

Depois de enviar o código para o GitHub:

1. Abra o repositório `ithalov/site_CraftTranslate`.
2. Vá em **Settings**.
3. No menu lateral, abra **Pages**.
4. Em **Build and deployment**, escolha:
   - **Source**: `GitHub Actions`
5. Salve.

Com isso, o próprio workflow do projeto passa a publicar o site.

## 7. Ajustar a base do projeto para Pages

Como o site vai rodar em um subcaminho do GitHub Pages, a base precisa bater com o nome do repositório.

Use:

```env
VITE_BASE_PATH=/site_CraftTranslate/
```

Esse valor já está alinhado com o workflow atual, que usa:

```yml
VITE_BASE_PATH: /${{ github.event.repository.name }}/
```

Ou seja:

- no GitHub Pages final, a base vira `/site_CraftTranslate/`
- no desenvolvimento local, normalmente fica `VITE_BASE_PATH=/`

## 8. URLs de callback que precisam bater com o deploy

Depois do deploy, use esta URL no Discord e no Supabase:

```text
https://ithalov.github.io/site_CraftTranslate/auth/callback
```

Essa mesma URL também deve existir no arquivo de ambiente de produção, se você estiver usando um arquivo separado para deploy.

## 9. Subir novas versões do site

Sempre que você alterar o projeto, faça o ciclo abaixo:

```bash
git add .
git commit -m "Describe your change"
git push origin main
```

Depois do push:

1. o GitHub Actions vai iniciar o build
2. o workflow vai gerar a pasta `dist`
3. o GitHub Pages vai atualizar o site publicado

## 10. Sequência recomendada do deploy

Para evitar erro de rota ou callback, siga esta ordem:

1. configure o Supabase
2. configure o Discord OAuth
3. ajuste as URLs de callback
4. confirme `VITE_BASE_PATH=/site_CraftTranslate/`
5. faça o build local
6. suba para o GitHub
7. ative o Pages com `GitHub Actions`
8. teste o login em produção

## 11. O que testar depois de publicar

Depois do site estar no ar, teste estes pontos:

- a home abre corretamente
- o botão `Continue with Discord` inicia o login
- o callback em `/auth/callback` funciona
- a sessão volta corretamente para o app
- o onboarding aparece para quem ainda não escolheu idiomas
- as páginas protegidas abrem sem quebrar

## 12. Problemas comuns

### O site abriu, mas as rotas não funcionam

Confirme se `VITE_BASE_PATH` está igual ao nome do repositório.

### O login do Discord volta para erro

Confira se a URL de callback cadastrada no Discord e no Supabase é exatamente:

```text
https://ithalov.github.io/site_CraftTranslate/auth/callback
```

### O Pages não publicou

Verifique se:

- o workflow `.github/workflows/deploy.yml` existe
- a branch publicada é `main`
- o GitHub Pages está com a origem em `GitHub Actions`

### O build falhou no GitHub Actions

Abra a aba **Actions** do repositório e veja o erro do passo **Build**.

## 13. Resumo rápido

Se você quiser o caminho curto, ele é este:

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/ithalov/site_CraftTranslate.git
git push -u origin main
npm run build
```

Depois disso:

1. ative o GitHub Pages em **Settings > Pages**
2. escolha **GitHub Actions**
3. teste o site publicado
