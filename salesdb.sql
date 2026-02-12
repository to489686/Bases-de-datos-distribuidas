create database SALES;
use SALES;
create table address(addressID int not null,
		street varchar(80) not null,
        localy varchar(80) not null,
        city varchar(80) not null,
        postcode varchar(5)not null,
        state varchar(80) not null,
        primary key(addressID)
        );
       
create table customer(customerID int not null,
		name varchar(80) not null,
        phone varchar(15) not null,
        email varchar(80) not null,
        addressID int not null,
        primary key(customerID),
        foreign key(addressID) references address(addressID));
       
create table customerAddress(customerAddresID int not null,
		customerID int not null,
        addressID int not null,
        type varchar(80) not null,
        position varchar(80) not null,
        primary key(customerAddresID),
        foreign key(customerID) references customer(customerID),
        foreign key(addressID) references address(addressID));
       
create table supplier(supplierID int not null,
		name varchar(80) not null,
        phone varchar(15) not null,
        email varchar(80) not null,
        addressID int not null,
        primary key(supplierID),
        foreign key(addressID) references address(addressID));
       
create table product(productID int not null,
		name varchar(80) not null,
		type varchar(80) not null,
		amount int not null,
        price float not null,
        detail varchar(80) not null,
        supplierID int not null,
        primary key(productID),
        foreign key(supplierID) references supplier(supplierID));
       
create table customerOrder(orderID int not null,
		customerID int not null,
        date date not null,
        total float not null,
        paymentMethod  varchar(80) not null,
        status  varchar(80) not null,
		primary key(orderID),
        foreign key(customerID) references customer(customerID));
		
create table orderProduct(orderProductId int not null,
		orderID int not null,
		productID int not null,
		quanty int not null,
		price float not null,
		primary key (orderProductId),
		foreign key(orderID) references customerOrder(orderID),
		foreign key(productID) references product(productID));
		
insert into address (addressID, street, localy, city, postcode, state) values
		(1, '123 Main Street', 'Downtown', 'New York', '10001', 'New York'),
		(2, '456 Oak Avenue', 'Northside', 'Chicago', '60601', 'Illinois'),
		(3, '789 Pine Road', 'West End', 'Los Angeles', '90001', 'California'),
		(4, '321 Elm Street', 'South Park', 'Houston', '77001', 'Texas'),
		(5, '654 Maple Drive', 'East Hills', 'Miami', '33101', 'Florida'),
		(6, 'Calle Gran Vía 45', 'Centro', 'Madrid', '28013', 'Madrid');
		
insert into customer (customerID, name, phone, email, addressID) values
		(1, 'John Smith', '555-0101', 'john.smith@email.com', 1),
		(2, 'Maria Garcia', '555-0102', 'maria.garcia@email.com', 2),
		(3, 'David Johnson', '555-0103', 'david.johnson@email.com', 3),
		(4, 'Sarah Williams', '555-0104', 'sarah.williams@email.com', 4),
		(5, 'Robert Brown', '555-0105', 'robert.brown@email.com', 5);
		
insert into customerAddress (customerAddresID, customerID, addressID, type, position) values
		(1, 1, 1, 'Home', 'Primary'),
		(2, 2, 2, 'Home', 'Primary'),
		(3, 3, 3, 'Home', 'Primary'),
		(4, 4, 4, 'Home', 'Primary'),
		(5, 5, 5, 'Home', 'Primary');	

insert into supplier (supplierID, name, phone, email, addressID) values
		(1, 'TechSupplies Inc.', '555-0201', 'sales@techsupplies.com', 1),
		(2, 'Office Solutions Co.', '555-0202', 'contact@officesolutions.com', 2),
		(3, 'Global Distributors', '555-0203', 'info@globaldist.com', 3),
		(4, 'Quality Goods Ltd.', '555-0204', 'orders@qualitygoods.com', 4),
		(5, 'Prime Suppliers', '555-0205', 'support@primesuppliers.com', 5);
		
insert into product (productID, name, type, amount, price, detail, supplierID) values
		(1, 'Wireless Mouse', 'Electronics', 100, 25.99, 'Ergonomic wireless mouse', 1),
		(2, 'Office Chair', 'Furniture', 50, 199.99, 'Executive office chair', 2),
		(3, 'Notebook', 'Stationery', 500, 4.99, 'Hardcover notebook', 3),
		(4, 'Desk Lamp', 'Lighting', 75, 34.50, 'LED desk lamp', 4),
		(5, 'Coffee Mug', 'Kitchenware', 300, 12.75, 'Ceramic coffee mug', 5),
		(6, 'Gaming Laptop', 'Electronics', 10, 1299.99, 'High-performance gaming laptop', 1);
		
insert into customerOrder (orderID, customerID, date, total, paymentMethod, status) values
		(1, 1, '2024-01-15', 145.97, 'Credit Card', 'Delivered'),
		(2, 2, '2024-01-16', 199.99, 'PayPal', 'Processing'),
		(3, 3, '2024-01-17', 62.48, 'Credit Card', 'Shipped'),
		(4, 4, '2024-01-18', 47.25, 'Bank Transfer', 'Pending'),
		(5, 5, '2024-01-19', 234.74, 'Credit Card', 'Delivered');		
		
insert into orderProduct (orderProductId, orderID, productID, quanty, price) values
		(1, 1, 1, 2, 25.99),
		(2, 1, 3, 3, 4.99),
		(3, 2, 2, 1, 199.99),
		(4, 3, 4, 1, 34.50),
		(5, 3, 5, 2, 12.75);

-- 1. Listar todos los clientes: *Obtén el customerID, name y email de todos los customer
select customerID, name, email from customer;

-- 2. Direcciones en una ciudad específica: *Muestra todas las direcciones que estén en la ciudad de Madrid
select * from address where city = 'Madrid';

-- 3. Productos con precio mayor a 200: *Lista los productos cuyo precio sea mayor a 200
select * from product where price > 200;
-- 4. Pedidos ordenados por fecha: *Muestra todos los pedidos ordenados desde el más reciente al más antiguo
select * from customerOrder 
order by date desc;
-- 5. Primeros 5 proveedores: *Obtén los primeros 5 proveedores ordenados alfabéticamente por nombre
select * from supplier
order by name asc limit 5;
-- 6. Clientes y su ciudad: *Muestra el nombre del cliente y la ciudad donde vive
select c.name as customer, a.city as city
from customer c
join address a on c.addressID = a.addressID;

-- 7. Productos y su proveedor: *Lista el nombre del producto y el nombre de su proveedor
select p.name as product, s.name as supplier
from product p
join supplier s on p.supplierID = s.supplierID

-- 8. Pedidos de un cliente específico: *Muestra todos los pedidos realizados por el cliente con customerID = 10
select * from customerOrder 
where customerID = 10;

-- 9. Cantidad de productos en cada pedido: *Muestra el ID del pedido y la cantidad de productos comprados en cada uno
select 
    orderid,
    count(productid) as productCount,
    sum(quanty) as totalQuanty
from orderProduct
group by orderId;

-- 10. Clientes con dirección de envío: *Lista los clientes que tienen una dirección de tipo Shipping

-- Bloque 4. Consultas SQL nivel intermediO--------------------------------------------------------------------------
--1. *Total de pedidos por cliente*. Muestra el nombre del cliente y la cantidad total de pedidos que ha realizado.
select 
    c.name as customer_name,
    count(co.orderid) as total_orders
from customer c
left join customerorder co on c.customerid = co.customerid
group by c.customerid, c.name
order by total_orders desc;

--2. *Total gastado por cliente*. Obtén el nombre del cliente y el importe total gastado en todos sus pedidos.
select 
    c.name as customer_name,
    sum(co.total) as total_amount
from customer c
join customerorder co on c.customerid = co.customerid
group by c.customerid, c.name
order by total_amount desc;
--3. *Productos más caros por proveedor*. Muestra el proveedor y el precio máximo de los productos que suministra.
select 
    s.name as supplier_name,
    round(max(p.price), 2) as max_price
from supplier s
join product p on s.supplierid = p.supplierid
group by s.supplierid, s.name
order by max_price desc;

--4. *Pedidos con más de 3 productos*. Lista los pedidos cuyo total de unidades compradas sea mayor a 3.
select 
    orderid,
    sum(quanty) as total_units
from orderproduct
group by orderid
having sum(quanty) > 3
order by total_units desc;

--5. *Ventas totales por producto*. Muestra el nombre del producto y el total de unidades vendidas.
select 
    p.name as product_name,
    coalesce(sum(op.quanty), 0) as total_units_sold
from product p
left join orderproduct op on p.productid = op.productid
group by p.productid, p.name
order by total_units_sold desc;

--6. *Clientes que han gastado más de $1,000.00*. Lista los clientes cuyo gasto total sea mayor a 1000.
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

--7. *Promedio de precio por tipo de producto*. Obtén el precio promedio de los productos por cada tipo.
select 
    p.type as product_type,
    round(avg(p.price), 2) as average_price,
    count(p.productid) as total_products
from product p
group by p.type
order by average_price desc;

--8. *Proveedores con más de 5 productos*. Muestra los proveedores que suministran más de 5 productos.
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

--9. *Pedidos con información del cliente*. Muestra el ID del pedido, la fecha y el nombre del cliente.
select 
    co.orderid as orderId,
    co.date as orderDate,
    c.name as customerName
from customerorder co
join customer c on co.customerid = c.customerid
order by co.date desc;

--10. *Clientes sin pedidos*. Lista los clientes que no han realizado ningún pedido.
insert into customer values 
(6, 'lisa martinez', '555-0106', 'lisa.martinez@email.com', 1);

select 
    c.name as customerName,
    c.phone,
    c.email as email
from customer c
left join customerorder co on c.customerid = co.customerid
where co.orderid is null
order by c.name;

--Bloque 4. Consultas SQL tipo examen
--🧠 *RETO 1: Cliente con mayor gasto total*. Obtén el cliente que más dinero ha gastado en pedidos. Muestra su nombre y el total gastado.
-- Forma simple
select 
    c.name as customerName,
    round(sum(co.total), 2) as totalAmount
	from customer c
	join customerorder co on c.customerId = co.customerId
	group by c.customerId, c.name
	order by totalAmount desc
	limit 1;

-- Si se existieran dos o mas clientes empatados 
select 
    c.name as customerName,
    round(sum(co.total), 2) as totalAmount
	from customer c
	join customerorder co on c.customerId = co.customerId
	group by c.customerid, c.name
	having sum(co.total) = (
    select max(customerTotal)
    from (
        select sum(total) as customerTotal
        	from customerOrder
       		group by customerId
    ) as totals
	);

--2. 🧠 *RETO 2: Producto más vendido (en unidades)*. Identifica el producto más vendido considerando la cantidad total de unidades vendidas.
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





