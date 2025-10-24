-- Check for null or duplicates in primary key 
SELECT cst_id,
COUNT(*)
FROM bronze_crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for unwanted spaces
SELECT cst_firstname
FROM silver_crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

-- Window function to rank in between duplicates
SELECT * ,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_list
FROM bronze_crm_cust_info 
WHERE cst_id = 29466;

SELECT * ,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_list
FROM bronze_crm_cust_info ;

-- Check for data we don't need, null values, duplicated
SELECT * FROM (
	SELECT * ,
	ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_list
	FROM bronze_crm_cust_info )AS sub WHERE flag_list != 1 ;

SELECT * FROM (
	SELECT * ,
	ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_list
	FROM bronze_crm_cust_info )AS sub WHERE flag_list = 1 ;

-- Display the data where primary key is unique (no duplicates)
SELECT * FROM (
	SELECT * ,
	ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_list
	FROM bronze_crm_cust_info )AS sub WHERE flag_list = 1 AND cst_id = 29466;


-- Check for unwanted/blank spaces
SELECT cst_firstname FROM datawarehouse.bronze_crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

SELECT cst_lastname FROM datawarehouse.bronze_crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);

SELECT cst_gndr FROM datawarehouse.bronze_crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr);

-- Remove blank rows 
SELECT * FROM (
	SELECT *, 
		ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_list
	FROM bronze_crm_cust_info
	WHERE cst_firstname != '' 
) AS sub 
WHERE flag_list = 1;

-- Trim unwanted spaces
SELECT cst_id, cst_key, 
TRIM(cst_firstname) AS cst_firstname, 
TRIM(cst_lastname) AS cst_lastname, 
cst_marital_status, cst_gndr, cst_create_date 
FROM (
	SELECT * ,
	ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_list
	FROM bronze_crm_cust_info 
    WHERE cst_firstname != '' 
)AS sub WHERE flag_list = 1 ;

