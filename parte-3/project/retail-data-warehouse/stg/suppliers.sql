-- Crear schema stg
CREATE SCHEMA IF NOT EXISTS stg;    

/* Crea tabla suppliers
proveedores por codigo de producto y nivel primario o secundario
*/

DROP TABLE IF EXISTS stg.suppliers;

CREATE TABLE stg.suppliers
	(
		  codigo_producto VARCHAR(10)
		, nombre VARCHAR(255)
		, is_primary BOOL default false
	)
;
