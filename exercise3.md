# Bloque 3. *Consultas SQL nivel básico*
_______________________________

**Instrucciones**. Utilizar la base de datos *salesbd* para construir las consultas. 
En la siguiente imagen se presenta el modelo relacional de la base de datos.
Es indispensable que primero construyas la base de datos, las tablas e insertes datos de prueba.

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
1. Listar todos los clientes: *Obtén el customerID, name y email de todos los customer*.
   
**Solución** ✅

   ```sql
   select customerID, name, emmail from customer;
```

**Salida** 📌

   | customerID | name | email |  
| --------- | --------- | --------- | 
| 1 | John Smith | john.smith@email.com |
| 2 | Maria Garcia| maria.garcia@email.com |
| 3 | David Johnson | david.johnson@email.com |
| 4 | Sarah Williams | sarah.williams@email.com |
| 5 | Robert Brown | robert.brown@email.com |
		
2. Direcciones en una ciudad específica: *Muestra todas las direcciones que estén en la ciudad de Madrid*.
   
**Solución** ✅

   ```sql
   select * from address where city = 'Madrid';
```

**Salida** 📌

   | addressID | street | localy | city | postcode | state |  
| --------- | --------- | --------- | ------- | --------- | --------- |
| 6 | Calle Gran Vía 45 | Centro | Madrid | 28013 | Madrid |

					
   
3. Productos con precio mayor a 200: *Lista los productos cuyo precio sea mayor a 200*.
   
**Solución** ✅

   ```sql
   select * from product where price > 200;
```
**Salida** 📌

   | productID | name | type | amount | price | detail | supplierID |
| --------- | --------- | --------- | ------- | --------- | --------- | --------- |
| 6 | Gaming Laptop | Electronics | 10 | 1299.99 | High-performance gaming laptop | 1 |

4. Pedidos ordenados por fecha: *Muestra todos los pedidos ordenados desde el más reciente al más antiguo*.
   
**Solución** ✅

  ```sql
   select * from customer
   order by date desc;
```

**Salida** 📌

   | orderID | customerID | date | total | paymentMethod | status |
| --------- | --------- | --------- | ------- | --------- | --------- |
| 5 | 5 | 2024-01-19 | 234.74 | Credit Card | Delivered |
| 4 | 4 | 2024-01-18 | 47.25 | Bank Transfer | Pending |
| 3 | 3 | 2024-01-17 | 62.48 | Credit Card | Shipped |
| 2 | 2 | 2024-01-16 | 199.99 | PayPal | Processing |
| 1 | 1 | 2024-01-15 | 145.97 | Credit Card | Delivered |
   
5. Primeros 5 proveedores: *Obtén los primeros 5 proveedores ordenados alfabéticamente por nombre*.
   
**Solución** ✅

   ```sql
   select * from supplier
   order by name asc limit 5;
```

**Salida** 📌

   | supplierID | name | phone | date | email | addressID |
| --------- | --------- | --------- | ------- | --------- |
| 3 | Global Distributors | 555-0203 | info@globaldist.com | 3 | 
| 2 | Office Solutions Co. | 555-0202 | contact@officesolutions.com | 2 |
| 5 | Prime Suppliers | 555-0205 | support@primesuppliers.com | 5 |
| 4 | Quality Goods Ltd. | 555-0204 | orders@qualitygoods.com | 4 |
| 1 | TechSupplies Inc. | 555-0201 | sales@techsupplies.com | 1 |
				
6. Clientes y su ciudad: *Muestra el nombre del cliente y la ciudad donde vive*.
   
**Solución** ✅

   ```sql
   select * from address where city = 'Madrid';
```
**Salida** 📌

   TODO listado de atributos y tuplas

7. Productos y su proveedor: *Lista el nombre del producto y el nombre de su proveedor*.
   
**Solución** ✅

   ```sql
   select * from address where city = 'Madrid';
```

**Salida** 📌

   TODO listado de atributos y tuplas

8. Pedidos de un cliente específico: *Muestra todos los pedidos realizados por el cliente con customerID = 10*.
   
**Solución** ✅

   ```sql
   select * from address where city = 'Madrid';
```

**Salida** 📌

   TODO listado de atributos y tuplas

9. Cantidad de productos en cada pedido: *Muestra el ID del pedido y la cantidad de productos comprados en cada uno*.
   
**Solución** ✅

   ```sql
   select * from address where city = 'Madrid';
```

**Salida** 📌

   TODO listado de atributos y tuplas

10. Clientes con dirección de envío: *Lista los clientes que tienen una dirección de tipo Shipping*.
   
**Solución** ✅

   ```sql
   select * from address where city = 'Madrid';
``` 

**Salida** 📌

   TODO listado de atributos y tuplas


¿Qué practicas?
---------------
- SELECT básico
- Filtros WHRE
- Ordenamiento con ORDER BY
- Limitación de resultados son LIMIT
- JOIN simples
- Uso de claves foráneas (FK)

Llegamos al final 👌
