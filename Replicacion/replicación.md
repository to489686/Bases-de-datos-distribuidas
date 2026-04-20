# *Replicación de BD*
_______________________________

📌 Replicación de una base de datos en MySQL 8.0

**Instruccion**. Para este ejercicio se realizo una creación de una base de datos, de la cual se realizo este ejercicio.
Se obtuvo informacion del [*Sitio Oficial de MySQL*](https://dev.mysql.com/doc/refman/8.0/en/replication-configuration.html) 
para la construción de la replicación.

La informacion para la *BD* se obtuvo mediante una explicación/plática que se tuvo con
el docente simulando un caso real de una consulta para la realización de un *SGDB* donde tomó el rol de un cliente explicando su caso, mientras que nosotros eramos el experto obteniendo información mediante preguntaspara poder interpretar lo que el necesita.

![Representación Visual la Idea del Cliente](Ejemplo.png)

Se siguió esta representación para poder realizar todo lo pertinente para la práctica.



# *Replicación*
_______________________________
1. Una vez analizado e interpretados los *datos*, procedemos a listar los datos para poder realizar un *modelo ER*

   **Modelo ER (MER)**
   
   ```mermaid
   erDiagram
    Equipo {
        int id_equipo PK
        string nombre_equipo
        int id_coach FK
        int id_cocoach FK
        int id_suplente FK
    }

    Concursante {
        int id_concursante PK
        string nombre
        string a_paterno
        string a_materno
        string correo
        date fecha_inicio_estudios
        date fecha_fin_estudios
        int edad
        int id_equipo FK
    }

    Coach {
        int id_coach PK
        string nombre
        string a_paterno
        string a_materno
        string correo
        int id_equipo FK
    }

    Competencia {
        int id_competencia PK
        string tipo
        date fecha
    }

    Problema {
        int id_problema PK
        string nombre
        string descripcion
        string teoria
        int id_competencia FK
    }

    Ranking {
        int id_rank PK
        int posicion
        int puntaje_fecha
        int id_equipo FK
        int id_competencia FK
    }

    Equipo ||--o{ Concursante : "tiene"
    Equipo ||--o{ Coach : "dirigido por"
    Equipo ||--o{ Ranking : "participa en"
    Competencia ||--o{ Problema : "incluye"
    Competencia ||--o{ Ranking : "genera"
   ```

2. Una vez teniendo el modelo así, podemos empezar a modelar la *BD* de manera más comoda, entendiendo las relaciones que pueden tener cada una de las entidades en la base de datos.

_______________________________
Nota. Para comodida visual, se trabajo en la versión 8.0 de MySQL Workbench, aclarando algunos puntos:
  -Todo se trabajara mediante sentencias SQL de MySQL (se adjuntaran al reporte).
  -Las creaciones y conexión de las bases de datos son de la forma antes mencionada.
Para esto, también es importante mencionar que se tuvo que tener un poco de conocimiento básico de *Redes* para poder configurar algunas IP`s, ya que la conexión para la *Replicación* se hará mediante un host como Red.
_______________________________

# *Creación de BD*

1. Con el modelo, procedemos a nuestro *MySQL*, en el cual por instancia local tendremos que ingresar la contraseña que se configuro al momento de la instalación.

2. Una vez dentro, procedemos a crear nuestra *base de datos*.
   ```sql
   mysql> CREATE DATABASE ICPC_Mexico;
   ```
   
3. Usamos la *base de datos* ya creada.
   ```sql
   mysql> USE ICPC_Mexico;
   ```

4. Ya en la *base de datos*, ingresamos las sentencias *SQL* para crear las tablas.
   ```sql
       mysql>
             CREATE TABLE Equipo (
             id_equipo	   	INT 	       NOT NULL AUTO_INCREMENT,
             nombre_equipo 	VARCHAR(100) NOT NULL,
             id_coach 		  INT 	       NOT NULL,
             id_cocoach 		INT          NOT NULL,
             id_suplente 	  INT          NOT NULL,
             PRIMARY KEY		(id_equipo)
              );

            CREATE TABLE Concursante (
            id_concursante		      INT 	       NOT NULL AUTO_INCREMENT,
            nombre			            VARCHAR(100) NOT NULL,
            a_paterno		           	VARCHAR(100) NOT NULL,
            a_materno			          VARCHAR(100)     NULL,
            correo 			            VARCHAR(100) NOT NULL,
            fecha_inicio_estudios 	DATE 	     NOT NULL,
            fecha_fin_estudios 		  DATE 	     NOT NULL,
            edad 		              	INT 	     NOT NULL,
            id_equipo	 		          INT 	     NOT NULL,
            PRIMARY KEY(id_concursante),
            FOREIGN KEY(id_equipo) REFERENCES Equipo(id_equipo)
            );


            CREATE TABLE Coach (
            id_coach		  INT 	       NOT NULL AUTO_INCREMENT,
            nombre		    VARCHAR(100) NOT NULL,
            a_paterno		  VARCHAR(100) NOT NULL,
            a_materno	   	VARCHAR(100) 	   NULL,
            correo 		    VARCHAR(100) NOT NULL,
            id_equipo	 	  INT 	       NOT NULL,
            PRIMARY KEY(id_coach),
            FOREIGN KEY(id_equipo) REFERENCES Equipo(id_equipo)
            );


            CREATE TABLE Competencia (
            id_competencia 	    INT 	      NOT NULL AUTO_INCREMENT,
            tipo 		            VARCHAR(50) NOT NULL,
            fecha 		          DATE   	    NOT NULL,
            PRIMARY KEY(id_competencia)
            );


            CREATE TABLE Problema (
            id_problema 	      INT         NOT NULL AUTO_INCREMENT,
            nombre 		          CHAR(1),
            descripcion 	      TEXT        NOT NULL,
            id_competencia 	    INT         NOT NULL,
            PRIMARY KEY(id_problema),
            FOREIGN KEY(id_competencia) REFERENCES Competencia(id_competencia)
            );


            CREATE TABLE Ranking (
            id_rank 			    INT NOT NULL AUTO_INCREMENT,
            posicion 			    INT NOT NULL,
            puntaje_fecha 		INT NOT NULL,
            id_equipo	 	    	INT NOT NULL,
            id_competencia 		INT NOT NULL,
            PRIMARY KEY(id_rank),
            FOREIGN KEY(id_equipo) REFERENCES Equipo(id_equipo)
            FOREIGN KEY(id_competencia) REFERENCES Competencia(id_competencia)
            );

   ```

5. Con las tablas ya en nuestra *base de datos*, podemos proceder a poblarla.
   ```sql
       mysql>
              INSERT INTO Equipo (id_equipo, nombre_equipo, id_coach, id_cocoach, id_suplente)
              VALUES (1, 'Equipo Alfa', 1, 2, 4),
              (2, 'Equipo Beta', 3, 2, 5);

              INSERT INTO Concursante (id_concursante, nombre, a_paterno, a_materno, correo, fecha_inicio_estudios, fecha_fin_estudios, edad, id_equipo)
              VALUES (1, 'Carlos', 'Ruiz', 'Gómez', 'carlos@uni.mx', '2022-08-01', '2026-06-30', 22, 1),
              (2, 'Sofía', 'Martínez', 'López', 'sofia@uni.mx', '2021-08-01', '2025-06-30', 23, 2);

              INSERT INTO Coach (id_coach, nombre, a_paterno, a_materno, correo, id_equipo)
              VALUES (1, 'Juan', 'Pérez', 'Ramírez', 'juan@uni.mx', 1),
              (3, 'Luis', 'Hernández', 'Torres', 'luis@uni.mx', 2);

              INSERT INTO Competencia (id_competencia, tipo, fecha)
              VALUES (1, 'Clasificatoria 1', '2026-05-10'),
              (2, 'Repechaje', '2026-09-15');

              INSERT INTO Problema (id_problema, nombre, descripcion, id_competencia)
              VALUES (1, 'A', 'Algoritmos de grafos - BFS/DFS', 1),
              (2, 'B', 'Programación dinámica - DP', 1);

              INSERT INTO Ranking (id_rank, posicion, puntaje_fecha, id_equipo, id_competencia)
              VALUES (1, 1, 280, 1, 1),
              (2, 2, 200, 2, 1);
   
   ```

# *Conexión de los dispositivos*
_______________________________
1. Para hacer la conexión, se hará de manera inalámbrica mediante una red. En uno de los dispositivo se habilita la opcion de *Zona inalámbrica* en la cual se conectaran los dispositivos necesarios. A la cual se le configurara una dirección *IP* para poder realizar la conxión.


2. Posteriormente, con la configuración realizada podemos conectar los dispositivos mediante la *Red* a la computadora que funcionara como router.


3. Para poder hacer la conexión mediante sentencias, es necesario modificar un archivo de *MySQL*, ubicado en la carpeta *Program Data* (puede que no sea visible, pero dando click derecho/ver archivos oculto es posible visualizar) llamado *my.ini* en el cual se modificaran algunas partes de dicho archivo para así poder realizar lo que necesitamos.
Este podría ser un ejemplo de ruta para dicha carpeta:
```
    C:\ProgramData\MySQL\MySQL Server 8.0
```
Las modificaciones serán:
  *Computadora Principal*
  Se agregaran tres lineas en el apartado de *SERVER SECTION* que permitaran la conexión para la replicación de la base de datos.
  -La primera línea permite la conexion al momento del inicio de sesión junto con la tercer linea.
  -La segunda linea es sobre que base de datos se trabajara.
```
    log-bin-mysql-bin
    binlog-do-db-ICPC_Mexico
    sync-binlog=1
```
  Y sobre el mismo apartado *SERVER SECTION*, bajamos un poco y encontraremos una sección llamada *Group Replication Related*, donde en su ultima linea la deshabilitaremos usando un *#*.
  Ejemplo:
  ```
    # ***** Group Replication Related *****
    # Specifies the base name to use for binary log files. With binary logging
    # enabled, the server logs all statements that change data to the binary
    # log, which is used for backup and replication.
    #log-bin="XZYLAS-bin" //se agrego el #
  ```
  En la sección que se encuentra debajo de la anterior mencionada llamada *Group Replication Related*, en su ultima linea se dejara igual para el caso de ser la computadora *servidor*.
  Ejemplo:
  ```
    # ***** Group Replication Related *****
    # Specifies the server ID. For servers that are used in a replication topology,
    # you must specify a unique server ID for each replication server, in the
    # range from 1 to 2^32 − 1. "Unique" means that each ID must be different
    # from every other ID in use by any other source or replica.
    server-id=1
  ```
  Para el caso de la segunda computadora se se asignara como número *2*, es decir:
```
    # ***** Group Replication Related *****
    # Specifies the server ID. For servers that are used in a replication topology,
    # you must specify a unique server ID for each replication server, in the
    # range from 1 to 2^32 − 1. "Unique" means that each ID must be different
    # from every other ID in use by any other source or replica.
    server-id=2
  ```
*Computadora Secundaria*
  Para esta computadora solo se haran dos modificaciónes:
  -En el apartado de *SERVER SECTION* solo se agregara una línea al inicio de este.
  ```
  # 
    [mysqld]
    log-bin-mysql-bin
    # The next three options are mutually exclusive to SERVER_PORT below.
    # skip-networking
    # enable-named-pipe
    # shared-memory
  ```
  -La otra modificación es la anterior mencionada: Y sobre el mismo apartado *SERVER SECTION*, bajamos un poco y encontraremos una sección llamada *Group Replication Related*, donde en su ultima linea la deshabilitaremos usando un *#*.


Al finalizar estos cambios, guardamos, y en ambos dispositivos se hara el reinicio de los servivios de *MySQL* utilizando el comando:
 ```
    boton windows + r
  ```
Escribiendo el siguiente comando:
  ```
    services.msc
  ```
Buscando los servicios para proceder a hacer click derecho y presionar reiniciar.


# *Creación de usuario*
_______________________________

Ahora con lo anterior terminado, ahora lo unico faltante sería crear el usuario el cual tendrá el acceso a la base de datos del servidor.

En la terminal de *MySQL Workbench* se ejecuntan los siguientes comandos:
 -En la primera linea se declara la creación del usuario, junto con la dirección IP del segundo nodo, asi mismo, se declara la contraseña que se le dará a este usuario.
 -En la segunda linea se declaran los privilegios que este mismo tendrá.
 -Y por ultimo actualizamos los privilegios, donde se reporta el usuario y IP del servidor, con intencion de que funcionen de manera correcta.
  ```sql
    mysql>
     CREATE USER 'Usuario'@'192.168.100.102' INDENTIFIED WITH mysql_native_password       BY '123456789';
      GRANT ALL PRIVILEGES ON *.* TO 'Usuario'@'192.168.100.101' WITH GRAND OPTION;
      FLUSH PRIVILEGES;
  ```

Con todo esto, el usuario ya tendría el permiso y poder de acceder a la base de datos para poder realizar operaciones en ella.
