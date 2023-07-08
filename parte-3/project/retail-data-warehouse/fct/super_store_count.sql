DROP TABLE IF EXISTS fct.super_store_count;
    
CREATE TABLE fct.super_store_count
                 (
                              store_id	SMALLINT
                            , dates		VARCHAR(10)
                            , count		SMALLINT,
					 
					 CONSTRAINT fk_store_id_super_store_count
					 FOREIGN KEY (store_id)
					 REFERENCES dim.store_master (store_id)
                 );
