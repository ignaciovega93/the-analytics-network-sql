DROP TABLE IF EXISTS fct.return_movements;

CREATE TABLE fct.return_movements
				(
							  order_id	 	VARCHAR(10)  NOT NULL
							, shipment 		VARCHAR(10)  NOT NULL
							, product_id 	VARCHAR(10)  NOT NULL
							, qty	 		INT			 NOT NULL
							, movement_id	INT			 PRIMARY KEY
							, sended_from 	VARCHAR(100) NOT NULL
							, send_to 		VARCHAR(100) NOT NULL
							, received_by 	VARCHAR(255)
							, dates 		DATE		 NOT NULL,
					
					CONSTRAINT fk_order_id_return_movements
					FOREIGN KEY (order_id)
					REFERENCES fct.order_line_sale (order_id),
					
					CONSTRAINT fk_product_id_return_movements
					FOREIGN KEY (product_id)
					REFERENCES dim.product_master (product_id)
				);
