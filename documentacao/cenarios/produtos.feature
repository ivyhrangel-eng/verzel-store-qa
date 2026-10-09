# language: pt

Funcionalidade: Consulta de produtos pela API
  Como consumidor da API da Verzel Store
  Quero consultar produtos pelo identificador
  Para obter os dados do produto ou uma mensagem de erro apropriada

  Cenário: API-PROD-00 - Listar os produtos cadastrados
    Dado que o catálogo da Verzel Store está disponível
    Quando a API recebe uma requisição GET para "/api/produtos"
    Então a API deve retornar o status HTTP 200
    E a resposta deve conter uma lista de produtos

  Cenário: API-PROD-01 - Consultar produto cadastrado P004
    Dado que o produto "P004" está cadastrado
    Quando a API recebe uma requisição GET para "/api/produtos/P004"
    Então a API deve retornar o status HTTP 200
    E o identificador retornado deve ser "P004"
    E o nome retornado deve ser "Boné Aba Curva"
    E a descrição deve ser "Ajuste traseiro com fivela metálica."
    E a categoria deve ser "Acessórios"
    E o preço deve ser de R$ 49,90

  Cenário: API-PROD-02 - Consultar produto inexistente P999
    Dado que o produto "P999" não está cadastrado
    Quando a API recebe uma requisição GET para "/api/produtos/P999"
    Então a API deve retornar o status HTTP 404
    E o código de erro deve ser "PRODUTO_NAO_ENCONTRADO"
    E a mensagem deve ser "Produto P999 não encontrado."
