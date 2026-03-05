# Práctica 0 – Biblioteca
## Las 12 Reglas de las Bases de Datos Distribuidas (C. J. Date)

**Asignatura:** Bases de Datos Distribuidas
**Alumno:** Brandon Torres De Paz
**No. Cuenta:** 489686
**Fecha:** 05 de marzo del 2026

---

## Desarrollo: Las 12 Reglas de Date

A continuación se describen cada una de las reglas, organizadas en una tabla de resumen y luego con una explicación ampliada.

### Tabla resumen

| #  | Regla                          | Descripción breve |
|----|--------------------------------|-------------------|
| 1  | Autonomía local                | Cada nodo opera de manera independiente. |
| 2  | No dependencia de un sitio central | No existe un nodo maestro del cual dependa todo el sistema. |
| 3  | Operación continua             | El sistema funciona sin interrupciones planificadas. |
| 4  | Independencia de ubicación     | El usuario ignora la localización física de los datos. |
| 5  | Independencia de fragmentación | El usuario trabaja con tablas completas, aunque estén fragmentadas. |
| 6  | Independencia de réplica       | La existencia de copias de datos es invisible para el usuario. |
| 7  | Procesamiento de consultas distribuidas | El sistema optimiza consultas que involucran varios sitios. |
| 8  | Manejo de transacciones distribuidas | Se garantizan las propiedades ACID en operaciones multisitio. |
| 9  | Independencia del hardware     | Puede ejecutarse sobre diferentes plataformas de hardware. |
| 10 | Independencia del sistema operativo | Puede ejecutarse sobre diferentes sistemas operativos. |
| 11 | Independencia de la red        | Puede funcionar con distintos protocolos y topologías. |
| 12 | Independencia del SGBD         | Capacidad de interoperar con otros gestores de bases de datos (heterogeneidad). |

---

### 2.1. Autonomía local

Cada sitio (nodo) de la red posee control total sobre sus propios datos. Las operaciones locales (consultas y actualizaciones) son gestionadas exclusivamente por el nodo local, sin intervención externa. Los recursos pertenecen al sitio y este decide cómo administrarlos.

### 2.2. No dependencia de un sitio central

El sistema no debe tener un servidor central del que dependan funciones esenciales como el diccionario de datos, el control de concurrencia o la recuperación ante fallos. Todos los nodos son iguales en cuanto a responsabilidades, evitando así puntos únicos de fallo y cuellos de botella.

### 2.3. Operación continua

Idealmente, las tareas de mantenimiento (agregar o eliminar nodos, crear fragmentos, actualizar software) no deben requerir la detención del sistema. El servicio debe permanecer disponible 24×7.

### 2.4. Independencia de ubicación

El usuario no necesita saber dónde están almacenados los datos. Las consultas se formulan de la misma manera independientemente de que los datos residan en el nodo local o en nodos remotos. El SGBDD resuelve la localización de forma transparente.

### 2.5. Independencia de fragmentación

Una tabla (relación) puede estar dividida en fragmentos (horizontales o verticales) y almacenada en distintos sitios. El usuario, sin embargo, debe poder consultar la tabla como si estuviera entera en un solo lugar. El sistema reconstruye la información a partir de los fragmentos.

### 2.6. Independencia de réplica

Pueden existir varias copias (réplicas) de un mismo dato en diferentes nodos, ya sea por razones de rendimiento o disponibilidad. El SGBDD debe ocultar esta multiplicidad al usuario: las actualizaciones se propagan a todas las réplicas y las consultas se dirigen a la copia más conveniente, todo ello de forma automática.

### 2.7. Procesamiento de consultas distribuidas

Cuando una consulta involucra datos de múltiples nodos, el sistema debe optimizarla considerando costes de comunicación, capacidad de procesamiento local y estrategias de combinación (join) distribuidas. El objetivo es minimizar el tiempo de respuesta y el tráfico en la red.

### 2.8. Manejo de transacciones distribuidas

Una transacción puede modificar datos en varios sitios. El SGBDD debe garantizar las propiedades ACID (Atomicidad, Consistencia, Aislamiento, Durabilidad) de manera global, utilizando protocolos como *two-phase commit* (2PC) para asegurar que todas las partes confirmen o aborten la transacción al unísono.

### 2.9. Independencia del hardware

El sistema debe poder funcionar en equipos de diferentes fabricantes y arquitecturas (PC, servidores RISC, mainframes) sin requerir modificaciones en las aplicaciones.

### 2.10. Independencia del sistema operativo

Debe ser posible que los nodos ejecuten distintos sistemas operativos (Windows, Linux, macOS) y que el SGBDD mantenga la comunicación y coherencia entre ellos.

### 2.11. Independencia de la red

El SGBDD debe adaptarse a diferentes protocolos de red (TCP/IP, IPX/SPX, etc.) y topologías (LAN, WAN), permitiendo que los nodos se comuniquen independientemente de la infraestructura subyacente.

### 2.12. Independencia del SGBD (heterogeneidad)

Idealmente, un sistema distribuido podría integrar nodos que utilicen distintos gestores de bases de datos (Oracle, MySQL, PostgreSQL, etc.). El SGBDD actuaría como un *middleware* que unifica el acceso y mantiene la consistencia entre productos heterogéneos.

---

## Referencias

- Date, C. J. (2001). *Introducción a los sistemas de bases de datos* (7ª ed.). Pearson Educación. (Capítulo 20: Bases de datos distribuidas).

---

## Evidencia 

![Imagen 1](Practica0Imagen1.jpeg)
