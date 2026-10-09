# language: pt

Funcionalidade: Cupons de desconto no carrinho da Verzel Store
  Como cliente da Verzel Store
  Quero aplicar e remover cupons no carrinho
  Para acompanhar o desconto e o valor final do pedido

  Cenário: CA01 - Aplicar BEMVINDO10 em compra de R$ 100,00
    Dado que a "Mochila Urbana 20L" de R$ 100,00 está no carrinho
    Quando o cliente aplica o cupom "BEMVINDO10"
    Então o cupom deve ser aplicado com sucesso
    E o subtotal deve ser de R$ 100,00
    E o desconto deve ser de R$ 10,00
    E o frete deve ser de R$ 19,90
    E o total deve ser de R$ 109,90

  Cenário: CA01 - Aplicar 10% de desconto em subtotal de R$ 150,00
    Dado que o carrinho contém os produtos "P005" e "P008", com uma unidade de cada
    Quando o cliente aplica o cupom "BEMVINDO10"
    Então o subtotal deve ser de R$ 150,00
    E o desconto deve ser de R$ 15,00
    E o frete deve ser de R$ 19,90
    E o total deve ser de R$ 154,90

  Cenário: CA01 - Aplicar 10% de desconto em subtotal de R$ 559,70
    Dado que o carrinho contém uma unidade de cada produto "P007", "P003" e "P002"
    Quando o cliente aplica o cupom "BEMVINDO10"
    Então o subtotal deve ser de R$ 559,70
    E o desconto deve ser de R$ 55,97
    E o frete deve ser de R$ 0,00
    E o total deve ser de R$ 503,73

  Cenário: CA01 e CA06 - Cupom válido em subtotal exatamente de R$ 200,00
    Dado que o carrinho contém duas unidades do produto "P005"
    E que seu subtotal é de R$ 200,00
    Quando o cliente aplica o cupom "BEMVINDO10"
    Então o desconto deve ser de R$ 20,00
    E o frete deve ser de R$ 0,00
    E o total deve ser de R$ 180,00

  Cenário: CA03 - Rejeitar cupom inexistente no cálculo do carrinho
    Dado que o carrinho contém uma unidade do produto "P002" de R$ 139,90
    Quando o cliente informa o cupom "VERAO15" para calcular o carrinho
    Então o cupom não deve ser aplicado
    E a mensagem deve ser "Cupom inválido."
    E o desconto deve ser de R$ 0,00
    E o total deve ser de R$ 159,80

  Cenário: CA04 - Rejeitar cupom expirado no cálculo do carrinho
    Dado que o carrinho contém uma unidade do produto "P003" de R$ 189,90
    Quando o cliente informa o cupom "VERAO2026" para calcular o carrinho
    Então o cupom não deve ser aplicado
    E a mensagem deve ser "Cupom expirado."
    E o desconto deve ser de R$ 0,00
    E o total deve ser de R$ 209,80

  Cenário: CA05 - Remover cupom aplicado e recalcular total
    Dado que a "Mochila Urbana 20L" de R$ 100,00 está no carrinho
    E que o cupom "BEMVINDO10" foi aplicado com desconto de R$ 10,00
    E que o total com cupom é de R$ 109,90
    Quando o cliente remove o cupom
    Então o desconto deve voltar a R$ 0,00
    E o total deve ser de R$ 119,90

 