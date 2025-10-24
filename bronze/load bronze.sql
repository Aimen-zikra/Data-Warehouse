-- Load Bronze Layer (Source -> Bronze)

SELECT * FROM bronze_crm_cust_info;

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE '/Users/aimen/Desktop/Data Warehouse Project/datasets/source_crm/cust_info.csv'
INTO TABLE bronze_crm_cust_info
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Users/aimen/Desktop/Data Warehouse Project/datasets/source_crm/prd_info.csv'
    INTO TABLE bronze_crm_prd_info
    FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;
    
LOAD DATA LOCAL INFILE '/Users/aimen/Desktop/Data Warehouse Project/datasets/source_crm/sales_details.csv'
    INTO TABLE bronze_crm_sales_details
    FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;
    
LOAD DATA LOCAL INFILE '/Users/aimen/Desktop/Data Warehouse Project/datasets/source_erp/cust_az12.csv'
    INTO TABLE bronze_erp_cust_az12
    FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;
    
LOAD DATA LOCAL INFILE '/Users/aimen/Desktop/Data Warehouse Project/datasets/source_erp/loc_a101.csv'
    INTO TABLE bronze_erp_loc_a101
    FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE '/Users/aimen/Desktop/Data Warehouse Project/datasets/source_erp/px_cat_g1v2.csv'
    INTO TABLE bronze_erp_px_cat_g1v2
    FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;