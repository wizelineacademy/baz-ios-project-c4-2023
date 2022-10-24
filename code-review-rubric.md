# Code Review Rúbrica

Este documenta determina el criterio usado para revisión de código.

En orden de importancia:

| Criterio | Excelente (4) | Bueno (3) | Adecuado (2) | En desarrollo (1) |
|---|---|---|---|---|
| **Especificaciones y exactitud del programa** | No hay errores. El programa funciona correctamente y cumple con todas las especificaciones técnicas. | Hay detalles menores en las especificaciones del programa, algunas funciones están programadas incorrectamente. | El programa tiene un número significativo de errores y exhibe de manera constante un funcionamiento incorrecto. | El programa solo funciona correctamente en pocos casos. |
| **Legibilidad de Código y Código Limpio** | No hay errores, el código es limpio, entendible y bien estructurado. | Temas menores con indentacion, uso de espacios en blanco, nombres de variables y organización general. | Tiene al menos un problema mayor con indentanción, espacios en blanco, nombres de variables y/o organización. | Tiene problemas mayores con al menos 3 de las cuatro subcategorías de legibilidad y código limpio. |
| **Eficiencia de Código** | No tiene errores. El código uso el mejor enfoque en cada caso. | N/A | El código usa malos enfoques en al menos una parte. | Muchas funciones del código se pudieron hacer de forma más rápida y sencilla. |
| **Documentación** | No hay errrores. El código está bien documentado. | Una o más partes del código se podrían beneficiar de agregar comentarios o el código tiene demasiados comentarios. | El header del archivo no está, líneas o secciones de código son complicadas, no tienen comentarios o los comentarios no son significativos. | No cuenta con ningún tipo de comentario |
| **Especificaciones del proyecto ** | No hay errores. | N/A | Detalles menores en lo que se asignó, por ejemplo, archivos nombrados incorrectamente o instrucciones adicionales no comprendidas. | Detalles significativos en lo que se asignó, instrucciones adicionales ignoradas o completamente mal entendidas. | 

### Especificaciones del programa

El programa necesita cumplir especificaciones y funcionar correctamente. Esto significa que se comporta como es esperado, produce la salida esperada para diferentes entradas sin errores.

### Legibilidad

El código necesia ser legible tanto para ti como para un tercero. Esto incluye:
* Uso constante de indentación (usando tabs, o N espacios, pero mantener consistencia)
* Adopta las convenciones de la guía de [estilo de swift](https://google.github.io/swift/)
* Utiliza nombres descriptivos. Variables de una palabra o abreviaciones terminan siendo ambiguas y es dificil inferir su propósito. Ejemplos:
    - `let n: 3` -> `let numberOfRowsInSection: 3`
    - `let name: "José"` -> `let userFirstName`
* Organiza tu código. Agrupa tus propiedades y métodos segun su función y reusalibidad.
* Agregar los espacios en las declaraciones correspondientes
    * 1 espacio entre nombre y tipo de definición:
        - `let name**: **String`
        - `class SomeClass**: **SuperClass, FirstProtocol, SecondProtocol`
    * 2 espacios entre dos tipos:
        - `let diccionary: [Key** : **Valie]`
        - `let closure: (String)** -> **Void`
        - `func method(param: Type)** -> **Void`
    * 1 linea entre methodos:

```   
    func one() { }\n
    \n
    func two() { }\n
```

Consulta las guías de estilo para Swift:
- [Swift Style Guide](https://google.github.io/swift/)

### Documentación
Cada archivo debe contener al inicio un comentario de cabecera. Que cuando menos debe contener el nombre del archivo y modulo, el nombre del autor, 
una descripción del código que incluye y que hace. Otros detalles pueden incliur la fecha en la que fue creado, descipcion sobre el funcionamiento interno del código,
comentarios para pruebas o explicacion de conceptos complejos, referencias necesarias para correrco o recursos que te ayudaron a escribirlo.

El código mismo también debe ser documentado a través de comentarios. Esto requere un balance entre comentar todo, que puede agregar ruido y confundir mas al lector,
y no comentar nada, que lleva al lector a asumir o requerir ayuda para navegar las partes mas complejas. Como regla general agrega un comentario describiendo declaraciones,
y fragmentos de código que realicen varias operaciones no intuitivas.

### Eficiencia de código
Hay varias formas de escribir un programa que cumpla con la especificacion. Pero asi como algunas pueden ahorrarte tiempo copiando y pegando una accion en varias secciones de tu proyecto,
otra podria ser mover la tarea a una funcion y mandarla llamar en tu proyecto. La segunda opcion es la preferida no solo por la eficiencia en tiempo de ejecuccion, 
sino tambien por su accesibilidad y mantenibilidad.   

### Especificaciones del proyecto
Las especificaciones suelen tener requerimientos fuera del programa mismo. Algunas tareas incluyen como nombrar y donde colocar archivos, buenas prácticas para el versionamiento de código,
como se implementa el programa dentro de tu proyecto, etc. 
