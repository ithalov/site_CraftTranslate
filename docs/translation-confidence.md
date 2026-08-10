# Translation Confidence

O ChatTranslate Web usa um sistema deterministico de **Translation Confidence** para indicar o nivel de confianca de uma sugestao de traducao.

Esse sistema nao usa IA para "adivinhar" qualidade. A pontuacao vem apenas de sinais objetivos do proprio fluxo de revisao:

- quantidade de revisoes validas
- quantidade de revisores distintos
- concordancia entre os revisores
- reputacao dos revisores
- quantidade de reports em aberto
- status final da sugestao

## Niveis

- `LOW`
- `MEDIUM`
- `HIGH`
- `VERIFIED`

## Regra de calculo

A funcao SQL `public.translation_confidence_for_suggestion(uuid)` retorna os sinais usados para o calculo e monta a pontuacao final.

Base da formula:

- volume de revisoes validas: ate 45 pontos
- concordancia: `agreement_rate * 0.25`
- confianca dos revisores: `reviewer_trust_score * 0.18`
- status final:
  - `approved`: bonus
  - `rejected`: penalidade
  - `archived`: penalidade menor
- reports abertos: penalidade proporcional

Regras de corte:

- `VERIFIED`
  - sugestao aprovada
  - pelo menos 2 revisoes validas
  - pelo menos 2 revisores distintos
  - pelo menos 2 aprovacoes
  - nenhum report em aberto
  - concordancia maior ou igual a 80%
  - confianca dos revisores maior ou igual a 60%
  - pontuacao final maior ou igual a 90
- `HIGH`: pontuacao final maior ou igual a 70
- `MEDIUM`: pontuacao final maior ou igual a 40
- `LOW`: abaixo disso

## Regra anti auto-verificacao

Um usuario nao pode verificar a propria traducao.

Isso e garantido em tres camadas:

1. a fila de revisao nao entrega sugestoes do proprio autor
2. a funcao `review_workspace_submit` bloqueia qualquer tentativa de auto-revisao
3. a policy de insert em `public.reviews` tambem exige que o revisor seja diferente do autor

## Onde isso foi implementado

- `supabase/migrations/202608100004_translation_confidence.sql`
- `src/services/reviewWorkspace.ts`
- `src/pages/ReviewPage.tsx`

