-- data clean
SELECT cid, cntry 
FROM bronze_erp_loc_a101;

SELECT cst_key FROM silver_crm_cust_info;

-- check bronze erp and silver crm
SELECT 
REPLACE(cid,'-','') cid,
cntry 
FROM bronze_erp_loc_a101 WHERE REPLACE(cid,'-','') NOT IN 
(SELECT cst_key FROM silver_crm_cust_info);

SELECT 
REPLACE(cid,'-','') cid,
cntry 
FROM bronze_erp_loc_a101 WHERE cid NOT IN 
(SELECT cst_key FROM silver_crm_cust_info);

-- Data Standardization and COnsistency
SELECT DISTINCT cntry
FROM bronze_erp_loc_a101
ORDER BY cntry;

SELECT DISTINCT cntry
FROM silver_erp_loc_a101
ORDER BY cntry;
