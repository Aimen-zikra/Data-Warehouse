-- Quality checks
SELECT * FROM gold_dim_customers;

-- gnder
SELECT DISTINCT gender FROM gold_dim_customers;

SELECT DISTINCT cst_gndr FROM silver_crm_cust_info;

