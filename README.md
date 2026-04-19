# E-commerce Data Analysis (SQL Project)
SQL-based E-commerce Data Analysis Projec

## Project Overview

This project focuses on analyzing an e-commerce dataset using SQL.
The goal is to extract meaningful business insights such as revenue trends, customer behavior, product performance, and payment patterns.

---

## Objectives

* Understand customer purchasing behavior
* Analyze revenue distribution across cities and states
* Identify top-performing products
* Study payment methods and installment usage
* Track monthly revenue trends

---

## Tools Used

* SQL (PostgreSQL)
* Power BI (for dashboard )
* Excel (data understanding)

---

## Dataset Description

The dataset contains the following tables:

* customers
* orders
* order_items
* products
* sellers
* payments
* reviews
* geolocation

---

## Data Model

Relational database with multiple joins:

* Customers → Orders
* Orders → Payments
* Orders → Order Items
* Order Items → Products & Sellers

---

## Key Analysis Performed

### 1. Revenue Analysis

* Total revenue calculation
* Revenue by state
* Monthly revenue trend

### 2. Customer Analysis

* Top customers by spending
* Repeat customers

### 3. Product Analysis

* Top selling products
* Highest revenue generating products

### 4. Payment Analysis

* Most used payment type
* Installment behavior

---

## Key Insights

* Certain states generate the highest revenue
* Few customers contribute heavily to total sales (Pareto effect)
* Specific products dominate total sales
* Payment methods vary significantly across regions

## 🚀 Advanced Analysis

* Built a master dataset using multi-table joins (7+ tables)
* Performed Customer Lifetime Value (CLV) analysis
* Conducted RFM segmentation (Recency, Frequency, Monetary)
* Analyzed delivery delays and logistics performance
* Evaluated seller and product category performance
* Calculated monthly growth rate using window functions
* Analyzed impact of customer reviews on revenue


---

## What I Learned

* Writing complex JOIN queries
* Data modeling using primary & foreign keys
* Aggregations (SUM, COUNT, AVG)
* Grouping and filtering data
* Time-based analysis using DATE functions
* Converting raw data into business insights

---
