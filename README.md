# BAZ Proyecto Final iOS C1 2022

Gracias por participar en este curso de Wizeline Academy!

Este archivo README contiene instrucciones de cómo completar tu proyecto final.

## Tabla de Contenidos

* [Introducción](#introduccion)
* [El Proyecto](#el-proyecto)
* [Requerimientos](#requerimientos)
* [Por dónde empezar](#por-donde-empezar)
* [Contenido de la Aplicación](#contenido-de-la-aplicacion)
* [Entregables](#entregables)
* [TheMovieDb API](#themoviedb-api)

## Introducción

Este curso de iOS está enfocado en mejorar tus habilidades técnicas.

Al finalizar el curso, habrás ganado la experiencia en las tecnologías cubiertas en este curso, 
cómo aplicarlas, y las técnicas para agilizar y eficientar tus tareas. 

Además, conocerás el funcionamiento interno de las tecnologías y las mejores prácticas.


## El Proyecto  

El propósito de este proyecto es que demuestres tus habilidades aprendidas en el curso y tu experiencia en desarrollo iOS.

Construirás y entregarás una aplicación completamente funcional.

No queremos limitarte pidiéndote que completes ejercicios. Queremos que construyas desde cero. 

Esperamos que encuentres este proyecto interesante y retador.

El objetivo  es constriur una aplicación que consuma `TheMovieDB` API.

> \*_NOTA:_ Incluye `f6cd5c1a9e6c6b965fdcab0fa6ddd38a` como `api_key` en tus peticiones (la credencial para consumir la API) \*

Usa esta API de películas como una guía para iniciar tus ideas. 
Recuerda que este es **Tu** proyecto y puedes ser tan creativo como tú desees.

## Requerimientos

Estos son los requerimientos principales para la evaluación de tu entrega final:

- Pruebas unitarias
- Injeccion de dependencias
- Herencia y composición de protocolos 
- Genericos en funciones, definiciones y protocolos  
- Concurrencia 
- Structural design pattern (MVVM, VIPER)
- UserDefaults 
- KeyChain Service
- Persistance
- Core Location
- MapKit
- AVFoundation

## Por dónde empezar

En este repositorio incluimos un proyecto de Xcode.

En él existen componentes básicos que puedes usar para estructurar tu aplicación.
Siéntete libre de agrerar, modificar o remover según consideres necesario.

Para empezar, sigue los estos pasos:

**Paso 1:** Clona este repositorio a tu máquina local. [Guía de configuración de Github](https://docs.github.com/get-started/quickstart/set-up-git)

**Paso 2:** Crea tu rama principal `main` con tu nombre `main-(nombre)-(apellido)`, ejemplo: main-steve-jobs

**Paso 3:** Crea tu rama de desarrollo `dev` con tu nombre `dev-(nombre)-(apellido)`, ejemplo: dev-steve-jobs

**Paso 4:** Crea tus ramas en cada tarea usando `task-(nombre)-(apellido)-descripcion`, ejemplo: task-steve-jobs-nueva-capa-de-network
Debes crear un PR para mezclar tus cambios a tu rama de desarrollo.

**Paso 5:** Crea y empuja tus cambios (Commits) periodicamente.

**Paso 6:** Cuando tus entregables esten listos crea un Pull Request de tu rama de desarrollo a tu rama principal.
`main-(nombre)-(apellido) < dev-(nombre)-(apellido)`

**Paso 7:** No olvides diviértete!

> \*_NOTA:_ Sigue este flujo de trabajo para tus colaboraciones 
[https://docs.github.com/get-started/quickstart/github-flow](https://docs.github.com/get-started/quickstart/github-flow) \*

## Contenido de la Aplicación

Tu aplicación debe contener las siguientes pantallas.

1. Home
Mostrar películas con diferentes filtros:
    - Trending
    - Now Playing
    - Popular
    - Top Rated 
    - Upcoming

2. Search (Búsqueda por película o actor)
Mostrar resultados por palabra clave y por consulta

3. Movie Details
Muestra la informacion de una película específica como:
    - Reseña
    - Reparto de actores
    - Películas similares
    - Películas recomendadas
    - Reseñas de la película

## Entregables

Hemos determinado fechas para que planees tus entregables. Te recomendamos trabajar continuamente y hacer progresos constantes.
No dejes todo para el final.

Cabe mencionar que puedes recibir retroalimentación de parte de un mentor para tu primer y segundo entregable, 
dandote la oportunidad de corregir y mejorar tu código base. 

Para la entrega final tambien puedes solicitar retroalimentación, pero no hay fecha nueva de revisión.
Si tienes problemas y necesitas ayuda no dudes en solicitar un mentor en el canal de telegram.

> \*_Importante:_ esta lista en los entregables es solo una guía para ayudarte a distribuir la carga de trabajo; puedes extender funcionalidad como lo veas necesario \*

> \*_IMPORTANTE PARA TUS ENTREGABLES:_ Una vez hayas terminado tu entregable y crees que está listo para su revisión definitiva por parte de tu mentor, deberás mergearlo a tu rama `dev`. Esta será la rama que tus mentores revisarán en cada entregable. \*

### Primer entregable

Construye una aplicacion con las siguientes características:

* Clona este repositorio con tu cuenta de github.
    - Crea y sube tus ramas `dev` y `main` a github.
    - Sigue la guía [Por dónde empezar](#por-donde-empezar)
* Agrega Injeccion de dependencias
    - Remueve las dependencias de modelo de datos (eg. `Movie`) en las vistas (eg. `TrendingViewController`)
    - Desacopla la peticiones a internet de la `MovieApi`
* Configura tu proyecto
    - Incluye un target para pruebas unitarias

* Manten una covertura de prueba de almenos 50%
    
Recuerda documentar, mantener buena legibilidad de código y otros [criterios de evaluación](code-review-rubric.md)

Deberás subir tus cambios y crear un Pull request con tu mentor a más tardar:
el día Viernes 21 de Abril - 2pm CT

Sube tu entregable con correcciones antes de:
el dia Martes 25 de abril - 2pm CT

### Segundo entregable 

Usando lo construido en tu entregable anterior:

* Haz uso de protocolos en el buscador de peliculas
* Implenenta genericos en las funciones de busqueda y API
* Implementa la arquitectura MVVM o VIPER en la aplicacion
    
* Manten una covertura de prueba de almenos 80%

Recuerda documentar, mantener buena legibilidad de código y otros [criterios de evaluación](code-review-rubric.md)

Deberás subir tus cambios y crear un Pull request con tu mentor a más tardar:
el día Viernes 28 de abril - 2pm CT

Sube tu entregable con correcciones antes de:
el dia Martes 2 de Mayo: - 2pm CT

### Entregable Final 

Termina o implementa la funcionalidad restante y resuelve cualquier comentario pendiente que hayas recibido.

* Utiliza persistencia de datos para guardar las peliculas favoritas
* Completa todos los requerimientos del proyecto
    - [Home, Search, Movie Details](#contenido-de-la-aplicacion)

Recuerda documentar, mantener buena legibilidad de código y otros [criterios de evaluación](code-review-rubric.md)

Deberás subir tu entrega final:
el dia Martes 9 de mayo - 2pm CT

## Presentando tus entregables

Para presentar cada uno de tus entregables, sigue estos pasos:
* Haz `push` de tu rama de desarrollo al repositorio remoto
* Crea un [Pull Request para fusionar](https://docs.github.com/es/pull-requests/collaborating-with-pull-requests/incorporating-changes-from-a-pull-request/merging-a-pull-request-with-a-merge-queue) tus cambios a tu rama principal 
* Agrega a los mentores para que revisen tu código
* Copia la url de tu Pull Request e ingrésala en este [formulario](https://forms.gle/1zzgvEjftSm1NacY9)
* Resuelve cualquier comentario que te dejen para mejorar tu código
* Haz `merge` para incorporar tus cambios a tu rama principal y continua con tu siguiente entregable
> \*_Importante:_ Si tienes problemas con conflictos en tus ramas no dudes en pedirle ayuda a tu mentor\*

# TheMovieDb API
The Movie Database (TMDB) es una base de datos comunitaria muy popular que incluye películas y series de television. Accede a la [documentación](https://developers.themoviedb.org/3/) para conocer su funcionamiento.

* URL base: `https://api.themoviedb.org/3`
* Llave de API: `f6cd5c1a9e6c6b965fdcab0fa6ddd38a`

### Algunos endpoints

|Nombre|URL|Ejemplo|
|:--:|:--:|:-----|
|Trending|`/trending/movie/day`|https://api.themoviedb.org/3/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&region=MX&page=1|
|Now Playing|`/movie/now_playing`|https://api.themoviedb.org/3/movie/now_playing?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&region=MX&page=1|
|Popular|`/movie/popular`|https://api.themoviedb.org/3/movie/popular?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&region=MX&page=1|
|Top Rated|`/movie/top_rated`|https://api.themoviedb.org/3/movie/top_rated?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&page=1&region=MX|
|Upcoming|`/movie/upcoming`|https://api.themoviedb.org/3/movie/upcoming?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&region=MX&page=1|
|Keyword|`/search/keyword?query={query}`|https://api.themoviedb.org/3/search/keyword?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&query=Matrix|
|Search|`/search/movie?query={query}`|https://api.themoviedb.org/3/search/movie?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&page=2&query=Matrix|
|Reviews|`/movie/{movieID}/reviews`|https://api.themoviedb.org/3/movie/603/reviews?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es|
|Similar|`/movie/{movieID}/similar`|https://api.themoviedb.org/3/movie/603/similar?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es|
|Recommendations|`/movie/{movieID}/recommendations`|https://api.themoviedb.org/3/movie/603/recommendations?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es|

### Imágenes
Puedes acceder a los recursos como posters y fondos de la siguiente manera: 

```
https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg
```

Accede a la [documentación](https://developers.themoviedb.org/3/getting-started/images) para conocer su funcionamiento.

> \*_Importante:_ No olvides incluir cualquier informacion necesaria para correr tu proyecto. Credenciales, variables de ambiente, archivos de configuración, etc. 
