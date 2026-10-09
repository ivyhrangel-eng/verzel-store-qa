# Relatório de execução dos testes — Verzel Store

**Execução:** 08 de outubro de 2026  
**Responsável:** Ivyh Rangel  
**Ambiente:** https://verzel-store.qa-test-verzel-store.workers.dev/

## Resumo

| Modalidade | Execuções | Resultado |
|---|---:|---|
| Postman — API | 24 requisições | 150 verificações: **141 aprovadas, 9 reprovadas** |
| Playwright — Chromium | 5 testes | **5 aprovados** |
| Manual / exploratório | Fluxos de carrinho, cupons e limite de quantidade; requisições de limite na API | Conforme e não conforme, conforme cenários abaixo |

**Postman Runner:** 1 iteração; **0 erros de execução**. As nove verificações reprovadas correspondem a quatro requisições associadas aos BUG-001 e BUG-002.

[Resumo do Runner](../evidencias/api/POSTMAN-RUNNER-01-resumo-geral.png) · [Verificações reprovadas](../evidencias/api/POSTMAN-RUNNER-02-nove-falhas.png)

## API — Execução por cenário

A numeração abaixo acompanha a ordem das requisições na coleção Postman. A coluna **V/F** informa a quantidade de verificações aprovadas/reprovadas em cada cenário.

| ID | Regra | Cenário | Resultado observado | V/F | Situação |
|---|---|---|---|---:|---|
| API-01 | CA07 | Frete — subtotal R$ 199,90 | Frete R$ 19,90; falta R$ 0,10 | 5/0 | Conforme |
| API-02 | CA06 | Frete — subtotal R$ 200,00 | Frete R$ 19,90, quando deveria ser gratuito; BUG-001 | 3/2 | **Não conforme** |
| API-03 | CA06 | Frete — subtotal R$ 209,90 | Frete grátis; total R$ 209,90 | 5/0 | Conforme |
| API-04 | CA08 | Subtotal R$ 209,90 + BEMVINDO10 | Desconto R$ 20,99; frete R$ 0,00; total R$ 188,91 | 6/0 | Conforme |
| API-05 | CA01 | BEMVINDO10 — subtotal R$ 559,70 | Desconto R$ 55,97; total R$ 503,73 | 8/0 | Conforme |
| API-06 | CA01/CA09 | BEMVINDO10 — subtotal R$ 150,00 | Desconto R$ 15,00; frete R$ 19,90; total R$ 154,90 | 8/0 | Conforme |
| API-07 | CA01/CA06 | BEMVINDO10 — subtotal R$ 200,00 | Desconto R$ 20,00; frete indevido R$ 19,90; total R$ 199,90; BUG-001 | 5/3 | **Não conforme** |
| API-08 | CA02 | Cupom BEMVINDO10 | Código reconhecido; desconto R$ 10,00 | 8/0 | Conforme |
| API-09 | CA02 | Cupom com espaço inicial | Código normalizado e aplicado | 8/0 | Conforme |
| API-10 | CA02 | Cupom com espaço final | Código normalizado e aplicado | 8/0 | Conforme |
| API-11 | CA02 | Cupom com maiúsculas/minúsculas | Código normalizado e aplicado | 8/0 | Conforme |
| API-12 | CA02/CA03 | Cupom com espaço interno | Cupom inválido; desconto R$ 0,00 | 8/0 | Conforme |
| API-13 | CA04 | Cupom expirado VERAO2026 — cálculo | Cupom rejeitado; mensagem de expiração; desconto R$ 0,00 | 9/0 | Conforme |
| API-14 | CA03 | Cupom inválido VERAO15 — cálculo | Cupom rejeitado; mensagem de invalidade; desconto R$ 0,00 | 9/0 | Conforme |
| API-15 | Pedidos/CA01 | Criação de pedido com cupom válido | HTTP 201; pedido VZ-######; total R$ 109,90 | 15/0 | Conforme |
| API-16 | Pedidos/CA04 | Pedido com cupom expirado | HTTP 422; CUPOM_EXPIRADO | 4/0 | Conforme |
| API-17 | Pedidos/CA03 | Pedido com cupom inválido | HTTP 422; CUPOM_INVALIDO | 4/0 | Conforme |
| API-18 | Produtos | Consultar produto inexistente P999 | HTTP 404; PRODUTO_NAO_ENCONTRADO | 3/0 | Conforme |
| API-19 | Produtos | Consultar produto P004 | HTTP 200; Boné Aba Curva; R$ 49,90 | 6/0 | Conforme |
| API-20 | CA10 | Calcular carrinho com 5 unidades de P007 | HTTP 200; quantidade 5 | 3/0 | Conforme |
| API-21 | CA10 | Calcular carrinho com 4 unidades de P007 | HTTP 200; quantidade 4 | 3/0 | Conforme |
| API-22 | CA10 | Calcular carrinho com 6 unidades de P007 | HTTP 200, quando esperado 422; BUG-002 | 0/2 | **Não conforme** |
| API-23 | CA10 | Criar pedido com 6 unidades de P007 | HTTP 201, quando esperado 422; BUG-002 | 0/2 | **Não conforme** |
| API-24 | CA11 | Precisão monetária com três produtos | Subtotal R$ 139,70; desconto R$ 13,97; frete R$ 19,90; total R$ 145,63 | 5/0 | Conforme |

**Casos não conformes:** API-02 e API-07 — [BUG-001](bugs/BUG-001-frete-200.md); API-22 e API-23 — [BUG-002](bugs/BUG-002-limite-api.md). Nos dois casos, as verificações foram mantidas conforme a especificação.

## Interface — Execução manual

| ID | Cenário | Resultado observado | Situação | Evidência |
|---|---|---|---|---|
| UI-01 | Aplicar BEMVINDO10 à Mochila Urbana 20L | Subtotal R$ 100,00; desconto R$ 10,00; frete R$ 19,90; total R$ 109,90 | Conforme | [Cupom aplicado](../evidencias/interface/CA01-CA05-cupom-aplicado.png) |
| UI-02 | Remover cupom aplicado | Desconto R$ 0,00; total R$ 119,90 | Conforme | [Cupom removido](../evidencias/interface/CA05-cupom-removido.png) |
| UI-03 | Limite de cinco unidades — Mochila Urbana 20L | Quantidade limitada a cinco; botão de aumento desabilitado; mensagem de limite | Conforme | [Limite na interface](../evidencias/interface/CA10-bloqueio-cinco-unidades.png) |

## Investigação exploratória

| ID | Cenário investigado | Resultado | Referência |
|---|---|---|---|
| EXP-01 | Análise de valor-limite do frete: R$ 199,90; R$ 200,00; R$ 209,90 | Cobrança indevida no valor-limite exato | [BUG-001](bugs/BUG-001-frete-200.md) |
| EXP-02 | Envio de quantidade superior a cinco diretamente pelas APIs | Cálculo e criação de pedidos aceitaram seis unidades | [BUG-002](bugs/BUG-002-limite-api.md) |

## Playwright — Execução automatizada

**Navegador:** Chromium  
**Resultado consolidado:** 5 testes aprovados em 7,4 s.

| ID | Arquivo | Verificação | Resultado |
|---|---|---|---|
| PW-01 | `cupom-valido.spec.js` | CA01 — cupom válido: desconto e total | Aprovado |
| PW-02 | `remover-cupom.spec.js` | Remoção e recálculo de valores | Aprovado |
| PW-03 | `limite-quantidade.spec.js` | CA10 — limite de unidades na interface | Aprovado |
| PW-04 | `cupom-invalido.spec.js` | CA03 — cupom inexistente | Aprovado |
| PW-05 | `cupom-expirado.spec.js` | CA04 — cupom expirado | Aprovado |

[Registro da execução Playwright](../evidencias/automacao/PLAYWRIGHT-cinco-testes-aprovados.png)

## Escopo dos critérios

O cenário de remoção cobre a retirada do cupom e o recálculo do pedido. A regra de impedir a substituição direta de um cupom ativo (CA05) não foi incluída nos cinco testes Playwright. A CA11 verificou os resultados monetários com centavos para os dados utilizados.
