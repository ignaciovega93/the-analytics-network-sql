DROP TABLE IF EXISTS dim.cost;
    
CREATE TABLE dim.cost
                 (
                              product_id    VARCHAR(10) PRIMARY KEY
                            , cost_usd 		DECIMAL,
					 
					 CONSTRAINT fk_product_id_cost
					 FOREIGN KEY (product_id)
					 REFERENCES dim.product_master (product_id)
                 );
				 
