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
<img width="727" height="413" alt="babadox pb1" src="https://github.com/user-attachments/assets/61679ad9-7030-466e-a276-759e0b63ead2" />

---

## 📊 RFM Analysis Results

The RFM (Recency, Frequency, Monetary) model was applied to segment customers based on purchasing behavior and business value.

Each customer was scored using quintile (1–5) scoring for:
- **Recency**: How recently the customer purchased
- **Frequency**: How often the customer purchases
- **Monetary**: How much the customer spends

These scores were combined using business rules to assign customers into actionable segments.

---

## 🧩 Customer Segments

The model produced the following business segments:

- **🏆 Champions** — Most recent, most frequent, highest spenders
- **💎 Loyal** — Frequent and high-value repeat customers
- **🧍 Regular** — Average customers with stable behavior
- **🆕 New Customers** — Recently acquired but not yet loyal
- **⚠️ At Risk** — Previously good customers who are becoming inactive
- **❌ Lost** — Inactive customers with long time since last purchase

---

## 💰 Revenue Contribution by Segment

After correcting the RFM scoring using proper quintile distribution:

| Segment        | Business Interpretation |
|----------------|-------------------------|
| **Champions**  | Highest revenue contributors and most valuable customers |
| **At Risk**    | Large revenue base but declining activity — top priority for win-back |
| **Regular**    | Stable mid-tier revenue contributors |
| **Loyal**      | Strong recurring revenue base |
| **New Customers** | Growing segment with upsell potential |
| **Lost**       | Low ROI segment — minimal marketing investment recommended |

---

## 🧠 Strategic Insights

- **Champions + Loyal** represent the core revenue engine and should be protected with loyalty programs.
- **At Risk** customers represent a major revenue leakage risk and should be targeted with reactivation campaigns.
- **Regular** customers are strong candidates for upsell and cross-sell.
- **New Customers** should be nurtured into Loyal and Champions.
- **Lost** customers should not be a primary marketing focus due to low expected ROI.

---

## 🏁 Business Impact

This RFM model enables:
- Data-driven marketing budget allocation
- Customer retention prioritization
- Churn prevention strategies
- High-value customer identification
- Revenue concentration analysis

---

## ✅ Conclusion

The RFM segmentation produced a **realistic and business-actionable customer distribution**, where:

> High-value segments (Champions & Loyal) drive the majority of revenue, while lower-value segments contribute significantly less — matching real-world retail behavior.

This confirms both the **technical correctness** and **business credibility** of the model.


## 📜 License

This project is for educational and portfolio purposes.

