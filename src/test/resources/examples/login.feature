Feature: Prueba de ServeRest

  Scenario: Login
    Given url 'https://serverest.dev/login'
    And header Content-Type = 'application/json'
    * def loginBody =
      """
      {
  "email": "juanpq123456789@qa.com.br",
  "password": "testeq12"
}
      """
    And request loginBody
    When method post
    Then status 200
    * print response
    And match response.message == "Login realizado com sucesso"
    * def tokenFull = response.authorization
    * print 'AUTORIZACIÓN CRUDA:', tokenFull
    * def token = tokenFull.replace('Bearer ', '')
    * print 'TOKEN LIMPIO:', token
   # * def result = { token: token }


  Scenario: Login error
    Given url 'https://serverest.dev/login'
    And header Content-Type = 'application/json'
    * def loginBody =
      """
      {
        "email": "dev@qa.com",
        "password": "abc"
      }
      """
    And request loginBody
    When method post
    Then status 401
    * print response
    And match response.message == 'Email e/ou senha inválidos'
  #And match response.authorization contains 'Bearer '
