# Fluxo Official

O ChatTranslate Web usa um pipeline claro para separar o que foi traduzido, o que foi revisado e o que ja virou oficial.

## Pipeline de estados

- `DRAFT`
- `PENDING`
- `REVIEWING`
- `APPROVED`
- `OFFICIAL`
- `NEEDS_CHANGES`
- `REJECTED`
- `REPORTED`

## Como o fluxo funciona

- `DRAFT`: rascunho ainda nao enviado.
- `PENDING`: traducao enviada e aguardando revisao.
- `REVIEWING`: a sugestao entrou na fila e recebeu revisao.
- `APPROVED`: a revisao passou nas regras, mas ainda nao atingiu o fechamento final.
- `OFFICIAL`: a traducao passou por todas as regras exigidas e foi consolidada como final.
- `NEEDS_CHANGES`: o revisor pediu ajustes.
- `REJECTED`: a sugestao foi recusada.
- `REPORTED`: a sugestao gerou report e precisa de atencao moderadora.

## Regra para virar Official

Uma traducao so pode virar `OFFICIAL` quando:

- passar pela revisao valida
- nao houver auto-verificacao
- a confianca da sugestao indicar que o fechamento e seguro
- os sinais de qualidade forem suficientes para consolidar a versao final

## Separacao nas metricas

As metricas publicas separam claramente:

- `Translated`
  - existe pelo menos uma sugestao nao-draft
- `Reviewed`
  - existe pelo menos uma revisao humana valida
- `Official`
  - existe sugestao consolidada como `official`

## Arquivos principais

- `supabase/migrations/202608100005_official_pipeline.sql`
- `src/pages/ReviewPage.tsx`
- `src/integrations/supabase/database.types.ts`

