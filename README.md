## Guía para Ejecutar un Proyecto de Spring Boot

Este tutorial asume que ya tienes instalado **Java Development Kit (JDK)** y una herramienta de construcción como **Maven** o **Gradle**.

---

### Paso 1: Crear el Proyecto Base

Puedes usar **Spring Initializr** para generar la estructura básica de tu proyecto.

1.  Abre tu navegador y ve a [https://start.spring.io/](https://start.spring.io/).

2.  Configura tu proyecto con las siguientes opciones (ejemplo):
    * **Proyecto:** Maven (o Gradle, si lo prefieres).
    * **Lenguaje:** Java.
    * **Spring Boot:** La versión estable más reciente (ej. 3.2.0).
    * **Metadata del Proyecto:**
        * **Grupo:** `com.ejemplo`
        * **Artefacto:** `mi-aplicacion-spring`
    * **Dependencias:** Añade al menos la dependencia **Spring Web** para poder crear un controlador.

3.  Haz clic en el botón **"Generar"**. Esto descargará un archivo ZIP.

4.  Descomprime el archivo ZIP en la carpeta de tu preferencia.

### Paso 2: Importar y Configurar en tu IDE

Abre el proyecto en tu entorno de desarrollo integrado (IDE) favorito (como IntelliJ IDEA, VS Code con extensiones de Spring, o Eclipse).

1.  **Importar:** Abre el IDE e importa el proyecto como un proyecto Maven o Gradle existente (apuntando al directorio que descomprimiste).
2.  **Verificar dependencias:** Asegúrate de que tu IDE haya descargado todas las dependencias necesarias.

### Paso 3: Crear un Controlador Básico

Para verificar que la aplicación funciona, vamos a crear un *endpoint* sencillo.

1.  Dentro del paquete principal (ej. `com.ejemplo.miappspring`), crea un nuevo archivo de clase Java llamado `ControladorHolaMundo`.

2.  Añade el siguiente código al archivo:

    ```java
    package com.ejemplo.miappspring;

    import org.springframework.web.bind.annotation.GetMapping;
    import org.springframework.web.bind.annotation.RestController;

    @RestController
    public class ControladorHolaMundo {

        @GetMapping("/hola")
        public String decirHola() {
            return "¡Hola Mundo con Spring Boot!";
        }
    }
    ```

    * `@RestController`: Combina `@Controller` y `@ResponseBody`, indicando que esta clase manejará las solicitudes web y devolverá el valor de retorno directamente como respuesta.
    * `@GetMapping("/hola")`: Mapea las solicitudes HTTP GET a la ruta `/hola` a este método.

### Paso 4: Ejecutar la Aplicación

Spring Boot simplifica la ejecución gracias a su clase principal que contiene el método `main`.

#### Opción A: Ejecutar desde el IDE

1.  Localiza la clase principal de tu aplicación (la que termina en `Application`, ej. `MiAplicacionSpringApplication.java`).
2.  Haz clic derecho sobre ella y selecciona la opción para **"Ejecutar"** o **"Run"** (`Run 'MiAplicacionSpringApplication'`).

#### Opción B: Ejecutar desde la Terminal (Recomendado para Producción/Distribución)

1.  Abre la terminal o línea de comandos y navega hasta el directorio raíz de tu proyecto.

2.  **Construir el proyecto (crear el JAR ejecutable):**

    * **Maven:**
        ```bash
        ./mvnw package
        ```
    * **Gradle:**
        ```bash
        ./gradlew build
        ```
    Esto generará un archivo JAR ejecutable en el directorio `target/` (Maven) o `build/libs/` (Gradle).

3.  **Ejecutar el archivo JAR:**
    ```bash
    java -jar target/mi-aplicacion-spring-0.0.1-SNAPSHOT.jar
    # (Asegúrate de usar el nombre exacto de tu archivo JAR)
    ```

### Paso 5: Verificar el Funcionamiento

Una vez que la aplicación se está ejecutando, el servidor de Spring Boot (por defecto, **Tomcat embebido**) se iniciará normalmente en el puerto **8080**.

1.  Abre tu navegador web o usa una herramienta como `curl` o Postman.
2.  Accede a la URL: `http://localhost:8080/hola`

**Resultado esperado:**
Verás el texto: **¡Hola Mundo con Spring Boot!**

---

### Siguientes Pasos

Ahora que tu aplicación está en funcionamiento:

* **Bases de Datos:** Si necesitas persistencia, configura el archivo `src/main/resources/application.properties` con los detalles de tu base de datos y añade la dependencia **Spring Data JPA**.
* **Servicios y Componentes:** Estructura tu código usando capas (Controladores, Servicios, Repositorios, Entidades) para una arquitectura limpia.
