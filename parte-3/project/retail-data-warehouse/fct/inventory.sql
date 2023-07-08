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
