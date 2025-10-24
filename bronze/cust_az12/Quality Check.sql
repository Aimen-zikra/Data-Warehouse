-- Identify Out of Range Dates
SELECT DISTINCT 
bdate
FROM silver_erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > CURRENT_DATE;

-- Data standardization and Consistency
SELECT DISTINCT gen 
FROM silver_erp_cust_az12;

SELECT * FROM silver_erp_cust_az12;