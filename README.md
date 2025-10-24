# Data-Warehouse-Project

## 🌟 Welcome to My Data Warehouse & Analytics Project!

This project is a **complete, end-to-end data warehousing and analytics solution** designed to showcase practical, real-world data engineering and analytics skills.

Built entirely with **MySQL**, it simulates a **production-grade data warehouse** that integrates **ERP and CRM sales data** to uncover meaningful, data-driven business insights.

### 💡 What This Project Demonstrates

- **Modern Data Architecture:** A clean, scalable warehouse design following best practices.
- **ETL Pipelines:** Automated and optimized data extraction, transformation, and loading workflows.
- **Data Modeling:** A well-structured schema built for analytics performance and flexibility.
- **SQL Analytics:** Advanced SQL queries and dashboards that deliver actionable insights for decision-making.

---

Single MySQL schema with **prefix-based layering** (bronze_, silver_, gold_) — no separate databases needed.

| Layer | Purpose | Implementation |
| --- | --- | --- |
| **Bronze** | Raw ingestion | bronze_erp_*, bronze_crm_* tables loaded via LOAD DATA INFILE |
| **Silver** | Cleansed & validated | silver_erp_*, silver_crm_* with deduplication, standardization, joins |
| **Gold** | Analytics-ready | Star schema: gold_fact_sales, gold_dim_customer, gold_dim_product |

> MySQL Workbench used for design, execution, and visualization.
> 

---

## 📘Project Overview

A full-cycle data pipeline from **raw CSV → clean warehouse → business insights**:

| Phase | What I Built |
| --- | --- |
| **Data Architecture** | Medallion layers using **table prefixes** in a single MySQL DB |
| **ETL Pipelines** | LOAD DATA, INSERT...SELECT, UPDATE scripts for full & incremental loads |
| **Data Modeling** | **Star Schema** in Gold layer for fast analytical queries |
| **Analytics & Reporting** | SQL reports on customer behavior, product performance, and sales trends |

---

## 🚀 Project Requirements

### 🏗️ Building the Data Warehouse (Data Engineering)

🎯 Objective:

Design and implement a **scalable, query-optimized data warehouse** using **MySQL** to integrate sales data from **ERP and CRM systems**, enabling **fast, reliable analytical reporting** and **data-driven decision-making**.

---

📋 Specifications:
| **Requirement**      | **Implementation**                                                                                                                                                                                                                              |
| -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Data Sources**     | Import **CSV files** from two source systems — **ERP** and **CRM** — containing sales, customer, and product data.                                                                                                                              |
| **Data Ingestion**   | Load raw data into **Bronze Layer** tables using:<br>• `LOAD DATA INFILE` commands<br>• or **MySQL Workbench Table Data Import Wizard**                                                                                                         |
| **Data Quality**     | Perform thorough data cleansing to address:<br>• Duplicate records<br>• Inconsistent naming or formatting<br>• Missing values<br>• Data type mismatches                                                                                         |
| **Data Integration** | Combine overlapping entities (e.g., **customers**, **products**) from ERP and CRM into **unified Silver Layer** tables using **common business keys** for consistency.                                                                          |
| **Data Modeling**    | Design a **star schema** in the **Gold Layer**, consisting of:<br>• `gold.fact_sales` – central fact table<br>• `gold.dim_customers`, `gold.dim_products` – supporting dimension tables                                                         |
| **Scope**            | Process only the **latest snapshot** of data; **no historical tracking** (no Slowly Changing Dimensions required).                                                                                                                              |
| **Documentation**    | Provide comprehensive documentation of the data model and pipeline to support both technical and non-technical stakeholders. |
| **Environment**      | Implemented in **MySQL 8.0+**, using a single schema named **`DataWarehouse`**, structured with **layer prefixes**:<br>• `bronze_` (raw)<br>• `silver_` (cleansed/integrated)<br>• `gold_` (analytical)                                         |

--- 
## 👩🏻‍💻Author
**Aimen Zikra**

Data Analyst | Python | Data Visualization 
