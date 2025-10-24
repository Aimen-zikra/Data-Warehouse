INSERT INTO silver_crm_prd_info(
	prd_id,
    cat_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt)
SELECT 
	prd_id,
    REPLACE(SUBSTRING(prd_key, 1, 5),'-','_') AS cat_id, -- Extract cat_id
    SUBSTRING(prd_key, 7, LENGTH(prd_key)) AS prd_key, -- Extract product key
	prd_nm,
    IFNULL(prd_cost,0) AS prd_cost,
	CASE UPPER(TRIM(prd_line)) 
		 WHEN 'M' THEN 'Mountain'
		 WHEN 'R' THEN 'Road'
    	 WHEN 'S' THEN 'Other Sales'
		 WHEN 'T' THEN 'Touring'
		 ELSE 'n/a'
 	END prd_line,  -- map product line codes to descriptive values
	prd_start_dt,
	DATE_SUB(
		LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt),
		INTERVAL 1  DAY )
	AS prd_end_dt
FROM bronze_crm_prd_info
