CREATE OR REPLACE PROCEDURE etl.sp_backup() 
LANGUAGE SQL as $$ 
	DROP TABLE IF EXISTS bkp.cost; 
	CREATE TABLE bkp.cost as
		select *
		from
    		stg.cost;
			
	DROP TABLE IF EXISTS bkp.product_master; 
	CREATE TABLE bkp.product_master as
		select *
		from
			stg.product_master;

	DROP TABLE IF EXISTS bkp.order_line_sale; 
	CREATE TABLE bkp.order_line_sale as
		select
		from
			stg.order_line_sale;

	DROP TABLE IF EXISTS bkp.inventory;
	CREATE TABLE bkp.inventory as
		select *
		from
			stg.inventory;

	DROP TABLE IF EXISTS bkp.store_master; 
	CREATE TABLE bkp.store_master as
		select *
		from
			stg.store_master;

	DROP TABLE IF EXISTS bkp.super_store_count; 
	CREATE TABLE bkp.super_store_count as
		select *
		from
			stg.super_store_count;

	DROP TABLE IF EXISTS bkp.monthly_average_fx_rate; 
	CREATE TABLE bkp.monthly_average_fx_rate as
		select *
		from
			stg.monthly_average_fx_rate;

	DROP TABLE IF EXISTS bkp.return_movements;
	CREATE TABLE bkp.return_movements as
		select *
		from
			stg.return_movements;

	DROP TABLE IF EXISTS bkp.suppliers; 
	CREATE TABLE bkp.suppliers as
		select *
		from
			stg.suppliers;

	DROP TABLE IF EXISTS bkp.employees;
	CREATE TABLE bkp.employees as
		select *
		from
			stg.employees;

$$;

call etl.sp_backup();
