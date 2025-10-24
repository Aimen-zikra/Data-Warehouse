-- Quality checks 

-- Check for Nulls/ Duplicates in Primary Key
SELECT prd_id,
COUNT(*)
FROM silver_crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for unwanted spaces
SELECT prd_nm
FROM silver_crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Check for Null or Negative nos
SELECT prd_cost
FROM silver_crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Data Standardization
SELECT DISTINCT prd_line
FROM  silver_crm_prd_info;

-- Check fot Invalid Date orders
SELECT * FROM silver_crm_prd_info
WHERE prd_end_dt < prd_start_dt;

SELECT * FROM silver_crm_prd_info
