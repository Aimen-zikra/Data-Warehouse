# 🗂️ Data Catalog — Gold Layer

### 📘 Overview

The **Gold Layer** represents the **business-ready data layer** within the warehouse — optimized for analytics, reporting, and decision-making.

It contains **dimension tables** (for descriptive context) and **fact tables** (for measurable business events), following a **star schema design** to ensure performance and simplicity for BI queries.

---

### 🧩 1. `gold_dim_customers`

**📖 Purpose:**

Holds enriched customer information, combining demographic and geographic attributes to support customer-centric analytics.

| Column Name | Data Type | Description |
| --- | --- | --- |
| `customer_key` | INT | Surrogate key uniquely identifying each customer record in the dimension. |
| `customer_id` | INT | Source-system unique identifier for the customer. |
| `customer_number` | NVARCHAR(50) | Alphanumeric code representing the customer for tracking and reference. |
| `first_name` | NVARCHAR(50) | Customer’s given name. |
| `last_name` | NVARCHAR(50) | Customer’s family name or surname. |
| `country` | NVARCHAR(50) | Customer’s country of residence (e.g., *Australia*). |
| `marital_status` | NVARCHAR(50) | Marital status (e.g., *Married*, *Single*). |
| `gender` | NVARCHAR(50) | Gender of the customer (e.g., *Male*, *Female*, *n/a*). |
| `birthdate` | DATE | Date of birth in `YYYY-MM-DD` format (e.g., *1971-10-06*). |
| `create_date` | DATE | Date the customer record was first created in the source system. |

---

### 📦 2. `gold_dim_products`

**📖 Purpose:**

Contains detailed information about products, their classification, and key business attributes for product performance analysis.

| Column Name | Data Type | Description |
| --- | --- | --- |
| `product_key` | INT | Surrogate key uniquely identifying each product record. |
| `product_id` | INT | Source-system unique identifier for each product. |
| `product_number` | NVARCHAR(50) | Structured alphanumeric product code used for internal tracking. |
| `product_name` | NVARCHAR(50) | Descriptive name including product details (type, color, size). |
| `category_id` | NVARCHAR(50) | Identifier for the product’s category for hierarchical classification. |
| `category` | NVARCHAR(50) | Broad classification of the product (e.g., *Bikes*, *Components*). |
| `subcategory` | NVARCHAR(50) | Sub-classification providing more detailed grouping within the category. |
| `maintenance_required` | NVARCHAR(50) | Indicates whether the product requires maintenance (*Yes* / *No*). |
| `cost` | INT | Base cost of the product in whole currency units. |
| `product_line` | NVARCHAR(50) | Product line or series (e.g., *Road*, *Mountain*). |
| `start_date` | DATE | Date when the product became available for sale. |

---

### 💰 3. `gold_fact_sales`

**📖 Purpose:**

Captures transactional-level sales data used for analytical reporting, KPI tracking, and business performance insights.

| Column Name | Data Type | Description |
| --- | --- | --- |
| `order_number` | NVARCHAR(50) | Unique alphanumeric identifier for each sales order (e.g., *SO54496*). |
| `product_key` | INT | Foreign key linking to the **Product Dimension** (`gold_dim_products`). |
| `customer_key` | INT | Foreign key linking to the **Customer Dimension** (`gold_dim_customers`). |
| `order_date` | DATE | Date when the order was placed. |
| `shipping_date` | DATE | Date when the order was shipped to the customer. |
| `due_date` | DATE | Payment due date for the order. |
| `sales_amount` | INT | Total monetary value of the sale (per line item). |
| `quantity` | INT | Number of product units sold in the line item. |
| `price` | INT | Unit price of the product at the time of sale. |

---

###
