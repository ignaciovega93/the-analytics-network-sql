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
