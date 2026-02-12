# Bloque 4. *Consultas SQL tipo examen*
_______________________________

📌 Nivel: Intermedio
📌 Enfoque: JOIN, GROUP BY, HAVING, funciones de agregación 


**Instrucciones**. Utilizar la base de datos *salesbd* para construir las consultas. 
En la siguiente imagen se presenta el modelo relacional de la base de datos.
Es indispensable que primero construyas la base de datos, las tablas e insertes datos de prueba (puedes utilizar la de la práctica 1).

![Modelo relacional salesdb](salesdb.png)

Nota. Sigue el ejemplo para preparar tu entregable.

Ejemplo
---------------
0. Listado de todos las tuplas de la tabla mi_tabla con la condicion_1.
   
**Solución** ✅
```sql
   SELECT *
     FROM mi_tablas
    WHERE condicion_1
```

**Salida** 📌

OPCIÓN 1. Imagen con el resultado de la consulta. 

![Resultado de consulta 1](tabla1.png)

OPCIÓN 2. Tabla con el resultado de la consulta.

| idTabla | atributo1 | atributo2 | atributo3 | 
| --------- | --------- | --------- | --------- |
| 5671 | Nissan | Versa | 2024 |
| 5672 | Honda| City | 2025 | 
| 5673 | Toyota | Corolla | 2026 |  
| 5674 | Honda | Civic | 2026 | 


Consultas
---------------
1. 🧠 *RETO 1: Cliente con mayor gasto total*. Obtén el cliente que más dinero ha gastado en pedidos. Muestra su nombre y el total gastado.
   
**Solución** ✅

   TODO script SQL

**Salida** 📌

   TODO listado de atributos y tuplas
   
2. 🧠 *RETO 2: Producto más vendido (en unidades)*. Identifica el producto más vendido considerando la cantidad total de unidades vendidas.

   
**Solución** ✅

   TODO script SQL

**Salida** 📌

   TODO listado de atributos y tuplas
   
3. 🧠 *RETO 3: Total de ventas por ciudad*. Muestra el total de ventas (importe) agrupado por ciudad del cliente.

   
**Solución** ✅

   TODO script SQL

**Salida** 📌

   TODO listado de atributos y tuplas

4. 🧠 *RETO 4: Clientes con más de una dirección*. Lista los clientes que tienen más de una dirección asociada.

   
**Solución** ✅

   TODO script SQL

**Salida** 📌

   TODO listado de atributos y tuplas
   
5. 🧠 *RETO 5: Pedidos con total superior al promedio*. Obtén los pedidos cuyo total sea mayor al promedio de todos los pedidos.

   
**Solución** ✅

   TODO script SQL

**Salida** 📌

   TODO listado de atributos y tuplas

6. 🧠 *RETO 6: Proveedor con más productos vendidos*. Identifica el proveedor cuyos productos se han vendido en mayor cantidad de unidades.

   
**Solución** ✅

   TODO script SQL

**Salida** 📌

   TODO listado de atributos y tuplas
7. 🧠 *RETO 7: Clientes que nunca cancelaron pedidos*. Lista los clientes que no tienen ningún pedido con estado 'Cancelled'.

   
**Solución** ✅

   TODO script SQL

**Salida** 📌

   TODO listado de atributos y tuplas

8. 🧠 *RETO 8: Ingreso total por método de pago*. Muestra el ingreso total generado por cada método de pago.

   
**Solución** ✅

   TODO script SQL

**Salida** 📌

   TODO listado de atributos y tuplas

9. 🧠 *RETO 9: Pedidos con más de un producto distinto*. Lista los pedidos que incluyen más de un producto diferente.

   
**Solución** ✅

   TODO script SQL

**Salida** 📌

   TODO listado de atributos y tuplas

10. 🧠 *RETO 10: Clientes con pedidos en más de una ciudad*. Encuentra los clientes que hayan realizado pedidos desde direcciones en más de una ciudad.


**Solución** ✅

   TODO script SQL

**Salida** 📌

   TODO listado de atributos y tuplas


📘 ¿Qué se refuerza?
✔ Lectura de esquemas
✔ Lógica de negocio
✔ Subconsultas
✔ Consultas tipo examen universitario / técnico

Dime qué quieres, cómo lo quieres y lo armamos 💪 🚀

