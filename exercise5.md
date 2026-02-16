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

   ```sql
-- Forma simple
select c.name as customerName,
    round(sum(co.total), 2) as totalAmount
from customer c
join customerorder co on c.customerid = co.customerid
group by c.customerid, c.name
order by totalAmount desc
limit 1;

-- Si se existieran dos o mas clientes empatados 
select c.name as customerName,
    round(sum(co.total), 2) as totalAmount
from customer c
join customerorder co on c.customerid = co.customerid
group by c.customerid, c.name
having sum(co.total) = (
    select max(customer_total)
    from (
        select sum(total) as customer_total
           from customerorder
           group by customerid
    ) as totals
);
   ```

**Salida** 📌

   | customerName | totalAmount |
   |--------|--------|
   |Robert Brown	|1085.24|
   
2. 🧠 *RETO 2: Producto más vendido (en unidades)*. Identifica el producto más vendido considerando la cantidad total de unidades vendidas.

   
**Solución** ✅

   ```sql
-- Forma simple
select  p.name as productName,
   sum(op.quanty) as totalUnitsSold
	from product p
	join orderproduct op on p.productId = op.productId
	group by p.productId, p.name
	order by totalUnitsSold desc
	limit 1;

-- Si se existieran dos o mas productos vendidos
select p.name as productName,
	sum(op.quanty) as totalUnitSold
    from product p
    join orderroduct op on p.productID = op.productID
    group by p.productID, p.name
    having sum(op.quanty) = (
		select max(productUnids)
        from ( select sum(quanty) as productUnids
			from orderproduct
            group by productID
            ) as totals
		);
   ```

**Salida** 📌

   | productName | totalUnitSold |
   |--------|--------|
   |Robert Brown	|1085.24|
   
3. 🧠 *RETO 3: Total de ventas por ciudad*. Muestra el total de ventas (importe) agrupado por ciudad del cliente.

   
**Solución** ✅

   ```sql
select a.city as customerCity,
    round(sum(co.total), 2) as totalSales
from customer c
join address a on c.addressId = a.addressId
join customerorder co on c.customerId = co.customerId
group by a.city
order by totalSales desc;
   ```

**Salida** 📌

| customerCity | totalSales |
|--------|--------|
|Miami	|1085.24|
|Chicago	|199.99|
|New York	|145.97|
|Los Angeles	|62.48|
|Houston|	47.25|

4. 🧠 *RETO 4: Clientes con más de una dirección*. Lista los clientes que tienen más de una dirección asociada.

   
**Solución** ✅

   ```sql
select c.name as customerName,
    count(ca.addressId) as numberOfAddresses
from customer c
join customeraddress ca on c.customerId = ca.customerId
group by c.customerId, c.name
having count(ca.addressId) > 1
order by numberOfAddresses desc;
   ```

**Salida** 📌

| customerName | numberOfAddresses |
|--------|--------|
|Maria Garcia |2|
   
5. 🧠 *RETO 5: Pedidos con total superior al promedio*. Obtén los pedidos cuyo total sea mayor al promedio de todos los pedidos.

   
**Solución** ✅

  ```sql
select orderId,
    customerId,
    date,
    round(total, 2) as orderTotal,
    status
from customerOrder
where total > (select avg(total) from customerOrder)
order by total desc;

  ```

**Salida** 📌

|orderId |customerId| date |orderTotal |status|
|--------|--------|--------|--------|--------|
|6|	5|	|2024-02-15|	850.5|	delivered|

6. 🧠 *RETO 6: Proveedor con más productos vendidos*. Identifica el proveedor cuyos productos se han vendido en mayor cantidad de unidades.

   
**Solución** ✅

   ```sql
-- Forma simple
select s.name as supplierName,
    sum(op.quanty) as totalUnitsSold
from supplier s
join product p on s.supplierId = p.supplierId
join orderProduct op on p.productId = op.productId
group by s.supplierId, s.name
order by totalUnitsSold desc
limit 1;
-- Si se existieran dos o mas proveedor empatados
select s.name as supplierName,
    sum(op.quanty) as totalUnitsSold
from supplier s
join product p on s.supplierId = p.supplierId
join orderProduct op on p.productId = op.productId
group by s.supplierId, s.name
having sum(op.quanty) = (
    select max(unitsSold)
    from (
        select sum(op2.quanty) as unitsSold
        from supplier s2
        join product p2 on s2.supplierId = p2.supplierId
        join orderProduct op2 on p2.productId = op2.productId
        group by s2.supplierId
    ) as supplierUnits
)
order by totalUnitsSold desc;
   ```

**Salida** 📌

| supplierName | totalUnitsSold |
|--------|--------|
|Global Distributors |3|   


7. 🧠 *RETO 7: Clientes que nunca cancelaron pedidos*. Lista los clientes que no tienen ningún pedido con estado 'Cancelled'.

   
**Solución** ✅

   ```sql
select c.name as customerName,
    count(co.orderId) as totalOrders,
    sum(case when co.status = 'cancelled' then 1 else 0 end) as cancelledOrders
from customer c
left join customerOrder co on c.customerId = co.customerId
group by c.customerId, c.name
having sum(case when co.status = 'cancelled' then 1 else 0 end) = 0
order by totalOrders desc;
   ```

**Salida** 📌

| customerName | totalOrders | cancelledOrders |
|--------|--------|--------|
|Robert Brown| 2 |0|
|John Smith| 1| 0|
|Maria Garcia| 1| 0|
|David Johnson| 1| 0|
|Sarah Williams| 1| 0|
|lisa martinez| 0 |0|

8. 🧠 *RETO 8: Ingreso total por método de pago*. Muestra el ingreso total generado por cada método de pago.

   
**Solución** ✅

   ```sql
select paymentmethod as paymentMethod,
    count(orderid) as totalOrders,
    round(sum(total), 2) as totalRevenue
from customerOrder
group by paymentMethod
order by totalRevenue desc;
   ```
**Salida** 📌

| paymentMethod | totalOrders | totalOrders |
|--------|--------|--------|
|Credit Card| 4	|1293.69|
|PayPal| 1 |199.99|
|Bank Transfer| 1 |47.25|

9. 🧠 *RETO 9: Pedidos con más de un producto distinto*. Lista los pedidos que incluyen más de un producto diferente.

   
**Solución** ✅

   ```sql
select orderId,
    count(distinct productId) as distinctProducts,
    sum(quanty) as totalUnits
from orderProduct
group by orderId
having count(distinct productId) > 1
order by distinctProducts desc, totalUnits desc;
   ```
**Salida** 📌

| orderId | distinctProducts | totalUnits |
|--------|--------|--------|
|1	|2	|5|
|3	|2	|3|

10. 🧠 *RETO 10: Clientes con pedidos en más de una ciudad*. Encuentra los clientes que hayan realizado pedidos desde direcciones en más de una ciudad.


**Solución** ✅

```sql
select c.name as customerName,
    count(distinct a.city) as numberOfCities,
    group_concat(distinct a.city order by a.city separator ', ') as cities
from customer c
join customerOrder co on c.customerId = co.customerId
join customerAddress ca on c.customerId = ca.customerId
join address a on ca.addressId = a.addressId
group by c.customerId, c.name
having count(distinct a.city) > 1
order by numberOfCities desc;
```

**Salida** 📌

| customerName | numberOfCities | cities |
|--------|--------|--------|
|Robert Brown	|2	|Miami, Orlando|		

📘 ¿Qué se refuerza?
✔ Lectura de esquemas
✔ Lógica de negocio
✔ Subconsultas
✔ Consultas tipo examen universitario / técnico

Dime qué quieres, cómo lo quieres y lo armamos 💪 🚀





