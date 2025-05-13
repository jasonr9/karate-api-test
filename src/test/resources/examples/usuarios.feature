Feature: Prueba de ServeRest

  Scenario: Usuarios
    Given url 'https://serverest.dev/usuarios'
    And param administrador = 'true'
    When method get
    Then status 200
    * print response
    And match each response.usuarios[*].administrador == 'true'

  Scenario: Validar cuando se registra un nuevo usuario
    Given url 'https://serverest.dev/usuarios'
    * def loginBody =
      """
      {
    "nome": "Juan Perez",
    "email": "juanpq123456789@qa.com.br",
    "password": "testeq12",
    "administrador": "true"
    }
    """
    And request loginBody
    When method post
    Then status 201
    * print response

  Scenario: Validar cuando un correo ya existe
    Given url 'https://serverest.dev/usuarios'
    * def loginBody =
      """
      {
        "nome": "Juan Perez",
        "email": "beltrano@qa.com.br",
        "password": "testeq12",
        "administrador": "true"
      }
      """
    And request loginBody
    When method post
    Then status 400
    * print response


  Scenario: Buscar Usuarios
    Given url 'https://serverest.dev/usuarios/0uxuPY0cbmQhpEz1'
    When method get
    Then status 200
    * print response

  Scenario: Buscar Usuario no encontrado
    Given url 'https://serverest.dev/usuarios/0uxuPY0cbmQhpEz'
    When method get
    Then status 400
    * print response

  Scenario: Eliminar Usuarios
    Given url 'https://serverest.dev/usuarios/3N0DudevN1BfjKdA'
    When method delete
    Then status 200
    * print response

  Scenario: Eliminar Usuarios no permitido
    Given url 'https://serverest.dev/usuarios/0uxuPY0cbmQhpEz1'
    When method delete
    Then status 400
    * print response

  Scenario: Actualizar Usuarios de un Correo electrónico ya registrado
    Given url 'https://serverest.dev/usuarios/0uxuPY0cbmQhpEz1'
    * def loginBody =
      """
      {
        "nome": "Sih Teste",
        "email": "pnpc@emailteste.com",
        "password": "1234",
        "administrador": "true"
      }
      """
    And request loginBody
    When method put
    Then status 200
    * print response


  Scenario: Actualizar Usuarios un Registro exitoso
    Given url 'https://serverest.dev/usuarios/2tMAZujjWlyQyVG6'
    * def loginBody =
      """
     {
            "nome": "Novo Usuário",
            "email": "Clare.Jast-Berge@yahoo.com",
            "password": "senhaNova",
            "administrador": "true"
        }
      """
    And request loginBody
    When method put
    Then status 201
    * print response

  Scenario: Actualizar Usuarios de un Correo electrónico ya registrado
    Given url 'https://serverest.dev/usuarios/0uxuPY0cbmQhpEz1'
    * def loginBody =
      """
      {
        "nome": "Fulano da Silva",
        "email": "beltrano@qa.com.br",
        "password": "teste",
        "administrador": "true"
      }
      """
    And request loginBody
    When method put
    Then status 400
    * print response



