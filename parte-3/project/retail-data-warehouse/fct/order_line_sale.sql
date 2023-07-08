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
