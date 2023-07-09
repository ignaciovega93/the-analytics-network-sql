/* Este Store Procedure tiene como objetivo unificar las tablas count en una sola y en un mismo formato */

ALTER TABLE fct.market_count RENAME TO unified_count; -- renombramos la tabla para que se sepa que unifica los counts

CREATE OR REPLACE PROCEDURE etl.sp_unified_count()
LANGUAGE SQL as $$
	INSERT INTO fct.unified_count (
		store_id, 
		dates, 
		count
	)
	select 
		store_id, 
		dates, 
		count
	from (
		select 
			tienda as store_id,
			to_date(cast(fecha as text), 'YYYYMMDD') as dates,
			conteo as count 
		from stg.market_count
		union all
		select 
			tienda as store_id,
			to_date(fecha, 'YYYY-MM-DD') as dates,
			conteo as count
		from stg.super_store_count
		) as union_data;
$$; -- consolidación de ambas tablas en una

call etl.sp_unified_count() -- llamamos el SP

DROP TABLE fct.super_store_count; -- eliminamos la tabla fct que ya no presta utilidad
