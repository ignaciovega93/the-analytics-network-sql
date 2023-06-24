-- Crear schema stg
CREATE SCHEMA IF NOT EXISTS stg;    

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
