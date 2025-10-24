INSERT INTO silver_erp_px_Cat_g1v2(id,cat,subcat,maintenance)
SELECT 
id, cat, subcat, 
	TRIM(REPLACE(REPLACE(maintenance, CHAR(13), ''), CHAR(10), '')) AS maintenance
FROM bronze_erp_px_cat_g1v2;
