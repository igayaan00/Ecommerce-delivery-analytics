# 📦 E-Commerce Logistics & Delivery Performance Analysis

![Dashboard Preview](dashboard.png)

## 📌 Project Overview
An end-to-end data analytics project built to identify operational bottlenecks, shipping delays, and customer satisfaction drivers across **10,999 e-commerce orders** ($2.31M total product value). 

The project demonstrates a complete data workflow: automating data cleaning and feature engineering with **Python**, storing and querying structured data in **PostgreSQL**, and building an interactive executive dashboard in **Power BI**.

---

## 🛠️ Tech Stack
* **Python (Pandas, SQLAlchemy, Psycopg):** Automated ETL pipeline for data standardization, null/duplicate handling, weight bucketing, and discount tier classification.
* **PostgreSQL (pgAdmin 4):** Relational database storage and SQL business analysis (aggregations, CTEs, window functions).
* **Power BI Desktop:** Direct database connection and interactive executive dashboarding.

---

## 🔍 Key Business Insights
* **High Overall Delay Rate:** Out of **10,999 orders**, **6,563 deliveries were delayed** (**59.67% delay rate**), pulling the average customer rating down to **2.99 / 5.0**.
* **Promotional Bottleneck (Critical Finding):** Orders with **High Discounts (>20%)** experienced a **100% delay rate** across all weight categories (2,151 orders), indicating severe fulfillment strain during heavy discount campaigns.
* **Customer Support Friction:** **61.59% of customers** had to contact customer care **3 to 4 times** regarding their orders, highlighting a lack of proactive delivery tracking.
* **Shipping Mode Volume:** **Ship** handles the majority of order volume, while **Flight** and **Road** show similar delay patterns, proving the bottleneck is warehouse/promotional dispatch rather than transit mode alone.

---

## 💡 Strategic Recommendations
1. **Pre-Sale Logistics Scaling:** Align warehouse staffing and carrier capacity ahead of >20% discount campaigns to prevent fulfillment backlogs.
2. **Automated Delay Alerts:** Implement proactive SMS/WhatsApp tracking notifications for delayed shipments to reduce the 3–4x repeat customer support call volume.
3. **Dispatch Prioritization:** Introduce SLA-based dispatch queues separating high-discount promotional orders from standard shipments.

---

## 📂 Repository Structure
* `etl_pipeline.py` — Python script to clean raw data, engineer features, and load into PostgreSQL.
* `ecommerce_analysis.sql` — SQL queries used for KPI extraction and root-cause analysis.
* `ECOMMERCE_DELIVERY_DASHBOARD.pbix` — Interactive Power BI report file.
* `dashboard.png` — Executive dashboard preview.
* `ecommerce_orders.csv` — Raw logistics dataset (10,999 records).
*