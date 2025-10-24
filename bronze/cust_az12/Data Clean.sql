-- data wrangling
-- Identify out-of-range dates
SELECT DISTINCT 
bdate
FROM bronze_erp_cust_az12
WHERE bdate < '1924-01-01';

-- check for birthdays in future
SELECT DISTINCT 
bdate
FROM bronze_erp_cust_az12
WHERE bdate < '1924-01-01' AND bdate > CURRENT_DATE;

SELECT DISTINCT 
bdate
FROM bronze_erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > CURRENT_DATE;

-- Data standardization and Consistency
SELECT DISTINCT gen 
FROM bronze_erp_cust_az12;

SELECT DISTINCT
  gen AS raw_gen,
  CASE
    WHEN UPPER(TRIM(REPLACE(REPLACE(gen, CHAR(13), ''), CHAR(10), ''))) IN ('F', 'FEMALE') THEN 'Female'
    WHEN UPPER(TRIM(REPLACE(REPLACE(gen, CHAR(13), ''), CHAR(10), ''))) IN ('M', 'MALE') THEN 'Male'
    ELSE 'n/a'
  END AS gen
FROM bronze_erp_cust_az12;

