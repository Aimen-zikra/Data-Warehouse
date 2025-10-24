INSERT INTO silver_erp_loc_a101(cid,cntry)
SELECT 
  REPLACE(cid, '-', '') AS cid,
  CASE
    WHEN UPPER(TRIM(REPLACE(REPLACE(cntry, CHAR(13), ''), CHAR(10), ''))) = 'DE' THEN 'Germany'
    WHEN UPPER(TRIM(REPLACE(REPLACE(cntry, CHAR(13), ''), CHAR(10), ''))) IN ('US', 'USA') THEN 'United States'
    WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
    ELSE TRIM(cntry)
  END AS cntry
FROM bronze_erp_loc_a101;

SELECT * FROM silver_erp_loc_a101;