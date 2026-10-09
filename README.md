# Verzel Store | Teste Técnico de QA Júnior

**Responsável:** Ivyh Rangel  
**Aplicação:** https://verzel-store.qa-test-verzel-store.workers.dev/  
**Documentação da aplicação:** https://verzel-store.qa-test-verzel-store.workers.dev/documentacao

## Escopo

Avaliação das regras de cupons, frete, limite de quantidade por produto, confirmação de pedidos e consulta de produtos, por meio de testes manuais e exploratórios, testes de API no Postman e automação da interface com Playwright.

## Resultados da execução

| Modalidade | Execução | Resultado |
|---|---|---|
| API — Postman | 24 requisições; 150 verificações | **141 aprovadas; 9 reprovadas; 0 erros de execução** |
| Automação — Playwright/Chromium | 5 cenários executados em conjunto | **5 aprovados** |
| Testes manuais e exploratórios | Cupons, remoção e limite de quantidade na interface; exploração de regras da API | Resultados e capturas documentados |

As nove verificações reprovadas referem-se a **dois defeitos distintos**: BUG-001 (frete no subtotal de R$ 200,00) e BUG-002 (limite de quantidade nas APIs).

[Resultados detalhados](documentacao/resultados-execucao.md) · [Evidências](documentacao/evidencias-execucao.md)

## Executar os testes automatizados

**Pré-requisitos:** Node.js, npm e acesso à aplicação de testes.

```bash
npm ci
npx playwright install chromium
npx playwright test --project=chromium
```

Para acompanhar a execução com navegador visível:

```bash
npx playwright test --project=chromium --headed
```

Para visualizar o relatório HTML gerado localmente:

```bash
npx playwright show-report
```

Os testes estão implementados em JavaScript nos arquivos:

| Arquivo | Comportamento |
|---|---|
| `tests/cupom-valido.spec.js` | Aplicação de BEMVINDO10 e cálculo de desconto/total (CA01) |
| `tests/remover-cupom.spec.js` | Remoção do cupom e recálculo do total |
| `tests/cupom-invalido.spec.js` | Rejeição de cupom inexistente (CA03) |
| `tests/cupom-expirado.spec.js` | Rejeição de cupom expirado (CA04) |
| `tests/limite-quantidade.spec.js` | Limite de cinco unidades na interface (CA10) |

## Executar os testes de API

1. Importar no Postman a coleção [`postman/Verzel-Store.postman_collection.json`](postman/Verzel-Store.postman_collection.json).
2. Executar as requisições individualmente ou com o **Collection Runner**, selecionando todas as 24 requisições.
3. Consultar os resultados e os defeitos identificados nos documentos abaixo.

Os testes ligados aos defeitos mantêm as expectativas definidas pela especificação. Enquanto os comportamentos observados persistirem, essas verificações resultarão em falha.

## Documentação e artefatos

| Artefato | Localização |
|---|---|
| Cenários de teste em Gherkin | [`documentacao/cenarios/`](documentacao/cenarios/) |
| Matriz dos 24 cenários de API, execução manual e Playwright | [`documentacao/resultados-execucao.md`](documentacao/resultados-execucao.md) |
| Evidências de execução | [`documentacao/evidencias-execucao.md`](documentacao/evidencias-execucao.md) |
| BUG-001 — Cobrança indevida de frete | [`documentacao/bugs/BUG-001-frete-200.md`](documentacao/bugs/BUG-001-frete-200.md) |
| BUG-002 — Quantidade acima do limite na API | [`documentacao/bugs/BUG-002-limite-api.md`](documentacao/bugs/BUG-002-limite-api.md) |
| Coleção Postman | [`postman/Verzel-Store.postman_collection.json`](postman/Verzel-Store.postman_collection.json) |
| Scripts de automação | [`tests/`](tests/) |


**Observação de escopo:** os arquivos `.feature` documentam os comportamentos esperados; a automação executável está nos scripts Playwright. A CA05 foi automatizada no fluxo de remoção e recálculo. A CA11 verificou resultados financeiros em centavos nos dados disponíveis.
