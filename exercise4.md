# Bloque 4. *Consultas SQL nivel intermedio*
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
1. *Total de pedidos por cliente*. Muestra el nombre del cliente y la cantidad total de pedidos que ha realizado.

   
**Solución** ✅

   ```sql
   select 
    c.name as customer_name,
    count(co.orderid) as total_orders
from customer c
left join customerorder co on c.customerid = co.customerid
group by c.customerid, c.name
order by total_orders desc;
```

**Salida** 📌
|customer_name | total_orders |
| --------- | --------- |
| John Smith | 1 |
| Maria Garcia | 1 |
| David Johnson | 1 |
| Sarah Williams | 1 |
| Robert Brown | 1 |
   
2. *Total gastado por cliente*. Obtén el nombre del cliente y el importe total gastado en todos sus pedidos.
   
**Solución** ✅

   ```sql
  select 
    c.name as customer_name,
    round(sum(co.total), 2) as total_spent
from customer c
join customerorder co on c.customerid = co.customerid
group by c.customerid, c.name
order by total_spent desc;
```
**Salida** 📌

|customer_name | total_amount |
| --------- | --------- |
|Robert Brown	|234.74|
|Maria Garcia	|199.99|
|John Smith	|145.97|
|David Johnson	|62.48|
|Sarah Williams	|47.25|
   
3. *Productos más caros por proveedor*. Muestra el proveedor y el precio máximo de los productos que suministra.
   
**Solución** ✅

   ```sql
  select 
    s.name as supplier_name,
    round(max(p.price), 2) as max_price
from supplier s
join product p on s.supplierid = p.supplierid
group by s.supplierid, s.name
order by max_price desc;
```

**Salida** 📌

|supplier_name | max_price |
| --------- | --------- |
|TechSupplies Inc.	|1299.99|
|Office Solutions Co.|	199.99|
|Quality Goods Ltd.	|34.5|
|Prime Suppliers	|12.75|
|Global Distributors	|4.99|

4. *Pedidos con más de 3 productos*. Lista los pedidos cuyo total de unidades compradas sea mayor a 3.
   
**Solución** ✅

   ```sql
select 
    orderid,
    sum(quanty) as total_units
from orderproduct
group by orderid
having sum(quanty) > 3
order by total_units desc;
```

**Salida** 📌

   |orderid	|total_units|
   | --------- | --------- |
   |1	|5|
   
5. *Ventas totales por producto*. Muestra el nombre del producto y el total de unidades vendidas.
   
**Solución** ✅

   ```sql
select 
    p.name as product_name,
    coalesce(sum(op.quanty), 0) as total_units_sold
from product p
left join orderproduct op on p.productid = op.productid
group by p.productid, p.name
order by total_units_sold desc;
   ```

**Salida** 📌

|product_name|total_units_sold|
| --------- | --------- |
|Notebook	|3|
|Wireless Mouse	|2|
|Coffee Mug	|2|
|Office Chair	|1|
|Desk Lamp	|1|
|Gaming Laptop	|0|
6. *Clientes que han gastado más de $1,000.00*. Lista los clientes cuyo gasto total sea mayor a 1000.
   
**Solución** ✅

   ```sql
insert into customerorder values 
(6, 5, '2024-02-15', 850.50, 'credit card', 'delivered');
select 
    c.name as customer_name,
    round(sum(co.total), 2) as total_amount
from customer c
join customerorder co on c.customerid = co.customerid
group by c.customerid, c.name
having sum(co.total) > 1000
order by total_amount desc;
```

**Salida** 📌

   |customer_name|total_amount|
   | --------- | --------- |
   |Robert Brown	|1085.24|

7. *Promedio de precio por tipo de producto*. Obtén el precio promedio de los productos por cada tipo.
   
**Solución** ✅

   ```sql
select 
    p.type as product_type,
    round(avg(p.price), 2) as average_price,
    count(p.productid) as total_products
from product p
group by p.type
order by average_price desc;
   ```

**Salida** 📌

|product_type|average_price|total_products|
| --------- | --------- |--------- |
|Electronics	|662.99	|2|
|Furniture	|199.99	|1|
|Lighting	|34.5	|1|
|Kitchenware	|12.75	|1|
|Stationery	|4.99	|1|

8. *Proveedores con más de 5 productos*. Muestra los proveedores que suministran más de 5 productos.

   
**Solución** ✅

   ```sql
insert into product values 
(8, 'wireless keyboard', 'electronics', 50, 89.99, 'bluetooth keyboard', 1),
(9, 'hdmi cable', 'electronics', 200, 15.99, '6ft hdmi cable', 1),
(10, 'usb hub', 'electronics', 150, 29.99, '4-port usb hub', 1),
(11, 'laptop stand', 'accessories', 75, 45.99, 'adjustable laptop stand', 1),
(12, 'mouse pad', 'accessories', 300, 12.99, 'gaming mouse pad', 1);

select 
    s.name as supplier_name,
    count(p.productid) as total_products
from supplier s
join product p on s.supplierid = p.supplierid
group by s.supplierid, s.name
having count(p.productid) > 5
order by total_products desc;
   ```

**Salida** 📌

   |supplier_name|total_products|
   | --------- | --------- |
   |TechSupplies Inc.|	7|

9. *Pedidos con información del cliente*. Muestra el ID del pedido, la fecha y el nombre del cliente.
   
**Solución** ✅

   ```sql
select 
    co.orderid as order_id,
    co.date as order_date,
    c.name as customer_name
from customerorder co
join customer c on co.customerid = c.customerid
order by co.date desc;
   ```

**Salida** 📌

|orderId|orderDate|customerName|
| --------- | --------- |--------- |
|6	2024-02-15	|Robert Brown|
|5	2024-01-19	|Robert Brown|
|4	2024-01-18	|Sarah Williams|
|3	2024-01-17	|David Johnson|
|2	2024-01-16	|Maria Garcia|
|1	2024-01-15	|John Smith|

10. *Clientes sin pedidos*. Lista los clientes que no han realizado ningún pedido.

**Solución** ✅

   ```sql
insert into customer values 
(6, 'lisa martinez', '555-0106', 'lisa.martinez@email.com', 1);

select 
    c.name as customer_name,
    c.phone,
    c.email as email
from customer c
left join customerorder co on c.customerid = co.customerid
where co.orderid is null
order by c.name;
   ```

**Salida** 📌

   |customer_name|phone|email|
| --------- | --------- |--------- |
  | lisa martinez	|555-0106	|lisa.martinez@email.com|


📘 Qué se refuerza en nivel intermedio

✔ Agregaciones (SUM, COUNT, AVG, MAX)

✔ Agrupación de datos

✔ Filtros con HAVING

✔ JOIN entre múltiples tablas

✔ Análisis de datos reales

Llegaste al final 🚀



