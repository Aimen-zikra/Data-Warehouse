# Enterprise Sales Data Warehouse
> End-to-end data warehousing solution built in MySQL — from raw ERP/CRM ingestion to analytics-ready star schema, validated against Python.

---

## Overview

This project simulates a production-grade data warehouse that integrates sales data from two source systems (ERP and CRM) into a unified, query-optimised schema. The pipeline covers every stage: raw ingestion, cleansing, conflict resolution, dimensional modelling, and analytical reporting — all implemented in MySQL with cross-validation in Python (pandas).

**Core question answered:** How do you turn messy, overlapping data from two systems into a single trusted source for business reporting?

---

## Project Overview

A full-cycle data pipeline from **raw CSV → clean warehouse → business insights**:

| Phase | What I Built |
| --- | --- |
| **Data Architecture** | Medallion layers using **table prefixes** in a single MySQL DB |
| **ETL Pipelines** | LOAD DATA, INSERT...SELECT, UPDATE scripts for full & incremental loads |
| **Data Modeling** | **Star Schema** in Gold layer for fast analytical queries |
| **Analytics & Reporting** | SQL reports on customer behavior, product performance, and sales trends |


## Architecture — Medallion Layers

All layers live in a single MySQL schema (`DataWarehouse`) using prefix-based separation:

| Layer | Prefix | Purpose |
|-------|--------|---------|
| Bronze | `bronze_` | Raw ingestion via `LOAD DATA INFILE` — no transformations |
| Silver | `silver_` | Cleansed, deduplicated, standardised; ERP/CRM conflicts resolved |
| Gold | `gold_` | Star schema optimised for analytical queries |

---
---

## Tech Stack

| Tool | Purpose |
|------|---------|
| MySQL 8.0 | Data warehouse, ETL, all analytical queries |
| Python (pandas, NumPy) | Cross-validation and visualisation |
| Jupyter Notebook | Reproducible analysis and documentation |
| MySQL Workbench | Schema design and execution |


---

 Specifications:
| **Requirement**      | **Implementation**                                                                                                                                                                                                                              |
| -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Data Sources**     | Import **CSV files** from two source systems — **ERP** and **CRM** — containing sales, customer, and product data.                                                                                                                              |
| **Data Ingestion**   | Load raw data into **Bronze Layer** tables using:<br>• `LOAD DATA INFILE` commands<br>• or **MySQL Workbench Table Data Import Wizard**                                                                                                         |
| **Data Quality**     | Perform thorough data cleansing to address:<br>• Duplicate records<br>• Inconsistent naming or formatting<br>• Missing values<br>• Data type mismatches                                                                                         |
| **Data Integration** | Combine overlapping entities (e.g., **customers**, **products**) from ERP and CRM into **unified Silver Layer** tables using **common business keys** for consistency.                                                                          |
| **Data Modeling**    | Design a **star schema** in the **Gold Layer**, consisting of:<br>• `gold_fact_sales` – central fact table<br>• `gold_dim_customers`, `gold_dim_products` – supporting dimension tables                                                         |
| **Scope**            | Process only the **latest snapshot** of data; **no historical tracking** (no Slowly Changing Dimensions required).                                                                                                                              |
| **Documentation**    | Provide comprehensive documentation of the data model and pipeline to support both technical and non-technical stakeholders. |
| **Environment**      | Implemented in **MySQL 8.0+**, using a single schema named **`DataWarehouse`**, structured with **layer prefixes**:<br>• `bronze_` (raw)<br>• `silver_` (cleansed/integrated)<br>• `gold_` (analytical)                                         |
## Data Model — Star Schema
```
gold_fact_sales
    ├── product_key → gold_dim_products
    └── customer_key → gold_dim_customers
```

**Key modelling decisions:**
- Surrogate keys generated via `ROW_NUMBER() OVER()` — decouples the warehouse from unstable source IDs
- CRM treated as master source for customer attributes; ERP used as fallback via `COALESCE` where CRM fields are null
- Latest snapshot only — no Slowly Changing Dimensions required for this scope

---

## ETL Pipeline

**Bronze → Silver**
- `LOAD DATA INFILE` for raw CSV ingestion across 6 source tables
- Duplicate detection and removal in Silver layer
- Text standardisation and data type casting
- NULL handling with documented fallback logic

**Silver → Gold**
- `INSERT...SELECT` to populate fact and dimension tables
- Surrogate key assignment on dimension tables
- Final validation before analytical queries

---

## Analytics — 10 Production SQL Queries

All queries run against the Gold layer and were cross-validated against Python (pandas) with 100% output consistency.

| Query | Business Value |
|-------|---------------|
| Monthly Revenue & MoM Growth | Detect seasonality and trends |
| Top 10 Products by Revenue | Focus inventory and marketing |
| Customer Lifetime Value (CLV) | Segment high-value customers |
| Profit Margin per Product | Prioritise category investment |
| Regional Revenue by Country | Optimise logistics and targeting |
| Average Order Value (AOV) | Track purchase behaviour |
| Category Performance | Revenue and volume by category |
| Revenue by Demographics | Gender and marital status segmentation |
| Repeat Purchase Rate | Measure product loyalty |
| Product Line Revenue Over Time | Track portfolio trends monthly |

**MoM Growth — implementation note:**  
Month-over-month comparison uses a CTE self-join with `DATE_ADD(..., INTERVAL 1 MONTH)` for correct handling of year boundaries (e.g. December → January).

---

## Validation

SQL outputs were independently replicated in Python (pandas) for every aggregate metric. Zero discrepancies found — confirming pipeline integrity end-to-end.

--- 
## 👩🏻‍💻Author
**Aimen Zikra**

Data Analyst | Python | Data Visualization 
