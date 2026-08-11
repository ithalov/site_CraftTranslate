# Ciclo de vida da traducao

```text
Untranslated
  -> Submitted / pending
  -> Reviewing
  -> Approved
  -> Official
```

Possiveis caminhos alternativos:

- `pending` ou `reviewing` -> `needs_changes`: o autor deve enviar uma melhoria.
- `pending` ou `reviewing` -> `rejected`: a sugestao continua no historico, mas nao conta como progresso concluido.
- Qualquer estado -> `reported`: requer verificacao de moderacao.
- Uma nova versao do texto original aumenta `source_version`; as sugestoes antigas ficam preservadas no historico e deixam de ser usadas pela exportacao atual.

## Envio seguro

1. A interface valida texto, placeholders e termos protegidos.
2. O banco confirma permissao, idioma de destino, versao original e duplicidade.
3. O Supabase grava a sugestao e os eventos de XP/reputacao na mesma operacao.
4. Somente apos a resposta de sucesso a interface atualiza a fila e recarrega estatisticas.

Se o Supabase falhar, a string continua aberta e o texto digitado permanece no formulario.

## Verificacao manual

Depois de aplicar a migration, teste:

1. Envie uma traducao e confirme que ela aparece em `Perfil > My contributions`.
2. Atualize a pagina; a mesma string nao deve voltar para a fila como pendente para voce.
3. Abra `/status`; o total de traducoes deve aumentar.
4. Confirme que outro idioma continua independente.
5. Execute `select * from public.data_integrity_check();` no SQL Editor para verificar a consistencia.
