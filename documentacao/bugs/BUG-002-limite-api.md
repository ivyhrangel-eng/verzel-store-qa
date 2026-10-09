# BUG-002 — APIs aceitam quantidade superior ao máximo permitido

| Campo | Detalhe |
|---|---|
| **Critério de aceite** | CA10 — máximo de cinco unidades de um mesmo produto por pedido, na interface e na API |
| **Módulo** | Validação da quantidade no carrinho e no pedido |
| **Endpoints** | `POST /api/carrinho/calcular` e `POST /api/pedidos` |
| **Severidade** | Alta — validação obrigatória não aplicada pelas APIs |
| **Resultado** | Não conforme |

## Pré-condições

Produto `P007` (Jaqueta Corta-Vento) cadastrado. Envio de quantidade **6**, superior ao máximo de cinco unidades por produto.

## Reprodução A — Cálculo de carrinho

1. Enviar `POST /api/carrinho/calcular`.
2. Utilizar o corpo abaixo.
3. Verificar status HTTP, quantidade retornada e objeto de erro.

```json
{
  "itens": [
    { "produtoId": "P007", "quantidade": 6 }
  ]
}
```

**Esperado:** HTTP `422`, com `erro.codigo` igual a `QUANTIDADE_MAXIMA_EXCEDIDA`.  
**Obtido:** HTTP **`200`**, item com quantidade **6** e total de **R$ 1.379,40**. Sem objeto de erro.

## Reprodução B — Criação de pedido

1. Enviar `POST /api/pedidos` com dados válidos da cliente.
2. Utilizar o corpo abaixo.
3. Verificar status HTTP, quantidade registrada e objeto de erro.

```json
{
  "cliente": {
    "nome": "Maria Silva",
    "email": "maria@exemplo.com",
    "cep": "01310-100"
  },
  "itens": [
    { "produtoId": "P007", "quantidade": 6 }
  ]
}
```

**Esperado:** HTTP `422`, com `erro.codigo` igual a `QUANTIDADE_MAXIMA_EXCEDIDA`.  
**Obtido:** HTTP **`201 Created`**, com pedido contendo **6 unidades** de `P007`.

## Impacto

O limite de quantidade pode ser contornado por chamadas diretas à API, inclusive na criação do pedido. Na interface, o controle de quantidade foi desabilitado ao alcançar cinco unidades, conforme [evidência do carrinho](../../evidencias/interface/CA10-bloqueio-cinco-unidades.png).

## Evidências

| Fluxo | Requisição/resposta | Verificações reprovadas |
|---|---|---|
| Cálculo do carrinho | [Captura](../../evidencias/bugs/BUG-002-01-calculo-requisicao-e-resposta.png) | [Captura](../../evidencias/bugs/BUG-002-02-calculo-assercoes-falhando.png) |
| Confirmação do pedido | [Captura](../../evidencias/bugs/BUG-002-03-pedido-requisicao-e-resposta.png) | [Captura](../../evidencias/bugs/BUG-002-04-pedido-assercoes-falhando.png) |

[Execução consolidada no Postman Runner](../../evidencias/api/POSTMAN-RUNNER-02-nove-falhas.png)

**Registro na coleção:** pasta `07 - Limite de quantidade | CA10`, cenários com seis unidades nos endpoints de cálculo e pedido.
