package examples;

import com.intuit.karate.junit5.Karate;

public class RunnerTest {

    @Karate.Test
    Karate testAll() {
        return Karate.run(
               //"classpath:examples/login.feature"
                "classpath:examples/usuarios.feature"
              //"classpath:examples/productos.feature"
               // "classpath:examples/carritos.feature"
        );
    }
}
