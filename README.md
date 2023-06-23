
## Información general

La aplicación Amiibo es una aplicación que permite explorar y guardar información sobre los amiibo, figuras coleccionables utilizadas en los juegos de Nintendo usando el api [AmiiboAPI](https://amiiboapi.com/docs/).
Con esta aplicación, puedes ver una lista de amiibo, filtrar por el tipo de amiibo que te gusta, ver detalles de cada amiibo y guardar tus amiibo favoritos para acceder a ellos fácilmente más adelante.


### Requerimientos

* [API](https://amiiboapi.com/docs/) AmiiboAPI.
* Al abrir la aplicación se mostraras dos sesiones: _Listados_, _Favoritos_.
* Se mostrara un listado de amiibo en la sesión de _Listados_ en el caso de que tengas internet.
* La aplicacion permitira filtrar los amiibo por sus tipos y ordenarlos alfabeticamente en el caso de que tengas internet.
* Permitir guardar un amiibo favorito en la sesión de _Favoritos_.
* Se mostrara un listado de amiibo favoritos en la sesión de _Favoritos_. En el caso de que no tengas internet se mostrara de igual manera la información.
* Accede a información detallada sobre un amiibo, como su nombre, serie, fecha de lanzamiento, personaje, imagen.

## Funcionalidades
_Puedes hacer lo siguiente en la aplicación_

### Lista de amiibo
La aplicación te muestra una lista de amiibo.

### Gestionar la información localmente
La aplicación permitira guardar tu amiibo favorito.

### Lista de amiibo favoritos
La aplicación te muestra una lista de amiibo favoritos.

### Filtrar los amiibo por su tipo y ordenarlos alfabeticamente
La aplicación te permite filtrar los amiibos por su tipo y ordenalos de manera alfabetica.

### Información detallada de un amiibo
La aplicación te muestra nombre, serie, fecha de lanzamiento, personaje, imagen.

## Arquitectura
La aplicación Amiibo sigue una arquitectura basada en Clean Architecture (Arquitectura Limpia) con el patrón de arquitectura MVVM (Modelo-Vista-ViewModel). Esta combinación de arquitecturas promueve la separación de responsabilidades y la escalabilidad del código, al tiempo que proporciona un flujo de datos reactivo para la capa de presentación.


## Estructura del proyecto
Se identifican 3 módulos
* Presentation (Amiibo) - Utiliza el patrón MVVM para gestionar la interfaz de usuario. La vista se encarga de mostrar los elementos visuales al usuario y recoger sus interacciones. El ViewModel actúa como intermediario entre la vista y el modelo de datos, procesando las solicitudes del usuario, realizando llamadas a los casos de uso del dominio y actualizando la vista con los resultados.
* Domain - Engloba la lógica central de la aplicación. Contiene los casos de uso, que representan las operaciones y acciones que la aplicación puede realizar. Esta capa no depende de detalles de implementación y se centra en las reglas de negocio.
* Infrastructure - Se encarga de interactuar con las fuentes de datos externas, como bases de datos o servicios web. Aquí se encuentran los repositorios, que abstraen el acceso a los datos y proporcionan una interfaz para realizar operaciones de lectura y escritura.


## Construido con
### [Alomofire](https://github.com/Alamofire/Alamofire) - Cliente HTTP
Se utilizó Alomofire para el consumo de servicios Rest, ya que facilita este trabajo en aplicaciones iOS y es desarrollada por la comunidad open source.
Se agrego un Timeout en cliente Http de 60 segundos. Esto puede cambiar según la necesidad de proyecto.
### [CoreData](https://developer.apple.com/documentation/coredata) - Persistencia de datos
Para la base de datos se usó CoreData ya que es una biblioteca de persistencias propia de apple, que abstrae los detalles de la asignación de sus objetos, lo que facilita administrar (guardar, leer y eliminar) datos de Swift y Objective-C. Permite zincronizar datos en varios dispositivos en una sola cuenta de iCloud.
### [Swinject](https://github.com/Swinject/Swinject) - Inyección de dependencias
Para realizar la inyección de dependencias se usó la librería Injectable la cual proporciona una forma de usar la inyección de dependencias.
Swinject funciona con el sistema de tipos genéricos Swift y funciones de primera clase para definir las dependencias de su aplicación de manera simple y fluida.
### [Storyboard](https://developer.apple.com/library/archive/documentation/General/Conceptual/Devpedia-CocoaApp/Storyboard.html) - Para creacion de las vistas
Utilizado para el diseño de la interfaz de usuario utilizando la representación visual de las pantallas y la gestión de las transiciones entre ellas..
### [Combine](https://developer.apple.com/documentation/combine) - Reactividad
Combine es un marco para escribir código reactivo, es una libria propia de apple. El marco Combine proporciona una API Swift declarativa, permitiendo trabajar con eventos asíncronos de forma más simplificada.
### [Swift Package Manager](https://developer.apple.com/documentation/xcode/swift-packages) - Gestor de dependencias
Herramienta de gestión de dependencias incorporada en Xcode para la administración de paquetes y la inclusión de bibliotecas externas en el proyecto.


## Version

**Version name :** 1.0
