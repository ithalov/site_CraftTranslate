# Desenvolvimento Local

## Requisitos

- Node.js instalado
- npm instalado
- Um projeto Supabase configurado
- Um app Discord OAuth configurado

## Passos de configuração

1. Instale as dependências:

```bash
npm install
```

2. Crie um arquivo de ambiente local:

```bash
copy .env.example .env.local
```

3. Preencha os valores em `.env.local`.
4. Rode o app:

```bash
npm run dev
```

5. Abra a URL local mostrada pelo Vite.

## URL de callback para testes locais

Use esta URL no Discord e no Supabase durante os testes locais:

```text
http://localhost:5173/auth/callback
```

## O que verificar

- O login com Discord abre corretamente.
- A rota de callback cria uma sessão.
- Um perfil é criado automaticamente no primeiro login.
- A tela de onboarding aparece quando nenhum idioma ainda foi salvo.
