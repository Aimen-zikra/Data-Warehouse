## Data Analytics: Deliver Actionable Insights

**Objective**  
Leverage **production-grade SQL** and **Python (Pandas)** to extract deep business intelligence from sales, customer, and product data — delivering **KPIs**, **trend analysis**, and **strategic recommendations** to drive revenue, retention, and operational efficiency.

> **Dual-Stack Approach**:  
> - **SQL**: Scalable, production-ready queries on a **gold-layer data warehouse**  
> - **Python (Pandas)**: Rapid validation, transformation, and visualization  
> **Result**: 100% consistency across both tools — enterprise-grade reliability

---

### Tech Stack
| Tool | Purpose |
|------|-------|
| **MySQL** | Core analytics on `gold_fact_sales`, `gold_dim_*` |
| **Python (Pandas, NumPy)** | Data validation, automation, and plotting |
| **Jupyter Notebook** | Reproducible analysis & documentation |
---

## Analysis Performed Using **Both SQL and Python**

| Insight | SQL Query | Python (Pandas) |
|-------|----------|-----------------|
| **Total Revenue** | [`business_metrics.sql`](./business_metrics.sql) | `df['sales_amount'].sum()` |
| **Monthly Revenue & MoM Growth** | [`business_metrics.sql`](./business_metrics.sql) | `df.groupby('month')['sales_amount'].sum()` |
| **Top 10 Products by Revenue** | [`business_metrics.sql`](./business_metrics.sql) | `df.merge(products).groupby('product_name')...` |
| **Customer Lifetime Value** | `JOIN` on `gold_dim_customers` | `df.groupby('customer_key').agg(...)` |
| **Profit Margin per Product** | `SUM(sales - cost)` | `df['profit'] = df['sales'] - df['cost']` |

> **All SQL outputs validated in Pandas** → **Zero discrepancies**

---

## Key Analytical Reports

| Report | Output | Business Value |
|-------|--------|----------------|
| **Top 10 Products by Revenue** | Product, Category, Revenue, Units | Focus inventory & marketing |
| **Customer Lifetime Value (CLTV)** | Customer ID, Total Spent, Orders | Segment VIPs & at-risk |
| **Monthly Sales Growth (MoM)** | Month, Revenue, % Change | Detect seasonality & trends |
| **Regional Sales Performance** | Country, Revenue, % Share | Optimize logistics & ads |
| **Category Profitability** | Category, Revenue, Margin | Prioritize R&D |
| **Repeat Purchase Rate** | Product, Repeat Ratio | Measure loyalty |

---

## Core SQL Queries (Production-Ready)


```sql
-- Total Revenue
SELECT ROUND(SUM(sales_amount), 2) AS total_revenue FROM gold_fact_sales;

-- Monthly Growth Rate
WITH monthly_sales AS (
    SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(sales_amount) AS revenue
    FROM gold_fact_sales GROUP BY month
)
SELECT 
    m1.month,
    ROUND(m1.revenue, 2),
    ROUND(((m1.revenue - m2.revenue) / m2.revenue) * 100, 2) AS growth_pct
FROM monthly_sales m1
LEFT JOIN monthly_sales m2 ON m1.month = DATE_ADD(m2.month, INTERVAL 1 MONTH);
