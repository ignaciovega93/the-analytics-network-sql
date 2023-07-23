-- Parte 1 - Organización de nuestro repo
/*El repositorio de git, que actualmente tenemos en Github, es el núcleo de nuestro 
código. Git nos permite trabajar colaborativamente y de tener versionados nuestros 
archivos, es decir tener guardado versiones anteriores, los cambios y la capacidad 
de recuperarlos

Todas las empresas, de una u otra manera, usan git. Por eso nosotros también vamos a 
armar nuestro repositorio.

Estructura de carpetas

Para organizar la estructura del Data Warehouse (DW) en el repositorio, vamos a crear 
una carpeta llamada retail-data-warehouse dentro de la carpeta actual project. A su vez 
la carpeta va a tener la siguiente estructura de carpetas:

-> retail-data-warehouse															OK
   * stg																			OK
   * etl																			OK
   * fct																			OK
   * dim																			OK
   * analytics																		OK
   * viz																			OK
   * bkp																			OK
   * log																			OK

Dentro de cada carpeta vamos a poner un script por cada "modelo" y cada carpeta 
representa un esquema del DW. Este paso lo podes hacer una vez que tenes al menos 
un archivo por carpeta o podes realizarlo al principio y colocando un archivo 
vacío llamado "placeholder.md" que luego podes borrar.

1. Crear las carpetas mencionadas previamente.										OK
2. Vamos a reciclar el script de ddl.sql que utilizamos al principio y sumarle 
   los scripts de "returns", "supplier", "employee" y calendario para armar la 
   estructura de nuestra carpeta stg. Crear POR CADA TABLA en stg un archivo 
   en la carpeta stg con el ddl de cada tabla cuyo nombre sera el nombre de la 
   tabla. Ejemplo: "cost.sql". No es necesario correrlos nuevamente, así 
   reutilizamos lo que ya tenemos.													OK
3. Limpiar cualquier otra tabla (si existiese) que nos haya quedado de las 
   partes anteriores que no corresponda al Data Warehouse.
   I. Las tablas que deberíamos tener en staging son las siguientes:
      a. Cost																		OK
      b. Inventory																	OK
      c. Market_count																OK
      d. Monthly_average_fx_rate													OK
      e. Order_line_sale															OK
      f. Product_master																OK
      g. Return_movements															OK
      h. Store_master																OK
      i. Super_store_count															OK
      j. Supplier																	OK
      k. Employee																	OK
4. Crear una base de datos que se llame "dev". Correr todos los scripts de 
   ddl.sql para tener la estructura en un ambiente que vamos a usar para el 
   desarrollo y testeo de nuevas queries. No es es necesario llenarlo de datos 
   ni de crear nuevos scripts para la base de desarrollo. Los scripts son 
   unicos y deben permanecer en el repositorio.										OK

Nota: Git se utiliza en todos los trabajos de desarrollo de software y data, es 
importante que conozcas todas las funcionalidades, como manejarlo por consola y 
con algún proveedor como puede ser Github o Gitlab.*/

CREATE DATABASE dev;

-- Crear schema stg
CREATE SCHEMA IF NOT EXISTS stg;
    
/* Crea tabla cost
Costo promedio actual por producto
*/

DROP TABLE IF EXISTS stg.cost;
    
CREATE TABLE stg.cost
                 (
                              codigo_producto    VARCHAR(10)
                            , costo_promedio_usd DECIMAL
                 );
				 
/* Crea tabla employees
tabla maestra de empleados por fecha de entrada y salida
*/

DROP TABLE IF EXISTS stg.employees;

CREATE TABLE stg.employees
				(
							  id SERIAL
							, nombre VARCHAR(50)
							, apellido VARCHAR(50)
							, fecha_entrada DATE
							, fecha_salida DATE
							, telefono VARCHAR(12)
							, pais VARCHAR(50)
							, provincia VARCHAR(100)
							, codigo_tienda SMALLINT
							, posicion VARCHAR(100)
				);
		
/* Crea tabla inventory
Conteo de inventario al inicio y final del dia por fecha, tienda y codigo
*/
    
DROP TABLE IF EXISTS stg.inventory;

CREATE TABLE stg.inventory
                 (
                              tienda  SMALLINT
                            , sku     VARCHAR(10)
                            , fecha   DATE
                            , inicial SMALLINT
                            , final   SMALLINT
                 );

/* Crea tabla market_count
Proveedor 1 de ingresos a tienda por fecha
*/

DROP TABLE IF EXISTS stg.market_count;
    
CREATE TABLE stg.market_count
                 (
                              tienda SMALLINT
                            , fecha  INTEGER
                            , conteo SMALLINT
                 );

/* Crea tabla monthly_average_fx_rate
Promedio de cotizacion mensual de USD a ARS, EUR a ARS y USD a URU
*/

DROP TABLE IF EXISTS stg.monthly_average_fx_rate;
    
CREATE TABLE stg.monthly_average_fx_rate
                 (
                              mes                 DATE
                            , cotizacion_usd_peso DECIMAL
                            , cotizacion_usd_eur DECIMAL
                            , cotizacion_usd_uru  DECIMAL
                 );

/* Crea tabla order_line_sale
Ventas a nivel numero de orden, item.
*/

DROP TABLE IF EXISTS stg.order_line_sale;
    
CREATE TABLE stg.order_line_sale
                 (
                              orden      VARCHAR(10)
                            , producto   VARCHAR(10)
                            , tienda     SMALLINT
                            , fecha      date
                            , cantidad   int
                            , venta      decimal(18,5)
                            , descuento  decimal(18,5)
                            , impuestos  decimal(18,5)
                            , creditos   decimal(18,5)
                            , moneda     varchar(3)
                            , pos        SMALLINT
                            , is_walkout BOOLEAN
                 );

/* Crear tabla product_master
Maestro de productos que posee la empresa. 
is_active indica que productos estan actualmente a la venta
*/

DROP TABLE IF EXISTS stg.product_master ;
    
CREATE TABLE stg.product_master
                 (
                              codigo_producto VARCHAR(255)
                            , nombre          VARCHAR(255)
                            , categoria       VARCHAR(255)
                            , subcategoria    VARCHAR(255)
                            , subsubcategoria VARCHAR(255)
                            , material        VARCHAR(255)
                            , color           VARCHAR(255)
                            , origen          VARCHAR(255)
                            , ean             bigint
                            , is_active       boolean
                            , has_bluetooth   boolean
                            , talle           VARCHAR(255)
                 );

/* Crea tabla return_movements
tabla productos devueltos por numero de orden, origen y destino
*/

DROP TABLE IF EXISTS stg.return_movements;

CREATE TABLE stg.return_movements
				(
							  orden_venta VARCHAR(10)
							, envio VARCHAR(10)
							, item VARCHAR(10)
							, cantidad INT
							, id_movimiento INT
							, desde VARCHAR(100)
							, hasta VARCHAR(100)
							, recibido_por VARCHAR(255)
							, fecha DATE
				);

/* Crea tabla store_master
Tabla maestra de tiendas 
*/

DROP TABLE IF EXISTS stg.store_master;
      
CREATE TABLE stg.store_master
                 (
                              codigo_tienda  SMALLINT
                            , pais           VARCHAR(100)
                            , provincia      VARCHAR(100)
                            , ciudad         VARCHAR(100)
                            , direccion      VARCHAR(255)
                            , nombre         VARCHAR(255)
                            , tipo           VARCHAR(100)
                            , fecha_apertura DATE
                            , latitud        DECIMAL(10, 8)
                            , longitud       DECIMAL(11, 8)
                 );

/* Crea tabla super_store_count
Proveedor 2 de ingresos a tienda por fecha
*/

DROP TABLE IF EXISTS stg.super_store_count;
    
CREATE TABLE stg.super_store_count
                 (
                              tienda SMALLINT
                            , fecha  VARCHAR(10)
                            , conteo SMALLINT
                 );

/* Crea tabla suppliers
proveedores por codigo de producto y nivel primario o secundario
*/

DROP TABLE IF EXISTS stg.suppliers;

CREATE TABLE stg.suppliers
				(
							  codigo_producto VARCHAR(10)
							, nombre VARCHAR(255)
							, is_primary BOOL default false
				);

-- Parte 2 - Creación de un ambiente de desarrollo
/*Todos los proyectos de una u otra manera tienen un lugar de desarrollo, es decir 
un ambiente separado donde se puedan hacer cambios sin influir a los datos que ve 
el usuario final. Hay muchas formas de aplicar esto dependiendo en dónde estemos 
trabajando. Nosotros vamos a montar el ambiente de desarrollo en una nueva base de datos.

1. Crear una base de datos que se llame "dev". Correr todos los scripts de ddl 
   para tener la estructura en un ambiente que vamos a usar para el desarrollo 
   y testeo de nuevas queries.														OK
   
No es es necesario subir ningún dato, vamos a mantener la estructura vacía y manejarnos 
en la base de datos inicial. Este ejercicio es solamente para mostrar la existencia de 
un ambiente de desarrollo, que es obligatoria en todo proyecto grande.*/


-- Parte 3 - Creación de un modelo dimensional
/*
1. Crear un script de ddl para cada tabla dentro de fct y dim, con sus 
   respectivas PK and FK en la creacion de tabla.
   * Decidir en cada caso si es necesario crear una clave surrogada o no.*/

-- DIM
CREATE SCHEMA dim;

DROP TABLE IF EXISTS dim.product_master ;
    
CREATE TABLE dim.product_master
                 (
                              product_id	  VARCHAR(255) PRIMARY KEY
                            , name		      VARCHAR(255)
                            , category        VARCHAR(255)
                            , subcategory     VARCHAR(255)
                            , subsubcategory  VARCHAR(255)
                            , material        VARCHAR(255)
                            , colour          VARCHAR(255)
                            , made_in         VARCHAR(255)
                            , ean             BIGINT
                            , is_active       BOOLEAN
                            , has_bluetooth   BOOLEAN
                            , size            VARCHAR(255)
                 );

DROP TABLE IF EXISTS dim.store_master;
      
CREATE TABLE dim.store_master
                 (
                              store_id		 SMALLINT		PRIMARY KEY
                            , country        VARCHAR(100)
                            , province       VARCHAR(100)
                            , city           VARCHAR(100)
                            , adress	     VARCHAR(255)
                            , name		     VARCHAR(255)
                            , type           VARCHAR(100)
                            , opening_date	 DATE
                            , latitude       DECIMAL(10, 8)
                            , longitude      DECIMAL(11, 8)
                 );
				 
DROP TABLE IF EXISTS dim.cost;
    
CREATE TABLE dim.cost
                 (
                              product_id    VARCHAR(10) PRIMARY KEY
                            , cost_usd 		DECIMAL,
					 
					 CONSTRAINT fk_product_id_cost
					 FOREIGN KEY (product_id)
					 REFERENCES dim.product_master (product_id)
                 );
				 
DROP TABLE IF EXISTS dim.employees;

CREATE TABLE dim.employees
				(
							  employee_id 	SERIAL		PRIMARY KEY
							, name	 		VARCHAR(50)
							, last_name 	VARCHAR(50)
							, entry_date	DATE
							, exit_date 	DATE
							, phone_number 	VARCHAR(12)
							, country 		VARCHAR(50)
							, province	 	VARCHAR(100)
							, store_id		SMALLINT
							, position 		VARCHAR(100)
							, is_active		BOOLEAN
							, active_period DECIMAL,
					
					CONSTRAINT fk_store_id_employees
					FOREIGN KEY (store_id)
					REFERENCES dim.store_master (store_id)
				);
				
DROP TABLE IF EXISTS dim.monthly_average_fx_rate;
    
CREATE TABLE dim.monthly_average_fx_rate
                 (
                              month         DATE
                            , usd_peso_rate DECIMAL
                            , usd_eur_rate  DECIMAL
                            , usd_uru_rate  DECIMAL
                 );

DROP TABLE IF EXISTS dim.suppliers;

CREATE TABLE dim.suppliers
				(
							  product_id 	VARCHAR(10)
							, name 			VARCHAR(255)
							, is_primary	BOOL DEFAULT false,
					
					CONSTRAINT fk_product_id_suppliers
					FOREIGN KEY (product_id)
					REFERENCES dim.product_master (product_id),
					
					CONSTRAINT uniqueness_product_id UNIQUE (product_id)
				);

select * from dim.cost
select * from dim.employees
select * from dim.monthly_average_fx_rate
select * from dim.product_master
select * from dim.store_master
select * from dim.suppliers

-- FACTS
CREATE SCHEMA fct;

DROP TABLE IF EXISTS fct.inventory;

CREATE TABLE fct.inventory
                 (
                              store_id		SMALLINT
                            , product_id	VARCHAR(10)
                            , dates			DATE
                            , initial 		SMALLINT
                            , final   		SMALLINT,
					 
					 CONSTRAINT fk_store_id_inventory
					 FOREIGN KEY (store_id)
					 REFERENCES dim.store_master (store_id),
					 
					 CONSTRAINT fk_product_id_inventory
					 FOREIGN KEY (product_id)
					 REFERENCES dim.product_master (product_id)
                 );

DROP TABLE IF EXISTS fct.market_count;
    
CREATE TABLE fct.market_count
                 (
                              store_id 	SMALLINT
                            , dates 	DATE
                            , count		SMALLINT,
					 
					 CONSTRAINT fk_store_id_market_count
					 FOREIGN KEY (store_id)
					 REFERENCES dim.store_master (store_id)
                 );

DROP TABLE IF EXISTS fct.order_line_sale;
    
CREATE TABLE fct.order_line_sale
                 (
                              order_id   VARCHAR(10)	PRIMARY KEY
                            , product_id VARCHAR(10)	
                            , store_id   SMALLINT
                            , dates      DATE
                            , qty 		 INT
                            , sales      DECIMAL(18,5)
                            , discount   DECIMAL(18,5)
                            , taxes		 DECIMAL(18,5)
                            , credits    DECIMAL(18,5)
                            , currency   VARCHAR(3)
                            , pos        SMALLINT
                            , is_walkout BOOLEAN,
					 					 
					 CONSTRAINT fk_product_id_order_line_sale
					 FOREIGN KEY (product_id)
					 REFERENCES dim.product_master (product_id),
					 
					 CONSTRAINT fk_store_id_order_line_sale
					 FOREIGN KEY (store_id)
					 REFERENCES dim.store_master (store_id)
                 );

DROP TABLE IF EXISTS fct.return_movements;

CREATE TABLE fct.return_movements
				(
							  order_id	 	VARCHAR(10)  NOT NULL
							, shipment 		VARCHAR(10)  NOT NULL
							, product_id 	VARCHAR(10)  NOT NULL
							, qty	 		INT			 NOT NULL
							, movement_id	INT			 PRIMARY KEY
							, sended_from 	VARCHAR(100) NOT NULL
							, send_to 		VARCHAR(100) NOT NULL
							, received_by 	VARCHAR(255)
							, dates 		DATE		 NOT NULL,
					
					CONSTRAINT fk_order_id_return_movements
					FOREIGN KEY (order_id)
					REFERENCES fct.order_line_sale (order_id),
					
					CONSTRAINT fk_product_id_return_movements
					FOREIGN KEY (product_id)
					REFERENCES dim.product_master (product_id)
				);
				
DROP TABLE IF EXISTS fct.super_store_count;
    
CREATE TABLE fct.super_store_count
                 (
                              store_id	SMALLINT
                            , dates		VARCHAR(10)
                            , count		SMALLINT,
					 
					 CONSTRAINT fk_store_id_super_store_count
					 FOREIGN KEY (store_id)
					 REFERENCES dim.store_master (store_id)
                 );

select * from fct.inventory
select * from fct.market_count
select * from fct.order_line_sale
select * from fct.return_movements
select * from fct.super_store_count

/* 
2. Editar el script de la tabla "employee" para que soporte un esquema de SDC 
   (Slow changing dimension) cuyo objetivo debe ser capturar cuales son los 
   empleados activos y el periodo de duracion de cada empleado.*/

CREATE TABLE dim.employees
				(
							  employee_id 	SERIAL		PRIMARY KEY
							, name	 		VARCHAR(50)
							, last_name 	VARCHAR(50)
							, entry_date	DATE
							, exit_date 	DATE
							, phone_number 	VARCHAR(12)
							, country 		VARCHAR(50)
							, province	 	VARCHAR(100)
							, store_id		SMALLINT
							, position 		VARCHAR(100)
							, is_active		BOOLEAN,
							, active_period DECIMAL,
					
					CONSTRAINT fk_store_id_employees
					FOREIGN KEY (store_id)
					REFERENCES dim.store_master (store_id)
				);
				
/*   
3. Generar un ERD para el modelo dimensional creado con las tablas de hechos y 
   de dimensiones, descargarlo en PDF y sumarlo al repositorio del proyecto.*/
   
OK

-- Parte 4 - Creación de los proceso de transformación
/*Para nuestro poryecto vamos a realizar las transformaciones de datos dentro de 
stored procedures del esquema etl. Esta parte es la encargada de limpiar las datos 
crudos y realizar las transformaciones de negocio hasta la capa de analytics.

stg -> Modelo dimensional (fct/dim)

1. Crear un backup de las ultimas versiones de todas las tablas stg en el nuevo 
   schema bkp. La idea es que los datos puedan ser recuperados rapidamente en caso 
   de errores/fallas en los scripts de transformacion.*/

CREATE SCHEMA etl;
CREATE SCHEMA bkp;

-- ETL para hacer los Backups
CREATE OR REPLACE PROCEDURE etl.sp_backup() 
LANGUAGE SQL as $$ 
	DROP TABLE IF EXISTS bkp.cost; 
	CREATE TABLE bkp.cost as
		select *
		from
    		stg.cost;
			
	DROP TABLE IF EXISTS bkp.product_master; 
	CREATE TABLE bkp.product_master as
		select *
		from
			stg.product_master;

	DROP TABLE IF EXISTS bkp.order_line_sale; 
	CREATE TABLE bkp.order_line_sale as
		select
		from
			stg.order_line_sale;

	DROP TABLE IF EXISTS bkp.inventory;
	CREATE TABLE bkp.inventory as
		select *
		from
			stg.inventory;

	DROP TABLE IF EXISTS bkp.store_master; 
	CREATE TABLE bkp.store_master as
		select *
		from
			stg.store_master;

	DROP TABLE IF EXISTS bkp.super_store_count; 
	CREATE TABLE bkp.super_store_count as
		select *
		from
			stg.super_store_count;

	DROP TABLE IF EXISTS bkp.monthly_average_fx_rate; 
	CREATE TABLE bkp.monthly_average_fx_rate as
		select *
		from
			stg.monthly_average_fx_rate;

	DROP TABLE IF EXISTS bkp.return_movements;
	CREATE TABLE bkp.return_movements as
		select *
		from
			stg.return_movements;

	DROP TABLE IF EXISTS bkp.suppliers; 
	CREATE TABLE bkp.suppliers as
		select *
		from
			stg.suppliers;

	DROP TABLE IF EXISTS bkp.employees;
	CREATE TABLE bkp.employees as
		select *
		from
			stg.employees;

$$;

call etl.sp_backup();

/*
2. Por default todas las tablas van a seguir el paradigma de truncate and insert, a 
   menos que se indique lo contrario.
3. El objetivo de este paso es que las tablas fact/dim queden "limpias" y validadas 
   y listas para ser usadas para analisis. Por lo tanto, van a requerir que hagas 
   los cambios necesarios que ya vimos en la parte 1 y 2 para que queden lo mas 
   completa posibles. Te menciono algunos como ejemplo pero la lista puede no estar 
   completa:
   * Agregar columnas: ejemplo marca/"brand" en la tabla de producto.
   * Las tablas store_count de ambos sistemas deben centrarlizarse en una tabla.
   * Limpiar la tabla de supplier dejando uno por producto.
   * Nombre de columnas: cambiar si considerar que no esta claro. Las PK suelen 
     llamarse "id" y las FK "tabla_id" ejemplo: "customer_id" OK
   * Tipo de dato: Cambiar el tipo de dato en caso que no sea correcto. OK*/

select * from dim.cost
select * from dim.employees
select * from dim.monthly_average_fx_rate
select * from stg.product_master
select * from dim.store_master
select * from stg.suppliers
select * from fct.inventory
select * from fct.market_count
select * from fct.order_line_sale
select * from fct.return_movements
select * from stg.super_store_count

-- añadir columnas a las tablas que lo necesiten
ALTER TABLE dim.employees
ADD COLUMN e_mail VARCHAR(50);

ALTER TABLE dim.product_master
ADD COLUMN brand VARCHAR(50);

-- centralizar counts 
-- primero creamos un ETL para store_master por relación de la PK y FK de las tablas count
CREATE OR REPLACE PROCEDURE etl.sp_store_master()
LANGUAGE SQL as $$
	INSERT INTO dim.store_master (
		store_id, 
		country, 
		province, 
		city, 
		adress, 
		name, 
		type, 
		opening_date, 
		latitude, 
		longitude
	)
	select 
		codigo_tienda, 
		pais, 
		provincia, 
		ciudad, 
		direccion, 
		nombre, 
		tipo, 
		fecha_apertura, 
		latitud, 
		longitud
	from stg.store_master 
	ON CONFLICT (store_id) DO UPDATE
	SET
		country = excluded.country,
		province = excluded.province,
		city = excluded.city,
		adress = excluded.adress,
		name = excluded.name,
		type = excluded.type,
		opening_date = excluded.opening_date,
		latitude = excluded.latitude,
		longitude = excluded.longitude;
$$;

call etl.sp_store_master();

ALTER TABLE fct.market_count RENAME TO unified_count; -- renombré la nueva tabla para que se sepa que está unificada

CREATE OR REPLACE PROCEDURE etl.sp_unified_count()
LANGUAGE SQL as $$
	INSERT INTO fct.unified_count (
		store_id, 
		dates, 
		count
	)
	select 
		store_id, 
		dates, 
		count
	from (
		select 
			tienda as store_id,
			to_date(cast(fecha as text), 'YYYYMMDD') as dates,
			conteo as count 
		from stg.market_count
		union all
		select 
			tienda as store_id,
			to_date(fecha, 'YYYY-MM-DD') as dates,
			conteo as count
		from stg.super_store_count
		) as union_data;
$$; -- consolidación de ambas tablas en una

call etl.sp_unified_count()

DROP TABLE fct.super_store_count; -- elimino la tabla que ya no presta utilidad

-- limpiar tabla suppliers (en este caso cargo la data haciendo la limpieza)
-- Primero creo el SP que carga datos en la dim.product_master actualizando tambien los nuevos datos (pasamos de 18 productos a 20)
CREATE OR REPLACE PROCEDURE etl.sp_product_master()
LANGUAGE SQL as $$
	INSERT INTO dim.product_master (
		product_id,
		name,
		category,
		subcategory,
		subsubcategory,
		material,
		colour,
		made_in,
		ean,
		is_active,
		has_bluetooth,
		size,
		brand
	)
	select
		codigo_producto,
		nombre,
		categoria,
		subcategoria,
		subsubcategoria,
		material,
		color,
		origen,
		ean,
		is_active,
		has_bluetooth,
		talle,
		case
			when lower(nombre) like '%samsung%' then 'Samsung'
			when lower(nombre) like '%philips%' then 'Philips'
			when lower(nombre) like '%levi%' then 'Levi''s'
			when lower(nombre) like '%jbl%' then 'JBL'
			when lower(nombre) like '%motorola%' then 'Motorola'
			when lower(nombre) like '%tommy hilfiger%' then 'Tommy Hilfiger'
			else 'Unknown'
			end as brand
	from stg.product_master
	ON CONFLICT (product_id) DO NOTHING;
$$;

call etl.sp_product_master();
		
-- creamos el ETL
CREATE OR REPLACE PROCEDURE etl.sp_suppliers()
LANGUAGE SQL as $$
	INSERT INTO dim.suppliers (
		product_id, 
		name, 
		is_primary
	)
	select 
		codigo_producto, 
		nombre, 
		is_primary
	from stg.suppliers
	where is_primary = true
	ON CONFLICT (product_id) DO NOTHING;
$$;

call etl.sp_suppliers();
	
select * from stg.suppliers 
select * from dim.suppliers order by product_id

/*
4. Las tablas de "employee" y "cost" van a usar un modelo de actulizacion tipo "upsert".
   * En caso de no se cumpla la condicion de FK no incluir esos SKUs. Como encadenarias 
     el proceso? 		
5. La tabla de ventas (order_line_sale) y la tabla de inventario va a seguir un modelo 
   incremental basado en la fecha.

Importante; Una vez creado el script de transformacion, muevan los datos originales con 
los que vinimos trabajando a el modelo dimensional y luego deben agregar los nuevos datos, 
limpiando los de stg (pueden crear un backup de todas las tablas stg para recuperarlas 
facilmente). La version final de las tablas dim/fact van a tener en cuanto a datos tres 
opciones:

* Datos nuevos, en caso de que se haya enviado un nuevo archivo.
* Los mismos datos, es el caso donde no hay cambios y no se envio un archivo nuevo.
* Combinacion de datos nuevos y viejos, para el caso donde se pide insertar/sobrescribir 
  nuevos datos.

Opcional

1. Crear store procedures que generen backup de todas las tablas en esquema stg.
2. Descargar y configurar pgAgent para programar la corrida de los stored procedures. 
   Nota: https://www.pgadmin.org/docs/pgadmin4/development/pgagent.html

Nota: En esta parte no vamos a castear a los tipos de datos correspondientes por que ya 
los teniamos desde stg con el formato correcto, pero es una practica comun comenzar con 
todas las columnas tipo varchar y luego transformarlos para la siguiente capa.*/


-- Parte 5 - Creación de la “Analytics layer”
/*La capa de analytics es aquella que se va a conectar con nuestras herramientas de BI.

1. Crear tres tablas de analytics:
   -> order_sale_line
      * Nota: Va a ser la misma tabla que hicimos para el TP Integrador de la Parte 2
   -> return
      * El objetivo es ver las ordenes de devoluciones con las dimensiones/atributos 
	    del producto retornado y ademas la tienda y sus atributas en la cual fue 
		originalmente comprado el producto (de la orden de venta) junto con el valor 
		de venta del producto retornado (es nuestra manera de cuantificar el valor de 
		la devolucion)
      * Nota: Obviamente valores de devolucion deben estar en moneda original y moneda 
	    comun.
      * Nota2: La tabla de retornors indica movimientos del item una vez que viene del 
	    cliente a nuestra tienda, cuidado con repetir valores, nosotros queremos entender 
		unciamente las ordenes-productos retornados no los movimientos que tuvo cada 
		retorno.
   -> inventory
      * El objetivo es ver el historico del inventario promedio por dia, con todas las 
	    dimensiones/atributos de producto (categoria, descripcion, etc.), dimensiones de 
		la tienda (pais, nombre, etc) y el costo de los productos.
2. Crear los stored procedures para generar las tablas de analytics a partir del modelo 
   dimensional. Los SP van a recrear la tabla cada cada vez que se corra y va a contener 
   toda la logica de cada tabla.
   * El proceso de creacion de las tablas de analytics va a ser del tipo "truncate and 
     create" ya que estas tablas son las que mayores modificaciones van a tener al codigo 
	 dado que las logicas del negocio van mutando constantement o requieren nuevos features.*/


-- Parte 6 - Logging
/* Logging es la practica que nos permite guardar registro de los cambios que se van produciendo 
en el DW y es una forma de auditar en caso de haya errores en los datos.

1. Crear una tabla de logging que indique cada vez que se realicen modificaciones a una tabla 
   con la siguiente información:
   * Tabla modificada (fct, dim o analytics)
   * Fecha de modificación.
   * Stored procedure responsable de la modificación.
   * Lineas insertadas/modificadas.
   * Usuario que corrio el stored procedures
2. Crear un stored procedure que llene la tabla de log.
3. Poner el "call" del SP de logging en cada stored procedure creado en la parte de transformacion 
   de las tablas stg a dim y fact y de las tablas de analytics.*/


-- Parte 7 - Funciones
/*
1. Encapsular la lógica de conversion de moneda en una función y reutilizarla en los scripts 
   donde sea necesario.
2. (Opcional) Que otra logica podemos encapsular en una funcion? La idea es encontrar 
   transformaciones que se repitan en varios lados. Si encontraste y crees que tiene sentido 
   crear una funcion, hacelo!*/

-- Parte 8 - Optimizacion de queries
/*
1. Que acciones podrias tomar para mejorar la performance de las queries que tenemos segun lo 
   que vimos en clase? Algunas cosas a tener en cuenta son:
   * Tipos de joins
   * Columnas seleccionada
   * Columnas usadas en la clausula on del join.
   * Posibilidad de crear indices.
   * Posibilidad de crear covering index.
   * Mira el plan de ejecucion de las queries complejas e identifica si algun paso se puede evitar.
   * Mira ordenamientos innecesarios.*/

-- Parte 9 - Testing
/* Cada proyecto tiene que tener como minimo testeos de nivel de agregacion del nivel de detalle. 
En este caso estamos cubiertos por que las PK y las FK son retricciones de unicidad y nulidad. En 
este punto no hay que hacer nada a menos que consideres agregar algun testeo extra de las PK y FK!*/


-- Parte 10 - Otros
/* Crear una Guia de estilo que va a a marcar los estándares de sintaxis para cualquier desarrollo 
del DW. (podes usar la misma que mostramos en clase o editarla!)*/


-- Parte 11 - Opcional
/*Opcional - Conectar la tabla de order_sale_line a PowerBI y realizar una visualización que resuma 
el estado de ventas y ganancias de la empresa.*/
