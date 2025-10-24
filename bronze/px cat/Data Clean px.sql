-- check for unwanted spaces
SELECT *
FROM bronze_erp_px_cat_g1v2
WHERE cat!= TRIM(cat) 
OR subcat!= TRIM(subcat) 
OR  maintenance!= TRIM(maintenance);

-- data standardization adn normalization
SELECT DISTINCT cat FROM bronze_erp_px_cat_g1v2;

SELECT DISTINCT subcat FROM bronze_erp_px_cat_g1v2;

SELECT DISTINCT maintenance FROM bronze_erp_px_cat_g1v2;

SELECT DISTINCT
  TRIM(REPLACE(REPLACE(maintenance, CHAR(13), ''), CHAR(10), '')) AS maintenance
FROM bronze_erp_px_cat_g1v2;
