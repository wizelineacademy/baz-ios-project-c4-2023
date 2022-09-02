# BAZ Proyecto Final iOS C1 2022

Gracias por participar en este curso de Wizeline Academy!

Este archivo README contiene instrucciones de como completar tu proyecto final.

## Tabla de Contenidos

* [Introducción](#introduccion)
* [El Proyecto](#el-proyecto)
* [Requerimientos](#requerimientos)
* [Por donde empezar](#por-donde-empezar)
* [Contenido de la Aplicación](#contenido-de-la-aplicacion)
* [Entregables](#entregables)
* [TheMovieDb API](#themoviedb-api)

## Introducción

Este curos de iOS esta enfocado en mejorar tus habilidades técnicas.

Al finalizar el curso, habrás ganado la experiencia en las tencologias cubiertas en este curso, 
como aplicarlas, y las tecnicas para agilizar y eficientar tus tareas. 

Además, conocerás el funcionamiento interno de las tecnologías y las mejores prácticas.


## El Proyecto  

El propósito de este proyecto es que demuestres tus habilidades aprendidas en el curso y tu experiencia en desarrollo iOS.

Construirás y entregarás una aplicación completamente funcional.

No queremos limitarte pidiéndote que completes ejercicios. Queremos que construyas desde cero. 

Esperamos que encuentres este proyecto interesante y retador.

El objetivo  es constriur una aplicación que consuma `TheMovieDB` API.

> \*_NOTA:_ Incluye `f6cd5c1a9e6c6b965fdcab0fa6ddd38a` como `api_key` en tus peticiones (la credencial para consumir la API) \*

Usa esta API de películas como una guía para iniciar tus ideas. 
Recuerda que este es **Tu** proyecto y puedes ser tan creativo como tu desees.

## Requerimientos

Estos son los requerimientos principales para la evaluación de tu entrega final:

- Variables, Constantes, y tipos de datos
- Funciones y bloques (closures)
- Encadenado opcional y enlazado opcional. 
- Collecciones en Swift 
- Ambiente de desarrollo integrado Xcode (IDE)  
- Versionamiento de código con git 
- Propiedades por tipo y por valor
- Herencia, protocolos y extensiones 
- Ciclo de vida de interfaz
- Vistas en archivos XIBs y Storyboard
- Elementos visuales y controles básicos (UIKit)
- Centro de notificaciones
- UITableView y UICollectionView
- Servicios REST

## Por donde empezar

En este repositorio incluimos un proyecto de Xcode.

En el existen componentes básicos que puedes usar para estructurar tu aplicación.
Siéntete libre de agrerar, modificar o remover según consideres necesario.

Para empezar, sigue los siguientes pasos:

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
    - Reseñas de la pelíucla

## Entregables

Hemos determinado fechas para que planees tus entregables. Te recomendamos trabajar continuamente y hacer progresos constantes.
No dejes todo para el final.

Cabe mencionar que puedes recibir retroalimentacion de parte de un mentor para tu primer y segundo entregable, 
dandote la oportunidad de corregir y mejorar tu código base. 

Para la entrega final tambien puedes solicitar retroalimentación, pero no hay fecha nueva de revisión.
Si tienes problemas y necesitas ayuda no dudes en solicitar un mentor en el canal de telegram.

> \*_Importante:_ esta lista en los entregables es solo una guía para ayudarte a distribuir la carga de trabajo; puedes extender funcionalidad como lo veas necesario \*

### Primer entregable

Construye una aplicacion con las siguientes caracteristicas:

* Clona este repositorio con tu cuenta de github.
* Completa y consume la TheMovieDB API.
* Implementa los principios de diseño

### Segundo entregable 

Usando lo construido en tu entregable anterior:

* Usa para mostrar la informacion de las películas
* Declara vistas con archivos xibs y Storyboard
* Implementa un UICollectionView en al menos una pantalla
* Introduce navegación en entre tus pantallas
* Carga las imágenes asíncronamente

### Entregable Final 

Termina o implementa la funcionalidad restante y resuelve cualquier comentario pendiente que hayas recibido.

* Haz uso de protocolos y delegados
* Implementa el centro de notificaciones
* Completa todos los requerimientos del proyecto


## Presentando tus entregables

Para presentar cada uno de tus entregables, sigue los siguientes pasos:
* Empuja tu rama de desarrollo al repo remoto
* Crea un [Pull Request para fusionar](https://docs.github.com/es/pull-requests/collaborating-with-pull-requests/incorporating-changes-from-a-pull-request/merging-a-pull-request-with-a-merge-queue) tus cambios a tu rama principal 
* Agrega a los mentores para que revisen tu código
* Copia la url de tu Pull Request e ingresala en este [formulario](https://forms.gle/oZtRk3QknRFLpgQu9)
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

> \*_Importante:_ No olvides incluir cualquier informacion necesaria para correr tu proyecto. Credenciales, varaibles de ambiente, archivos de configuración, etc. 
