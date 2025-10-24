-- Sales Trend Analysis (Growth, Decline, Seasonality)
-- Monthly Trend & Growth Rate
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

-- Product Performance KPIs
-- 1. Revenue Contribution by Product
SELECT 
    p.product_name,
    ROUND(SUM(f.sales_amount), 2) AS total_revenue,
    ROUND((SUM(f.sales_amount) / (SELECT SUM(sales_amount) FROM gold_fact_sales)) * 100, 2) AS revenue_contribution_pct
FROM gold_fact_sales f
JOIN gold_dim_products p ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- 2. Profit Margin per Product
SELECT 
    p.product_name,
    ROUND(SUM(f.sales_amount) - (SUM(f.quantity * p.cost)), 2) AS total_profit,
    ROUND(((SUM(f.sales_amount) - SUM(f.quantity * p.cost)) / SUM(f.sales_amount)) * 100, 2) AS profit_margin_pct
FROM gold_fact_sales f
JOIN gold_dim_products p ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY profit_margin_pct DESC;

-- 3. Repeat Purchase Rate by Product
SELECT 
    p.product_name,
    COUNT(DISTINCT f.customer_key) AS unique_customers,
    COUNT(DISTINCT f.order_number) AS total_orders,
    ROUND((COUNT(DISTINCT f.order_number) / COUNT(DISTINCT f.customer_key)), 2) AS repeat_purchase_ratio
FROM gold_fact_sales f
JOIN gold_dim_products p ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY repeat_purchase_ratio DESC;
