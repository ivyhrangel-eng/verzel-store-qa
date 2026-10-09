# BUG-001 — Cobrança indevida de frete no subtotal de R$ 200,00

| Campo | Detalhe |
|---|---|
| **Critério de aceite** | CA06 — frete grátis para subtotal ≥ R$ 200,00, inclusive |
| **Módulo** | Cálculo de carrinho / regra de frete |
| **Endpoint** | `POST /api/carrinho/calcular` |
| **Severidade** | Alta — cobrança incorreta impacta o valor final da compra |
| **Resultado** | Não conforme |

## Pré-condição

Produto `P005` (Mochila Urbana 20L), preço unitário de R$ 100,00.

## Passos para reprodução

1. Realizar uma requisição `POST /api/carrinho/calcular`.
2. Enviar o corpo JSON abaixo, sem cupom.
3. Verificar os campos `subtotal`, `freteGratis`, `frete`, `valorFaltanteFreteGratis` e `total`.

```json
{
  "itens": [
    { "produtoId": "P005", "quantidade": 2 }
  ]
}
```

## Resultado esperado

- HTTP `200`.
- `subtotal`: `200`.
- `freteGratis`: `true`.
- `frete`: `0`.
- `valorFaltanteFreteGratis`: `0`.
- `total`: `200`.

## Resultado obtido

- HTTP `200`.
- `subtotal`: `200`.
- `freteGratis`: **`false`**.
- `frete`: **`19.9`**.
- `valorFaltanteFreteGratis`: `0`.
- `total`: **`219.9`**.

O frete é cobrado indevidamente no subtotal exatamente igual ao limite de gratuidade. Com o mesmo subtotal e o cupom `BEMVINDO10`, a cobrança também ocorreu: desconto de R$ 20,00, frete de R$ 19,90 e total de R$ 199,90, em vez de R$ 180,00.

## Impacto

Cobrança adicional de R$ 19,90 em compras que atendem ao valor mínimo para frete grátis.

## Evidências

- [Requisição e resposta](../../evidencias/bugs/BUG-001-01-requisicao-e-resposta.png)
- [Verificações reprovadas](../../evidencias/bugs/BUG-001-02-assercoes-falhando.png)
- [Execução consolidada no Postman Runner](../../evidencias/api/POSTMAN-RUNNER-02-nove-falhas.png)

**Registro na coleção:** pasta `01 - Frete grátis | Análise de Valor Limite`, requisição `Frete | Valor limite | R$ 200,00`. O caso adicional está na pasta de cupons.
