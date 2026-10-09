# 🛒 E-Commerce Revenue & Operational Performance Analytics

📊 An end-to-end data analytics project using **MySQL, Python, Power BI, and Excel** to analyze order value, product and seller performance, delivery operations, and customer satisfaction.

## 📌 Project Overview

E-commerce businesses need to understand order-value trends, identify high-performing product categories and sellers, and investigate delivery issues that may affect customer experience.

This project analyzes the **Brazilian E-Commerce Public Dataset by Olist** to uncover business trends, evaluate operational performance, and develop data-driven recommendations.

🎯 **Business Objective:** Transform raw transactional and operational data into actionable insights that support business monitoring and operational decision-making.

## ❓ Business Questions

* 📈 How does total order value change over time?
* 🛍️ Which product categories generate the highest order value and order volume?
* 🏪 How do seller performance and delivery outcomes differ?
* 🚚 Which product categories have higher late-delivery rates?
* ⭐ How are delivery performance and customer review scores associated?
* 💳 How is payment value distributed across payment methods?
* 💡 Which operational areas should be prioritized for further investigation?

## 🧰 Tools & Technologies

| Tool        | Purpose                                                                  |
| ----------- | ------------------------------------------------------------------------ |
| 🐬 MySQL    | SQL queries, joins, aggregations, and business analysis                  |
| 🐍 Python   | Data cleaning, validation, feature engineering, and exploratory analysis |
| 🐼 Pandas   | Data manipulation and analysis                                           |
| 📊 Power BI | Interactive dashboards, KPIs, and trend analysis                         |
| 📗 Excel    | Supporting data validation and quality checks                            |

## 📂 Dataset

**Source:** Brazilian E-Commerce Public Dataset by Olist.

The dataset contains information about orders, customers, sellers, products, payments, reviews, and geolocation.

| Dataset                  |                Approximate records |
| ------------------------ | ---------------------------------: |
| 🧾 Orders                |                             99,441 |
| 👥 Customers             |                             99,441 |
| 📦 Order Items           |                            112,650 |
| 💳 Payments              |                            103,886 |
| 🛍️ Products             |                             32,951 |
| 🏪 Sellers               |                              3,095 |
| ⭐ Reviews                | 99,224 in the original Python load |
| 📍 Geolocation           |                          1,000,163 |
| 🗂️ Category Translation |                                 71 |



## 🧹 Data Preparation & Validation

Python was used to assess data quality before analysis.

Key activities included:

* 🔍 Examining missing values and duplicate records.
* 📅 Converting order timestamps into datetime format.
* 🔗 Validating relationships between orders, customers, products, sellers, payments, and reviews.
* 🧮 Checking selected numeric fields for invalid or zero values.
* 🚚 Creating delivery-duration and delivery-delay metrics.
* 💰 Calculating item-level order value as product price plus freight.
* 🗂️ Reviewing missing product-category translations without automatically deleting affected records.

Missing values were assessed in context rather than filled or removed indiscriminately.

## 💻 SQL Business Analysis

MySQL queries were developed to investigate:

* 📈 Monthly order-value trends.
* 🛍️ Product-category performance.
* 🏪 Seller performance by order value and order volume.
* 🚚 Late-delivery rates by product category.
* ⭐ Delivery performance in relation to customer review scores.
* 💳 Payment-method distribution.
* 📊 Seller-level delivery performance.

**SQL concepts used:** Joins, aggregate functions, conditional logic, grouping, filtering, and distinct order counts.

## 🔎 Key Business Findings

### 🛍️ 1. Product Category Performance

* **Health & Beauty** recorded approximately **R$1.44 million** in total order value in the recorded SQL analysis.
* **Bed, Bath & Table** recorded **9,417 orders**, the highest order count among the categories in the recorded results.


### 📈 2. Monthly Order-Value Trends

* **November 2017** recorded approximately **R$1.18 million** in total order value, the highest monthly value in the recorded SQL results.

💡 **Business implication:** Historical monthly trends can help businesses investigate demand peaks and plan inventory and fulfillment capacity. The analysis does not establish the cause of the peak.

### 🚚 3. Delivery Performance by Product Category

* **Audio** recorded a **12.86% late-delivery rate** among categories with at least 100 orders in the recorded analysis.
* **Health & Beauty** had 776 late orders.
* **Bed, Bath & Table** had 811 late orders.

💡 **Business implication:** Operational teams should consider both late-delivery rates and the number of affected orders when prioritizing categories for investigation.

### 🏪 4. Seller Performance

The recorded analysis showed differences in delivery performance across sellers:

* A seller in Lauro de Freitas recorded a **4.19% late-delivery rate** across 358 orders.
* A seller in Guariba recorded an **11.48% late-delivery rate** across 1,132 orders.

💡 **Business implication:** A seller scorecard combining order value, order volume, and late-delivery rate could help identify sellers requiring further operational review. These figures alone do not explain the reasons for the differences.

### 💳 5. Payment-Method Distribution

* Credit cards accounted for approximately **78.34% of total payment value** in the recorded analysis.
* Vouchers accounted for **5.56% of payment transactions** and approximately **2.37% of total payment value**.

💡 **Business implication:** Monitoring payment-method distribution can help businesses understand how payment value is distributed across payment methods.

## 📊 Power BI Dashboard

The Power BI report contains three analytical pages:

### 📌 Page 1 — E-Commerce Business Performance Overview

Provides a high-level view of order volume, total order value, average order value, review scores, delivery performance, and payment distribution.

### 🛍️ Page 2 — Sales & Product Performance Analysis

Examines seller performance, high-value products, item pricing, freight value, and monthly freight trends.

### 🚚 Page 3 — Delivery & Operational Performance Analysis

Focuses on late orders, delivery duration, delivery trends, and operational performance breakdowns.


## 💡 Business Recommendations

Based on the recorded findings, the following actions are proposed for further investigation:

1. 🚚 Monitor late deliveries and investigate patterns by seller and product category.
2. 🏪 Develop seller scorecards using order volume, order value, and late-delivery rate.
3. 📦 Consider category demand and delivery risk when planning fulfillment capacity.
4. 📅 Review historical monthly order-value trends when planning inventory and operations.
5. 💳 Track payment-method distribution to understand the composition of payment value.


## 🎯 Conclusion

This project demonstrates an end-to-end data analytics workflow involving data validation, SQL-based business analysis, Python data preparation, and Power BI dashboard development.

It translates transactional and operational data into measurable findings and recommendations for further business investigation.

---

✨ **Skills Demonstrated:** SQL | Python | Pandas | Data Cleaning | Exploratory Data Analysis | Power BI | KPI Reporting | Business Analysis | Data Visualization
