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
        emmail varchar(80) not null,
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
        emmail varchar(80) not null,
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
		foreign key(product) references product(productID));
		
insert into address (addressID, street, localy, city, postcode, state) values
		(1, '123 Main Street', 'Downtown', 'New York', '10001', 'New York'),
		(2, '456 Oak Avenue', 'Northside', 'Chicago', '60601', 'Illinois'),
		(3, '789 Pine Road', 'West End', 'Los Angeles', '90001', 'California'),
		(4, '321 Elm Street', 'South Park', 'Houston', '77001', 'Texas'),
		(5, '654 Maple Drive', 'East Hills', 'Miami', '33101', 'Florida');
		
insert into customer (customerID, name, phone, emmail, addressID) values
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

insert into customerAddress (customerAddresID, customerID, addressID, type, position) values
		(1, 1, 1, 'Home', 'Primary'),
		(2, 2, 2, 'Home', 'Primary'),
		(3, 3, 3, 'Home', 'Primary'),
		(4, 4, 4, 'Home', 'Primary'),
		(5, 5, 5, 'Home', 'Primary');	
		
insert into supplier (supplierID, name, phone, emmail, addressID) values
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
		(5, 'Coffee Mug', 'Kitchenware', 300, 12.75, 'Ceramic coffee mug', 5);
		
insert into customerOrder (orderID, customerID, date, total, paymentMethod, status) values
		(1, 1, '2024-01-15', 145.97, 'Credit Card', 'Delivered'),
		(2, 2, '2024-01-16', 199.99, 'PayPal', 'Processing'),
		(3, 3, '2024-01-17', 62.48, 'Credit Card', 'Shipped'),
		(4, 4, '2024-01-18', 47.25, 'Bank Transfer', 'Pending'),
		(5, 5, '2024-01-19', 234.74, 'Credit Card', 'Delivered');		