-- Data Preparation and Data Cleaning

-- Check for Nulls/ Duplicates in Primary Key
SELECT prd_id,
COUNT(*)
FROM bronze_crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- SPLIT PRD_KEY
-- First part(prd key)
SELECT 
	prd_id,
	prd_key,
    SUBSTRING(prd_key, 1,5) AS cat_id,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt
FROM bronze_crm_prd_info;

SELECT DISTINCT id FROM bronze_erp_px_cat_g1v2;

-- Clean the crm for erp (replace - with _ )
SELECT 
	prd_id,
	prd_key,
    REPLACE(SUBSTRING(prd_key, 1,5),'-','_') AS cat_id,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt
FROM bronze_crm_prd_info;

-- Find any cat_id not in erp px cat
SELECT 
	prd_id,
	prd_key,
    REPLACE(SUBSTRING(prd_key, 1,5),'-','_') AS cat_id,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt
FROM bronze_crm_prd_info
WHERE REPLACE(SUBSTRING(prd_key, 1,5),'-','_') NOT IN
(SELECT DISTINCT id FROM bronze_erp_px_cat_g1v2);

SELECT DISTINCT id FROM bronze_erp_px_cat_g1v2;

-- Second part(prd key)
SELECT 
	prd_id,
	prd_key,
    REPLACE(SUBSTRING(prd_key, 1, 5),'-','_') AS cat_id,
    SUBSTRING(prd_key, 7, LENGTH(prd_key)) AS prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt
FROM bronze_crm_prd_info;

-- Check for unwanted spaces
SELECT prd_nm
FROM bronze_crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Check for Null or Negative nos
SELECT prd_cost
FROM bronze_crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Data Standardization
SELECT DISTINCT prd_LINE
FROM  bronze_crm_prd_info;

-- Check fot Invalid Date orders
SELECT * FROM bronze_crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- Fix dates 
SELECT 
	prd_id,
	prd_key,
	prd_nm,
	prd_start_dt,
	prd_end_dt,
    DATE_SUB(
		LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt),
		INTERVAL 1  DAY )
	AS prd_end_dt_test
FROM bronze_crm_prd_info
WHERE prd_key IN ('AC-HE-HL-U509-R','AC-HE-HL-U509');