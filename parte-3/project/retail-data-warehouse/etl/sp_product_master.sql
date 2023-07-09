CREATE OR REPLACE PROCEDURE etl.sp_product_master()
LANGUAGE SQL as $$
	INSERT INTO dim.product_master (
		product_id,
		name,
		category,
		subcategory,
		subsubcategory,
		material,
		colour,
		made_in,
		ean,
		is_active,
		has_bluetooth,
		size,
		brand
	)
	select
		codigo_producto,
		nombre,
		categoria,
		subcategoria,
		subsubcategoria,
		material,
		color,
		origen,
		ean,
		is_active,
		has_bluetooth,
		talle,
		case
			when lower(nombre) like '%samsung%' then 'Samsung'
			when lower(nombre) like '%philips%' then 'Philips'
			when lower(nombre) like '%levi%' then 'Levi''s'
			when lower(nombre) like '%jbl%' then 'JBL'
			when lower(nombre) like '%motorola%' then 'Motorola'
			when lower(nombre) like '%tommy hilfiger%' then 'Tommy Hilfiger'
			else 'Unknown'
			end as brand
	from stg.product_master
	ON CONFLICT (product_id) DO NOTHING;
$$;

call etl.sp_product_master();
