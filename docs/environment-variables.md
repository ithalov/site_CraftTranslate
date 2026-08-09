# Variáveis de Ambiente

Este projeto mantém todos os segredos privados fora do bundle do frontend.

## Variáveis públicas usadas pelo app

Coloque estas variáveis em `.env.local` para desenvolvimento local:

```env
VITE_APP_NAME=ChatTranslate Web
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
VITE_DISCORD_CLIENT_ID=your_discord_client_id
VITE_DISCORD_REDIRECT_URI=http://localhost:5173/auth/callback
VITE_BASE_PATH=/
```

## Nunca exponha no frontend

Não coloque estes valores em `src`, `public` ou em qualquer variável `VITE_*`:

- `SUPABASE_SERVICE_ROLE_KEY`
- `DISCORD_CLIENT_SECRET`
- senhas do banco
- tokens privados de API
- refresh tokens

## Observações

- `VITE_SUPABASE_ANON_KEY` is safe to use in the browser.
- O `client secret` do Discord deve ficar nas configurações do provedor no Supabase, nunca no app React.
- Se o projeto for publicado no GitHub Pages em um subcaminho, ajuste `VITE_BASE_PATH` conforme necessário.
