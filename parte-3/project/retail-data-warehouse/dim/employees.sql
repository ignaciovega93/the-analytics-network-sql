DROP TABLE IF EXISTS dim.employees;

CREATE TABLE dim.employees
				(
							  employee_id 	SERIAL		PRIMARY KEY
							, name	 		VARCHAR(50)
							, last_name 	VARCHAR(50)
							, entry_date	DATE
							, exit_date 	DATE
							, phone_number 	VARCHAR(12)
							, country 		VARCHAR(50)
							, province	 	VARCHAR(100)
							, store_id		SMALLINT
							, position 		VARCHAR(100)
							, is_active		BOOLEAN
							, active_period DECIMAL,
					
					CONSTRAINT fk_store_id_employees
					FOREIGN KEY (store_id)
					REFERENCES dim.store_master (store_id)
				);
