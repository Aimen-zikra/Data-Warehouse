-- Data Preparation and Cleaning
-- FIRST THREE COLUMNS
-- check for unwanted spaces
SELECT *
FROM bronze_crm_sales_details 
WHERE sls_ord_num != TRIM(sls_ord_num);

-- check integrity - Show sales linked to product that doesn't exist in the product list.
SELECT *
FROM bronze_crm_sales_details 
WHERE sls_prd_key NOT IN (SELECT prd_key FROM silver_crm_prd_info);

SELECT *
FROM bronze_crm_sales_details 
WHERE sls_cust_id NOT IN (SELECT cst_id FROM silver_crm_cust_info);

-- DATE COLUMNS
-- check for invalid dates
SELECT
sls_order_dt
FROM bronze_crm_sales_details
WHERE sls_order_dt <=0 ;

-- null values
-- order date
SELECT 
NULLIF(sls_order_dt,0) sls_order_dt
FROM bronze_crm_sales_details
WHERE sls_order_dt <=0  
OR LENGTH(sls_order_dt) != 8
OR sls_order_dt > 20500101 OR sls_order_dt < 19000101; 

-- ship date
SELECT 
NULLIF(sls_ship_dt,0) sls_ship_dt
FROM bronze_crm_sales_details
WHERE sls_ship_dt <=0 
OR LENGTH(sls_ship_dt) != 8
OR sls_ship_dt > 20500101 OR sls_ship_dt < 19000101; 

-- Check for invalid date orders
SELECT * FROM bronze_crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt;

-- values must not be null, zero or negative 
SELECT DISTINCT
sls_sales, sls_quantity, sls_price,
CASE WHEN sls_sales IS NULL 
	OR sls_sales <=0 
	OR sls_sales != sls_quantity * ABS(sls_price)
	THEN sls_quantity * ABS(sls_price)
	ELSE sls_sales
END AS sls_sales,

ROUND(CASE WHEN sls_price IS NULL
	OR sls_price <=0
	THEN sls_sales / NULLIF(sls_quantity,0)
	ELSE sls_price
END ,2) AS sls_price

FROM bronze_crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
	OR sls_sales IS NULL 
	OR sls_quantity IS NULL 
	OR sls_price IS NULL
	OR sls_sales <= 0 
	OR sls_quantity <=0 
	OR sls_price <=0
ORDER BY sls_sales, sls_quantity, sls_price;

SELECT 
    sls_sales, 
    sls_quantity, 
    sls_sales / NULLIF(sls_quantity, 0) AS price_calc
FROM bronze_crm_sales_details
WHERE sls_price IS NULL OR sls_price <= 0
LIMIT 10;

SELECT * FROM bronze_crm_sales_details;