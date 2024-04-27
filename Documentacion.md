# Estuadiantes:
### 202109732 José Eduardo Galdámez González
### 202000544 Roberto Carlos Gómez Donis
### 202109754 Aldo Saúl Vásquez Moreira
### 202001800 José Manuel Ibarra Pirir

# Documentación de la Base de Datos Electoral

## Introducción

Este proyecto se centra en el diseño de una base de datos para administrar información detallada sobre elecciones, incluyendo zonas geográficas, partidos políticos, eventos electorales, resultados y demografía de votantes. La normalización se ha implementado meticulosamente para optimizar el almacenamiento, preservar la integridad de los datos y asegurar la escalabilidad y facilidad de mantenimiento del sistema.

## Proceso de Normalización

### Primera Forma Normal (1NF)

**Objetivo:** Eliminar redundancias y asegurar que cada campo contenga solo valores atómicos.

**Implementación:**
- **Tablas diseñadas:** `Zona`, `PartidoPolitico`, `Eleccion`, `ResultadoEleccion`, y `Demografia`.
- **Unicidad y atomicidad:** Cada tabla está diseñada para contener datos únicos y atómicos, eliminando grupos repetitivos de datos.

### Segunda Forma Normal (2NF)

**Objetivo:** Asegurar que cada atributo dependa completamente de la clave primaria.

**Implementación:**
- **Eliminación de dependencias parciales:** Los atributos que no dependían completamente de la clave primaria se movieron a tablas separadas, garantizando que cada atributo dependa solo de la clave primaria de su tabla.

### Tercera Forma Normal (3NF)

**Objetivo:** Eliminar dependencias transitivas entre campos no clave.

**Implementación:**
- **Dependencias directas:** Todos los campos no clave solo dependen de sus claves primarias, utilizando claves foráneas para gestionar las relaciones entre tablas y asegurar la integridad referencial.

## Modelo de Datos y Estructura de Tablas

### Tabla: `Zona`
- **Campos:**
  - `ID_Zona`: Clave primaria, entero autoincremental.
  - `Nombre`: Nombre de la zona (país, región, departamento, municipio), tipo VARCHAR(255).
  - `Tipo`: Tipo de la zona (país, región, etc.), tipo VARCHAR(100).
  - `ID_Padre`: Clave foránea que referencia a `ID_Zona`, representa la jerarquía geográfica.
- **Relaciones:**
  - Una `Zona` puede tener múltiples subzonas.
  - Una `Zona` puede estar asociada con múltiples elecciones a través de la tabla `Eleccion`.

### Tabla: `PartidoPolitico`
- **Campos:**
  - `ID_Partido`: Clave primaria, entero autoincremental.
  - `Nombre`: Nombre del partido político, tipo VARCHAR(255).
  - `Sigla`: Siglas del partido, tipo VARCHAR(50).
- **Relaciones:**
  - Un `PartidoPolitico` puede participar en múltiples `ResultadoEleccion`.

### Tabla: `Eleccion`
- **Campos:**
  - `ID_Eleccion`: Clave primaria, entero autoincremental.
  - `Nombre`: Nombre de la elección, tipo VARCHAR(255).
  - `Ano`: Año de la elección, tipo INT.
  - `ID_Zona`: Clave foránea que referencia a `ID_Zona`.
- **Relaciones:**
  - Una `Eleccion` puede tener múltiples `ResultadoEleccion`.
  - Está vinculada a una `Zona`.

### Tabla: `ResultadoEleccion`
- **Campos:**
  - `ID_Resultado`: Clave primaria, entero autoincremental.
  - `ID_Eleccion`: Clave foránea que referencia a `ID_Eleccion`.
  - `ID_Partido`: Clave foránea que referencia a `ID_Partido`.
  - `Votos`: Cantidad de votos obtenidos, tipo INT.
- **Relaciones:**
  - Relaciona `Eleccion` y `PartidoPolitico` para detallar los resultados.

### Tabla: `Demografia`
- **Campos:**
  - `ID_Demografia`: Clave primaria, entero autoincremental.
  - `ID_Zona`: Clave foránea que referencia a `ID_Zona`.
  - `Sexo`: Sexo del grupo demográfico, tipo VARCHAR(50).
  - `Raza`: Raza del grupo demográfico, tipo VARCHAR(50).
  - `Educacion`: Nivel educativo, tipo VARCHAR(50).
  - `Analfabetos`: Número de analfabetos, tipo INT.
  - `Alfabetos`: Número de alfabetos, tipo INT.
  - `Primaria`: Número con educación primaria, tipo INT.
  - `NivelMedio`: Número con educación media, tipo INT.
  - `Universitarios`: Número con educación universitaria, tipo INT.
- **Relaciones:**
  - Está vinculada a una `Zona`, proporcionando datos demográficos para análisis sociológicos detallados.
