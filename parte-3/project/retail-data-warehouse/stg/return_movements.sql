-- Crear schema stg
CREATE SCHEMA IF NOT EXISTS stg;    

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
