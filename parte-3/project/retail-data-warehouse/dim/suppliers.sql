DROP TABLE IF EXISTS dim.suppliers;

CREATE TABLE dim.suppliers
				(
							  product_id 	VARCHAR(10)
							, name 			VARCHAR(255)
							, is_primary	BOOL DEFAULT false,
					
					CONSTRAINT fk_product_id_suppliers
					FOREIGN KEY (product_id)
					REFERENCES dim.product_master (product_id)
				);
