# ChatTranslate Web

Base do ChatTranslate Web com React, TypeScript, Vite, Tailwind CSS, Supabase e GitHub Pages.

## Documentação

- [Índice da documentação](docs/README.md)
- [Variáveis de ambiente](docs/environment-variables.md)
- [Configuração do Discord OAuth](docs/discord-auth.md)
- [Configuração do Supabase](docs/supabase-setup.md)
- [Desenvolvimento local](docs/local-development.md)
- [Deploy no GitHub Pages](docs/github-pages.md)

## O que esta fundação já cobre

- Frontend com React + TypeScript + Vite
- Estilização com Tailwind CSS
- Estrutura limpa para `pages`, `components`, `layouts`, `services`, `hooks`, `types`, `utils` e `integrations`
- Cliente Supabase configurado apenas com variáveis públicas do frontend
- Discord OAuth preparado sem expor o `client secret`
- Migrations SQL versionadas em `supabase/migrations`
- Build preparado para GitHub Pages

## Estrutura de pastas

```text
src/
  components/
  hooks/
  integrations/
  layouts/
  pages/
  services/
  types/
  utils/
  App.tsx
  main.tsx
  styles/
docs/
  discord-auth.md
  environment-variables.md
  github-pages.md
  local-development.md
  supabase-setup.md
supabase/
  migrations/
```
