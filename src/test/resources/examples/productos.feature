Feature: Prueba de ServeRest

  Background:
    * def login = call read('classpath:examples/login.feature')
    * def token = login.token

  Scenario: Listar Productos
    Given url 'https://serverest.dev/produtos'
    When method get
    Then status 200
    And match response.produtos[0] contains { nome: '#notnull', preco: '#number', quantidade: '#number', _id: '#notnull' }
    * print 'Listado de productos:', response

  Scenario: Listar Producto especifico
    Given url 'https://serverest.dev/produtos'
    And param nome = 'Fresh Cotton Pants'
    When method get
    Then status 200
    * print response
    And match response.quantidade == 1
    And match response.produtos[0].nome == 'Fresh Cotton Pants'
    And match response.produtos[0].preco == 100
    And match response.produtos[0].quantidade == 95

  Scenario: Registrar Producto especifico
    Given url 'https://serverest.dev/produtos'
    And header Authorization = 'Bearer ' + token
    * def loginBody =
      """
     {
        "nome": "Logitech G913",
        "preco": 800,
        "descricao": "MouseG",
        "quantidade": 382
     }
      """
    And request loginBody
    When method post
    Then status 201
    * print response

  Scenario: Registrar Producto especifico
    Given url 'https://serverest.dev/produtos'
    #And header Authorization = 'Bearer ' + token
    * def loginBody =
      """
      {
        "nome": "Logitech G913",
        "preco": 800,
        "descricao": "MouseG",
        "quantidade": 382
      }
      """
    And request loginBody
    When method post
    Then status 401
    * print response



  Scenario: Consultar detalle de un producto existente
    Given url 'https://serverest.dev/produtos/BeeJh5lz3k6kSIzA'
    And header accept = 'application/json'
    When method get
    Then status 200
    * print 'Producto consultado:', response

  Scenario: Consultar detalle de un producto no existente
    Given url 'https://serverest.dev/produtos/BeeJh5lz3k6kSlzA1'
    And header accept = 'application/json'
    When method get
    Then status 400
    And match response ==
      """
      {
        "id": "id deve ter exatamente 16 caracteres alfanuméricos"
      }
      """
    * print 'Producto consultado:', response



