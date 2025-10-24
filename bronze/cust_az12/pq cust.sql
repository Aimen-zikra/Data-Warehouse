INSERT INTO silver_erp_cust_az12(cid,bdate,gen)
SELECT  
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LENGTH(cid))
	ELSE cid
END AS cid,
CASE WHEN bdate > CURRENT_DATE THEN NULL 
	ELSE bdate 
END AS bdate, 
 CASE
    WHEN UPPER(TRIM(REPLACE(REPLACE(gen, CHAR(13), ''), CHAR(10), ''))) IN ('F', 'FEMALE') THEN 'Female'
    WHEN UPPER(TRIM(REPLACE(REPLACE(gen, CHAR(13), ''), CHAR(10), ''))) IN ('M', 'MALE') THEN 'Male'
    ELSE 'n/a'
END AS gen
FROM bronze_erp_cust_az12
