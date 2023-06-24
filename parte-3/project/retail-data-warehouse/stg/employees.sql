-- Crear schema stg
CREATE SCHEMA IF NOT EXISTS stg;    

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
