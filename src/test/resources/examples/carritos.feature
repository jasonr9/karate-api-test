Feature: Prueba de Carritos

  Scenario: Listar todos los carritos
    Given url karate.config.baseUrl + '/carrinhos'
    And header accept = 'application/json'
    When method get
    Then status 200
    And match response.quantidade == 1
    And match response.carrinhos[0].quantidadeTotal == 3
    And match response.carrinhos[0].precoTotal == 6180
    * print 'Carrito obtenido:', response


  Scenario: Consultar carrito específico
    Given url karate.config.baseUrl + '/carrinhos/qbMqntef4iTOwWfg'
    And header accept = 'application/json'
    When method get
    Then status 200
    And match response.precoTotal == 6180
    And match response.quantidadeTotal == 3
    * print 'Carrito específico:', response


  Scenario: Consultar carrito no encontrado
    Given url karate.config.baseUrl + '/carrinhos/qbMqntef4iTOwWfq'
    And header accept = 'application/json'
    When method get
    Then status 400
    And match response ==
      """
      {
        "message": "Carrinho não encontrado"
      }
      """
    * print 'Carrito específico:', response