--  🚀 Core Business Metrics SQL
-- 1. Total Revenue
SELECT 
    ROUND(SUM(sales_amount), 2) AS total_revenue
FROM gold_fact_sales;

-- 2. Monthly Revenue Trends
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    ROUND(SUM(sales_amount), 2) AS monthly_revenue
FROM gold_fact_sales
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- 3. Monthly Growth Rate (%)
WITH monthly_sales AS (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(sales_amount) AS revenue
    FROM gold_fact_sales
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT 
    m1.month,
    ROUND(m1.revenue, 2) AS current_revenue,
    ROUND(((m1.revenue - m2.revenue) / m2.revenue) * 100, 2) AS monthly_growth_pct
FROM monthly_sales m1
LEFT JOIN monthly_sales m2 
    ON STR_TO_DATE(CONCAT(m1.month, '-01'), '%Y-%m-%d') = 
       DATE_ADD(STR_TO_DATE(CONCAT(m2.month, '-01'), '%Y-%m-%d'), INTERVAL 1 MONTH)
ORDER BY m1.month;


-- 4. Top 10 Products by Revenue
SELECT 
    p.product_name,
    p.category,
    ROUND(SUM(f.sales_amount), 2) AS total_revenue,
    SUM(f.quantity) AS total_quantity
FROM gold_fact_sales f
JOIN gold_dim_products p 
    ON f.product_key = p.product_key
GROUP BY p.product_name, p.category
ORDER BY total_revenue DESC
LIMIT 10;

-- 5. Top 10 Customers by Revenue
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.country,
    ROUND(SUM(f.sales_amount), 2) AS total_spent,
    COUNT(DISTINCT f.order_number) AS total_orders
FROM gold_fact_sales f
JOIN gold_dim_customers c 
    ON f.customer_key = c.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name, c.country
ORDER BY total_spent DESC
LIMIT 10;

-- 6. Revenue by Country
SELECT 
    c.country,
    ROUND(SUM(f.sales_amount), 2) AS total_revenue
FROM gold_fact_sales f
JOIN gold_dim_customers c 
    ON f.customer_key = c.customer_key
GROUP BY c.country
ORDER BY total_revenue DESC;

-- 7. Average Order Value (AOV)
SELECT 
    ROUND(SUM(sales_amount) / COUNT(DISTINCT order_number), 2) AS avg_order_value
FROM gold_fact_sales;

-- 8. Product Category Performance
SELECT 
    p.category,
    ROUND(SUM(f.sales_amount), 2) AS category_revenue,
    SUM(f.quantity) AS total_quantity_sold
FROM gold_fact_sales f
JOIN gold_dim_products p 
    ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY category_revenue DESC;

-- 9. Revenue by Customer Demographics (Gender / Marital Status)
SELECT 
    c.gender,
    c.marital_status,
    ROUND(SUM(f.sales_amount), 2) AS total_revenue
FROM gold_fact_sales f
JOIN gold_dim_customers c 
    ON f.customer_key = c.customer_key
GROUP BY c.gender, c.marital_status
ORDER BY total_revenue DESC;

-- 10. Revenue by Product Line Over Time
SELECT 
    DATE_FORMAT(f.order_date, '%Y-%m') AS month,
    p.product_line,
    ROUND(SUM(f.sales_amount), 2) AS total_revenue
FROM gold_fact_sales f
JOIN gold_dim_products p 
    ON f.product_key = p.product_key
GROUP BY DATE_FORMAT(f.order_date, '%Y-%m'), p.product_line
ORDER BY month, total_revenue DESC;
