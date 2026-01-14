# 🏬 Retail Analytics Data Warehouse & Customer RFM Segmentation

## 📌 Project Overview

This project implements a full **end-to-end retail analytics system** using a modern **Bronze–Silver–Gold data warehouse architecture**, SQL-based transformations, and **Power BI dashboards**.

It demonstrates:
- Analytics engineering
- Dimensional modeling
- Business KPI development
- Customer analytics using **RFM segmentation**
- Executive dashboarding

---

## 🏗️ Architecture

### 🔹 Bronze Layer (Raw Ingestion)
- Raw transactional sales data
- Store traffic data
- Store master data
- Minimal transformation, schema-on-read

### 🔹 Silver Layer (Clean & Conformed)
- Cleaned and standardized tables:
  - `fact_sales_net`
  - `fact_store_traffic`
  - `dim_stores`
- Data type normalization
- Deduplication
- Business key alignment

### 🔹 Gold Layer (Business Analytics)

Business-ready analytics tables & views:

- `gold.daily_store_sales`  
  → Daily KPIs per store (revenue, units, transactions, visitors, conversion rate)

- `gold.customer_rfm`  
  → Customer-level Recency, Frequency, Monetary metrics and scores

- `gold.rfm_segment_summary`  
  → Segment-level KPIs for executive reporting

Power BI views:
- `gold_vw_daily_store_sales`
- `gold_vw_customer_rfm`
- `gold_vw_rfm_segment_summary`
- `gold_vw_dim_stores`

---

## 📊 Power BI Dashboard

### KPI Cards
- Total Revenue
- Total Units Sold
- Total Transactions
- Total Visitors
- Average Conversion Rate

### Trends
- Revenue over time
- Units sold over time
- Visitors over time

### Store Performance
- Revenue by store
- Conversion rate by store
- Top / bottom performing stores

### Customer Segmentation (RFM)
Segments:
- Champions
- Loyal
- Regular
- New Customers
- At Risk
- Lost

Visuals:
- Segment size
- Segment revenue contribution
- Average recency, frequency, monetary per segment

---

## 🧮 RFM Model

Each customer is scored using:

- **Recency** → Days since last purchase
- **Frequency** → Number of purchases
- **Monetary** → Total spend

Scoring method:
- `NTILE(5)` quintile scoring for each metric
- Business rules used to assign segments

This enables:
- Churn risk detection
- High-value customer identification
- Marketing targeting strategy
- Revenue concentration analysis

---

## 🛠️ Tech Stack
- **Excel** — Data overview
- **SQL Server** — Data warehouse & transformations
- **T-SQL** — Analytics engineering & RFM logic
- **Power BI** — Semantic model & dashboards

---

## 📂 Project Structure

---

## 🚀 Key Skills Demonstrated

- Data Warehouse Architecture (Bronze/Silver/Gold)
- Fact & Dimension Modeling
- Business KPI Engineering
- Customer Segmentation (RFM)
- SQL Analytics Engineering
- Power BI Data Modeling
- Executive Dashboard Design

---

## 📈 Business Value

This system enables:

- Executive performance monitoring
- Store optimization decisions
- Customer retention strategy
- Data-driven marketing campaigns
- Churn prevention
- Revenue performance analysis

---

## 🏆 Portfolio Summary

> I built a full end-to-end retail analytics warehouse using a modern Bronze–Silver–Gold architecture, implemented customer segmentation using RFM scoring, and delivered executive dashboards in Power BI.

---

## 📸 Dashboard Preview

*(Add screenshots here)*

---

## 📄 How To Run

1. Restore / create the database in SQL Server
2. Run SQL scripts in order:
   - Bronze
   - Silver
   - Gold
   - RFM
3. Open `RetailAnalytics.pbix`
4. Refresh data
5. Explore dashboards

---

## 📜 License

This project is for educational and portfolio purposes.

