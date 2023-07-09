-- agregamos una restriccion para que no hayan duplicados
ALTER TABLE dim.suppliers
ADD CONSTRAINT uniqueness_product_id UNIQUE (product_id);

-- creamos el ETL
CREATE OR REPLACE PROCEDURE etl.sp_suppliers()
LANGUAGE SQL as $$
	INSERT INTO dim.suppliers (
		product_id, 
		name, 
		is_primary
	)
	select 
		codigo_producto, 
		nombre, 
		is_primary
	from stg.suppliers
	where is_primary = true
	ON CONFLICT (product_id) DO NOTHING;
$$;

call etl.sp_suppliers();
