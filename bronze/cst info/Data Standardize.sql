-- Data Standardization and consistency
SELECT cst_key
FROM bronze_crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- GENDER
SELECT DISTINCT cst_gndr FROM bronze_crm_cust_info;

SELECT cst_id, cst_key, 
TRIM(cst_firstname) AS cst_firstname, 
TRIM(cst_lastname) AS cst_lastname, 
cst_marital_status, 
CASE WHEN UPPER(TRIM(cst_gndr)) ='F' THEN ' Female'
	 WHEN UPPER(TRIM(cst_gndr)) ='M' THEN ' Male'
     ELSE 'n/a'
END cst_gndr,
cst_create_date 
FROM (
	SELECT * ,
	ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_list
	FROM bronze_crm_cust_info 
    WHERE cst_firstname != '' 
)AS sub WHERE flag_list = 1 ;

-- MARITAL STATUS
SELECT DISTINCT cst_marital_status FROM bronze_crm_cust_info;

SELECT cst_id, cst_key, 
TRIM(cst_firstname) AS cst_firstname, 
TRIM(cst_lastname) AS cst_lastname, 

CASE WHEN UPPER(TRIM(cst_marital_status)) ='S' THEN ' Single'
	 WHEN UPPER(TRIM(cst_marital_status)) ='M' THEN ' Married'
     ELSE 'n/a'
 END cst_marital_status, 
 
CASE WHEN UPPER(TRIM(cst_gndr)) ='F' THEN ' Female'
	 WHEN UPPER(TRIM(cst_gndr)) ='M' THEN ' Male'
     ELSE 'n/a'
END cst_gndr,
cst_create_date 
FROM (
	SELECT * ,
	ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_list
	FROM bronze_crm_cust_info 
    WHERE cst_firstname != '' 
)AS sub WHERE flag_list = 1 ;