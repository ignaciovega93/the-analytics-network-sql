-- Crear schema stg
CREATE SCHEMA IF NOT EXISTS stg;    

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
