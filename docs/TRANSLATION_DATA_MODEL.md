# Modelo de dados de traducao

O Supabase/PostgreSQL e a unica fonte oficial de dados do ChatTranslate. React state controla apenas a interface e `localStorage` pode guardar somente preferencias ou rascunhos que ainda nao foram enviados.

## translation_keys

Representa somente a string original em ingles. A chave estavel `key_name` e o identificador usado pelo futuro mod, nunca o texto original.

Campos importantes:

- `key_name`: identificador unico, por exemplo `party-full`.
- `original_text`: texto fonte em ingles.
- `source_language_id`: idioma original.
- `category`, `subcategory` e `context`: contexto de uso no mod.
- `protected_variables` e `protected_terms`: tokens que precisam ser preservados.
- `source_version`: incrementada automaticamente quando `original_text` muda.

## translation_suggestions

Cada envio cria uma sugestao persistida, ligada a uma `translation_key`, idioma de destino, autor e `source_version` da origem usada no envio.

Estados: `pending`, `reviewing`, `needs_changes`, `approved`, `official`, `rejected`, `reported` e `archived`.

Uma string pode ter estados independentes por idioma. Exemplo: a mesma chave pode estar `official` em `pt-BR` e `pending` em `es-ES`.

## Progresso centralizado

As views abaixo evitam calculos diferentes em cada pagina:

- `translation_progress`: estado por `translation_key_id + target_language_id + source_version`.
- `language_translation_stats`: totais e percentuais por idioma.
- `category_translation_stats`: totais e percentuais por categoria e idioma.

As paginas de status, home, idiomas e dashboard devem usar essas estatisticas por meio dos services existentes.

## Traducoes oficiais e exportacao

`official_translations` devolve somente a traducao final da versao atual da string. Ela foi preparada para produzir um pacote futuro como:

```json
{
  "language": "pt-BR",
  "version": "2026.08.1",
  "translations": {
    "party-full": "Seu grupo esta cheio."
  }
}
```

Ha um indice parcial que impede mais de uma traducao `official` para a mesma combinacao de chave, idioma e versao de origem.

## Auditoria

A funcao `data_integrity_check()` retorna avisos e erros sobre chaves sem nome, sugestoes sem autor, textos vazios e oficiais duplicadas. Ela nao altera nenhum dado.
