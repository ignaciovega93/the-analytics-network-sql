DROP TABLE IF EXISTS fct.market_count;
    
CREATE TABLE fct.market_count
                 (
                              store_id 	SMALLINT
                            , dates 	DATE
                            , count		SMALLINT,
					 
					 CONSTRAINT fk_store_id_market_count
					 FOREIGN KEY (store_id)
					 REFERENCES dim.store_master (store_id)
                 );
