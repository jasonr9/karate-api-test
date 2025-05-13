function fn() {
  var config = {
    baseUrl: 'https://serverest.dev'
  };

  // Llamar al login.feature y guardar token globalmente
  var loginResponse = karate.call('classpath:examples/login.feature');
  config.token = loginResponse.token;

  return config;
}
