# language: pt

Funcionalidade: Confirmação de pedidos e validação de cupons
  Como cliente da Verzel Store
  Quero finalizar pedidos com os dados obrigatórios válidos
  Para registrar uma compra ou receber uma rejeição apropriada

  Cenário: API-PED-01 - Finalizar pedido com cupom válido
    Dado que a cliente "Maria Silva" informa email e CEP válidos
    E que o pedido contém uma unidade do produto "P005"
    E que informa o cupom "BEMVINDO10"
    Quando a cliente envia a solicitação de criação do pedido
    Então a API deve retornar o status HTTP 201
    E o pedido deve ser criado com sucesso
    E o número do pedido deve começar com "VZ-" seguido de seis dígitos
    E o desconto deve ser de R$ 10,00
    E o total do pedido deve ser de R$ 109,90

  Cenário: API-PED-02 - Rejeitar pedido com cupom expirado
    Dado que a cliente "Maria Silva" informa email e CEP válidos
    E que o pedido contém uma unidade do produto "P005"
    E que informa o cupom "VERAO2026"
    Quando a cliente envia a solicitação de criação do pedido
    Então a API deve retornar o status HTTP 422
    E o pedido não deve ser criado
    E o erro deve identificar o campo "cupom"
    E o código de erro deve ser "CUPOM_EXPIRADO"
    E a mensagem deve ser "Cupom expirado."

  Cenário: API-PED-03 - Rejeitar pedido com cupom inexistente
    Dado que a cliente "Maria Silva" informa email e CEP válidos
    E que o pedido contém uma unidade do produto "P005"
    E que informa o cupom "VERAO15"
    Quando a cliente envia a solicitação de criação do pedido
    Então a API deve retornar o status HTTP 422
    E o pedido não deve ser criado
    E o erro deve identificar o campo "cupom"
    E o código de erro deve ser "CUPOM_INVALIDO"
    E a mensagem deve ser "Cupom inválido."
