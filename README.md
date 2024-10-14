# Flutter Application Countries

Este proyecto es una aplicación Flutter que permite a los usuarios buscar información detallada sobre países en todo el mundo. Utiliza la API pública de [REST Countries](https://restcountries.com/) para obtener datos como la bandera, el nombre oficial y común del país, su capital, entre otros detalles.

## Características

- **Búsqueda de países:** Los usuarios pueden introducir el nombre de un país y obtener información en tiempo real sobre ese país.
- **Datos de los países:** Para cada país, se muestra:
  - Bandera (en formato SVG)
  - Nombre común y oficial
  - Capital del país
- **Interfaz intuitiva:** Se proporciona un campo de búsqueda para introducir el nombre del país deseado.
- **Consumo de API REST:** Utiliza [REST Countries API](https://restcountries.com/) para obtener la información.

## Tecnologías Utilizadas

- **Flutter:** Un SDK de UI open-source para crear aplicaciones multiplataforma.
- **Provider:** Una solución de gestión de estado ampliamente utilizada en Flutter.
- **Dio:** Una biblioteca para realizar solicitudes HTTP.
- **REST Countries API:** Una API pública para obtener datos de países.
- **Flutter SVG:** Para mostrar las banderas de los países en formato SVG.