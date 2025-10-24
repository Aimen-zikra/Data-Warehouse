-- Power query
-- Transform and load to silver

INSERT INTO silver_crm_cust_info(
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date)

SELECT cst_id, cst_key, 
TRIM(cst_firstname) AS cst_firstname, 
TRIM(cst_lastname) AS cst_lastname, 

CASE WHEN UPPER(TRIM(cst_marital_status)) ='S' THEN 'Single'
	 WHEN UPPER(TRIM(cst_marital_status)) ='M' THEN 'Married'
     ELSE 'n/a'
 END cst_marital_status, -- Normalize marital status values to readable format
 
CASE WHEN UPPER(TRIM(cst_gndr)) ='F' THEN 'Female'
	 WHEN UPPER(TRIM(cst_gndr)) ='M' THEN 'Male'
     ELSE 'n/a'
END cst_gndr, -- Normalize gender values to readable format

cst_create_date 
FROM (
	SELECT * ,
	ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_list
	FROM bronze_crm_cust_info 
    WHERE cst_firstname != '' 
)AS sub WHERE flag_list = 1 ; -- select the most recent record per customer

SELECT * FROM silver_crm_cust_info;
