# language: pt

Funcionalidade: Regras de frete e limite de quantidade no carrinho
  Como cliente da Verzel Store
  Quero que o frete e os limites de unidades respeitem as regras da loja
  Para conhecer os valores da compra e os limites permitidos

  Cenário: CA06 - Frete grátis exatamente no limite de R$ 200,00
    Dado que o carrinho contém duas unidades do produto "P005"
    E que seu subtotal é de R$ 200,00
    Quando o sistema calcula os valores do carrinho
    Então o frete grátis deve estar ativo
    E o frete deve ser de R$ 0,00
    E o total sem cupom deve ser de R$ 200,00

  Cenário: CA07 - Cobrar frete abaixo do limite e informar o valor faltante
    Dado que o carrinho contém uma unidade de cada produto "P005", "P008" e "P004"
    E que seu subtotal é de R$ 199,90
    Quando o sistema calcula os valores do carrinho
    Então o frete grátis não deve estar ativo
    E o frete deve ser de R$ 19,90
    E o sistema deve informar que faltam R$ 0,10 para o frete grátis
    E o total deve ser de R$ 219,80

  Cenário: CA06 - Frete grátis acima do limite de R$ 200,00
    Dado que o carrinho contém uma unidade de cada produto "P005", "P001" e "P008"
    E que seu subtotal é de R$ 209,90
    Quando o sistema calcula os valores do carrinho sem cupom
    Então o frete grátis deve estar ativo
    E o frete deve ser de R$ 0,00
    E o total deve ser de R$ 209,90

  Cenário: CA08 - Frete calculado com subtotal antes do desconto
    Dado que o carrinho contém uma unidade de cada produto "P005", "P001" e "P008"
    E que seu subtotal antes do desconto é de R$ 209,90
    Quando o cliente aplica o cupom "BEMVINDO10"
    Então o desconto deve ser de R$ 20,99
    E o valor dos produtos após o desconto deve ficar abaixo de R$ 200,00
    E o frete deve permanecer gratuito
    E o total deve ser de R$ 188,91

  Cenário: CA09 - Desconto do cupom não deve reduzir o valor do frete
    Dado que o carrinho contém uma unidade de cada produto "P005" e "P008"
    E que o subtotal é de R$ 150,00
    Quando o cliente aplica o cupom "BEMVINDO10"
    Então o desconto sobre os produtos deve ser de R$ 15,00
    E o frete deve permanecer em R$ 19,90
    E o total deve ser de R$ 154,90

  Cenário: CA10 - API aceita quantidade abaixo do máximo permitido
    Dado que o carrinho contém quatro unidades do produto "P007"
    Quando a API calcula os valores do carrinho
    Então a API deve retornar o status HTTP 200
    E a quantidade informada deve ser mantida em quatro unidades

  Cenário: CA10 - API aceita exatamente cinco unidades de um produto
    Dado que o carrinho contém cinco unidades do produto "P007"
    Quando a API calcula os valores do carrinho
    Então a API deve retornar o status HTTP 200
    E a quantidade informada deve ser mantida em cinco unidades

  Cenário: CA10 - Interface bloqueia inclusão da sexta unidade
    Dado que o carrinho contém cinco unidades da "Mochila Urbana 20L"
    Quando o cliente consulta o controle de aumento de quantidade
    Então o botão de aumentar deve estar desabilitado
    E a quantidade deve permanecer em cinco unidades
    E a mensagem deve ser "Limite de 5 unidades por produto."

  Cenário: CA10 - API de cálculo rejeita sexta unidade
    Dado que a solicitação de cálculo contém seis unidades do produto "P007"
    Quando a API recebe a solicitação de cálculo do carrinho
    Então a API deve retornar o status HTTP 422
    E o código de erro deve ser "QUANTIDADE_MAXIMA_EXCEDIDA"

  Cenário: CA10 - API de pedidos rejeita sexta unidade
    Dado que a solicitação de pedido possui dados válidos da cliente
    E que o pedido contém seis unidades do produto "P007"
    Quando a API recebe a solicitação de criação do pedido
    Então a API deve retornar o status HTTP 422
    E o código de erro deve ser "QUANTIDADE_MAXIMA_EXCEDIDA"
