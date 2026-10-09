# language: pt

Funcionalidade: Precisão dos valores monetários do carrinho
  Como cliente da Verzel Store
  Quero que os valores do carrinho sejam calculados com centavos corretamente
  Para conferir o desconto, o frete e o total apresentado

  Cenário: CA11 - Exibir subtotal, desconto, frete e total com precisão de centavos
    Dado que o carrinho contém uma unidade de cada produto "P001", "P004" e "P006"
    E que os preços unitários são R$ 59,90, R$ 49,90 e R$ 29,90
    Quando o cliente aplica o cupom "BEMVINDO10" e a API calcula o carrinho
    Então a API deve retornar o status HTTP 200
    E o subtotal deve ser de R$ 139,70
    E o desconto deve ser de R$ 13,97
    E o frete deve ser de R$ 19,90
    E o total deve ser de R$ 145,63

  # Este caso valida valores em centavos. Com os produtos e o cupom disponíveis,
  
