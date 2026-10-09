# language: pt

Funcionalidade: Normalização do código de cupom
  Como cliente da Verzel Store
  Quero que variações válidas do código sejam reconhecidas
  Para receber o desconto sem depender de letras maiúsculas ou espaços externos

  Esquema do Cenário: CA02 - Reconhecer variações válidas de BEMVINDO10
    Dado que a "Mochila Urbana 20L" de R$ 100,00 está no carrinho
    Quando o cliente informa o cupom <codigo_informado>
    Então o cupom deve ser reconhecido como "BEMVINDO10"
    E o desconto deve ser de R$ 10,00
    E o total deve ser de R$ 109,90

    Exemplos:
      | codigo_informado |
      | "BEMVINDO10"     |
      | " bemvindo10"    |
      | "bemvindo10 "    |
      | "BemVindo10"     |

  Cenário: CA02 - Rejeitar código com espaço interno
    Dado que a "Mochila Urbana 20L" de R$ 100,00 está no carrinho
    Quando o cliente informa o cupom "Bem Vindo10"
    Então o cupom não deve ser aplicado
    E a mensagem deve ser "Cupom inválido."
    E o desconto deve ser de R$ 0,00
    E o total deve ser de R$ 119,90
