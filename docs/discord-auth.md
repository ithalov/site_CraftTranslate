# Configuração do Discord OAuth

Este projeto usa Supabase Auth com Discord como provedor.

## Regra importante

O `client secret` do Discord nunca deve ser colocado no frontend.
Configure o Discord dentro do painel do Supabase.

## O que criar no Discord

1. Abra o [Discord Developer Portal](https://discord.com/developers/applications).
2. Crie uma nova aplicação para `ChatTranslate Web`.
3. Adicione ícone, nome e descrição.
4. Acesse **OAuth2**.
5. Adicione as URLs de redirect para cada ambiente que você vai usar:
   - `http://localhost:5173/auth/callback`
   - `https://ithalov.github.io/site_CraftTranslate/auth/callback`
6. Salve as alterações.

## Escopos OAuth recomendados

Use o mínimo necessário para login:

- `identify`
- `email` se você quiser o endereço de e-mail no perfil

## O que configurar no Supabase

1. Abra seu projeto no Supabase.
2. Acesse **Authentication** > **Providers**.
3. Habilite **Discord**.
4. Cole o `Client ID` do Discord.
5. Cole o `Client Secret` do Discord.
6. Salve as configurações do provedor.

## Fluxo de redirect usado pelo app

- O login começa pelo botão `Continue with Discord`.
- O Supabase redireciona de volta para `/auth/callback`.
- A rota de callback troca o código OAuth por uma sessão.
- Após o login, o app cria ou atualiza o perfil e envia o usuário para o onboarding quando necessário.

## Solução de problemas

- Se o login voltar para a página de login em loop, confira a URL de redirect no Discord e no Supabase.
- Se o callback falhar no GitHub Pages, confirme se o caminho publicado bate com `VITE_BASE_PATH`.
- Se o Discord abrir mas nenhuma sessão aparecer, verifique se o provedor Discord está habilitado no Supabase.
