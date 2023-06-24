-- Crear schema stg
CREATE SCHEMA IF NOT EXISTS stg;    

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
