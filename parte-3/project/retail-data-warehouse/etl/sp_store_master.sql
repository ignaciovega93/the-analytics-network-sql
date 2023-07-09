CREATE OR REPLACE PROCEDURE etl.sp_store_master()
LANGUAGE SQL as $$
	INSERT INTO dim.store_master (
		store_id, 
		country, 
		province, 
		city, 
		adress, 
		name, 
		type, 
		opening_date, 
		latitude, 
		longitude
	)
	select 
		codigo_tienda, 
		pais, 
		provincia, 
		ciudad, 
		direccion, 
		nombre, 
		tipo, 
		fecha_apertura, 
		latitud, 
		longitud
	from stg.store_master 
	ON CONFLICT (store_id) DO UPDATE
	SET
		country = excluded.country,
		province = excluded.province,
		city = excluded.city,
		adress = excluded.adress,
		name = excluded.name,
		type = excluded.type,
		opening_date = excluded.opening_date,
		latitude = excluded.latitude,
		longitude = excluded.longitude;
$$;

call etl.sp_store_master();
