-- Main Query
ALTER TABLE silver_crm_sales_details
MODIFY sls_sales DECIMAL(10, 2),
MODIFY sls_price DECIMAL(10, 2);
-- -- -- 
INSERT INTO silver_crm_sales_details (
  sls_ord_num, sls_prd_key, sls_cust_id,
  sls_order_dt, sls_ship_dt, sls_due_dt,
  sls_sales, sls_quantity, sls_price
)
SELECT
  sls_ord_num,
  sls_prd_key,
  sls_cust_id,

  -- Dates
  CASE 
    WHEN sls_order_dt <= 0 OR LENGTH(sls_order_dt) != 8 THEN NULL
    ELSE STR_TO_DATE(CAST(sls_order_dt AS CHAR), '%Y%m%d')
  END AS sls_order_dt,

  CASE 
    WHEN sls_ship_dt <= 0 OR LENGTH(sls_ship_dt) != 8 THEN NULL
    ELSE STR_TO_DATE(CAST(sls_ship_dt AS CHAR), '%Y%m%d')
  END AS sls_ship_dt,

  CASE 
    WHEN sls_due_dt <= 0 OR LENGTH(sls_due_dt) != 8 THEN NULL
    ELSE STR_TO_DATE(CAST(sls_due_dt AS CHAR), '%Y%m%d')
  END AS sls_due_dt,

  -- Compute sls_sales AFTER fixing sls_quantity and sls_price
  CASE
    WHEN sls_quantity IS NULL OR sls_quantity <= 0 
      OR sls_price IS NULL OR sls_price <= 0 THEN NULL
    ELSE ROUND(sls_quantity * ABS(sls_price), 2)
  END AS sls_sales, 

  -- Clean quantity
  CASE 
    WHEN sls_quantity IS NULL OR sls_quantity <= 0 THEN NULL
    ELSE sls_quantity
  END AS sls_quantity,

  -- Clean price
  ROUND(
    CASE 
      WHEN sls_price IS NULL OR sls_price <= 0 THEN NULL
      ELSE ABS(sls_price)
    END, 2
  ) AS sls_price

FROM bronze_crm_sales_details;

SELECT *
FROM silver_crm_sales_details
WHERE sls_sales IS NULL
   OR sls_quantity IS NULL
   OR sls_price IS NULL
   OR sls_sales != ROUND(sls_quantity * sls_price, 2)
   OR sls_sales <= 0
   OR sls_quantity <= 0
   OR sls_price <= 0;