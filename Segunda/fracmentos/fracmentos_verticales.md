# Distribución de datos

## Fragmentación Vertical en MySQL 8.0

------------------------------------------------------------------------

## Introducción

En esta práctica se implementa fragmentación vertical de una base de
datos utilizando MySQL 8.0.

La fragmentación vertical consiste en dividir una base de datos en
varios fragmentos según las entidades o grupos de atributos
relacionados, manteniendo la integridad referencial entre las tablas.

Para esta práctica se utiliza la base de datos **salesDB**, a partir de
la cual se generan dos fragmentos:

-   **customerDB** → contiene información relacionada con clientes y
    pedidos\
-   **supplierDB** → contiene información relacionada con proveedores y
    productos

El objetivo es separar la información por dominios funcionales,
facilitando la distribución y administración de los datos.

------------------------------------------------------------------------

# 1 Restauración de la base de datos

Primero se debe restaurar la base de datos salesDB en MySQL.

### Iniciar sesión en MySQL

``` bash
mysql -u root -p
```

### Crear la base de datos

``` sql
CREATE DATABASE salesDB;
```

### Restaurar el respaldo

Salir de MySQL y ejecutar:

``` bash
mysql -u root -p salesDB < salesBD_bk.sql
```

------------------------------------------------------------------------

# 2 Verificación de la base de datos

Para verificar que la restauración fue correcta se ejecuta el siguiente
script que muestra estadísticas de las tablas.

``` sql
SELECT  t.TABLE_NAME AS Tabla,
        t.TABLE_ROWS AS Registros,
        t.AVG_ROW_LENGTH AS TamañoFila,
        ROUND(t.DATA_LENGTH/1024/1024,2) AS DatosMB,
        ROUND(t.INDEX_LENGTH/1024/1024,2) AS IndicesMB,
        ROUND((t.DATA_LENGTH+t.INDEX_LENGTH)/1024/1024,2) AS TotalMB
FROM information_schema.TABLES t
WHERE t.TABLE_SCHEMA = DATABASE()
AND t.TABLE_TYPE='BASE TABLE'
ORDER BY t.TABLE_ROWS DESC;
```

Este script permite conocer:

-   número de registros por tabla\
-   tamaño promedio de filas\
-   tamaño ocupado por datos e índices

------------------------------------------------------------------------

# 3 Modelo relacional original

``` mermaid
erDiagram

customer {
int customerID PK
string name
string phone
string email
}

address {
int addressID PK
string street
string localy
string city
string postcode
string state
}

customeraddress {
int customerAddressID PK
int customerID FK
int addressID FK
string type
int position
}

customerorder {
int orderID PK
int customerID FK
date date
decimal total
string paymentMethod
string status
}

product {
int productID PK
int supplierID FK
string name
string description
decimal price
int stock
}

orderproduct {
int orderProductID PK
int orderID FK
int productID FK
int quantity
decimal unitPrice
}

supplier {
int supplierID PK
string name
string phone
string email
int addressID FK
}
```

------------------------------------------------------------------------

# 4 Fragmentación vertical

La fragmentación vertical divide la base de datos en dos bases
independientes:

-   customerDB\
-   supplierDB

------------------------------------------------------------------------

# 5 Fragmento vertical: customerDB

Este fragmento contiene toda la información relacionada con clientes y
pedidos.

## Creación de la base de datos

``` sql
CREATE DATABASE customerDB;
USE customerDB;
```

## Creación de tablas

``` sql
CREATE TABLE address (
addressID INT NOT NULL AUTO_INCREMENT,
street VARCHAR(100),
localy VARCHAR(50),
city VARCHAR(50),
postcode VARCHAR(10),
state VARCHAR(50),
PRIMARY KEY (addressID)
);

CREATE TABLE customer (
customerID INT NOT NULL AUTO_INCREMENT,
name VARCHAR(100),
phone VARCHAR(20),
email VARCHAR(100),
PRIMARY KEY (customerID)
);

CREATE TABLE customeraddress (
customerAddressID INT NOT NULL AUTO_INCREMENT,
customerID INT,
addressID INT,
type VARCHAR(50),
position INT,
PRIMARY KEY (customerAddressID),
FOREIGN KEY (customerID) REFERENCES customer(customerID),
FOREIGN KEY (addressID) REFERENCES address(addressID)
);
```

------------------------------------------------------------------------

# 6 Exportación de datos

``` sql
SELECT customerID,
       name,
       phone,
       email
FROM customer
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customer.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
```

------------------------------------------------------------------------

# 7 Carga de datos

``` sql
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customer.csv'
INTO TABLE customer
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(customerID,name,phone,email);
```

------------------------------------------------------------------------

# 8 Fragmento vertical: supplierDB

Este fragmento contiene la información relacionada con proveedores y
productos.

## Creación de base de datos

``` sql
CREATE DATABASE supplierDB;
USE supplierDB;
```

## Creación de tablas

``` sql
CREATE TABLE address (
addressID INT NOT NULL AUTO_INCREMENT,
street VARCHAR(100),
localy VARCHAR(50),
city VARCHAR(50),
postcode VARCHAR(10),
state VARCHAR(50),
PRIMARY KEY (addressID)
);

CREATE TABLE supplier (
supplierID INT NOT NULL AUTO_INCREMENT,
name VARCHAR(100),
phone VARCHAR(20),
email VARCHAR(100),
addressID INT,
PRIMARY KEY (supplierID),
FOREIGN KEY (addressID) REFERENCES address(addressID)
);

CREATE TABLE product (
productID INT NOT NULL AUTO_INCREMENT,
name VARCHAR(100),
type VARCHAR(50),
amount INT,
price DECIMAL(10,2),
detail TEXT,
supplierID INT,
PRIMARY KEY (productID),
FOREIGN KEY (supplierID) REFERENCES supplier(supplierID)
);
```

------------------------------------------------------------------------

# 9 Conclusión

La fragmentación vertical permite dividir una base de datos en
subconjuntos lógicos de tablas, manteniendo la integridad referencial.

En esta práctica se logró:

-   dividir la base salesDB en dos fragmentos
-   crear las bases customerDB y supplierDB
-   exportar datos usando CSV
-   importar datos usando LOAD DATA INFILE

Este proceso es fundamental en bases de datos distribuidas, donde
diferentes partes de la información pueden almacenarse en servidores
distintos.
