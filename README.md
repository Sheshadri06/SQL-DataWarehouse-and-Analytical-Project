📊 Data Warehouse & Analytics Project (SQL Server)

📌 Project Overview

This project demonstrates the end-to-end process of building a Data Warehouse and performing Analytics using SQL Server.
The solution integrates data from two different source systems (CRM & ERP), applies ETL (Extract, Transform, Load) processes, and organizes data into a Medallion Architecture (Bronze → Silver → Gold) for structured analysis.
The final Gold Layer follows a Star Schema design with Dimension & Fact tables, enabling structured reporting and advanced analytics.

📂 Source Data

1️⃣ CRM System (source_crm)
1.cust_info.csv → Customer details
2.prd_info.csv → Product details
3.sales_details.csv → Sales transactions
2️⃣ ERP System (source_erp)
1.CUST_AZ12.csv → Additional customer attributes
2.LOC_A101.csv → Location/region mapping
3.PX_CAT_G1V2.csv → Product category details
🔄 ETL Process
    1.Extraction
Method: Pull Extraction
Type: Full Extraction
Technique: File Parsing

   2.Transformation
Data Enrichment – enhancing attributes with ERP data
Data Integration – merging CRM & ERP sources
Derived Attributes – calculated fields for analysis
Normalization & Standardization – consistent formats across tables
Business Rules & Logic – applied for sales and product mapping
Data Aggregation – summarized data for reporting

  3.Data Cleaning
Removing duplicates
Data filtering
Handling missing values
Handling invalid values
Removing unwanted spaces
Data type casting
Outlier detection

  4.Loading
Type: Batch Processing
Method: Full Load (Truncate & Insert)
Slowly Changing Dimension (SCD): Type 1 (Overwrite)

   🏗️ Data Warehouse Design
Architecture: Medallion Architecture
Bronze Layer: Raw ingestion from CRM & ERP
Silver Layer: Cleaned & transformed data
Gold Layer: Business-ready tables

Schema Design: Star Schema

   Dimension Tables:
1.dim_customer
2.dim_product

   Fact Table:
fact_sales
   Naming Convention: snake_case

📈 Data Analytics
🔍 Exploratory Data Analysis (EDA) with SQL

1.Explore all objects in the database

2.Explore product categories & subcategories

3.Find the date of the first and last order

4.Find the youngest and oldest customers

5.Calculate total sales

6.Count items sold

7.Compute average selling price

8.Find total number of orders

9.Find total number of customers

10.Find total number of products

11.Count customers that have placed an order

(These EDA steps were performed using basic SQL queries.)

📊 Advanced Analytics with SQL

1.Using complex queries, window functions, CTEs, subqueries, and reports:

2.Analyze sales performance over the year (using quick date functions, date_trunc, format)

3.Calculate total sales per month and a running total of sales

4.Compute moving average of price over time

5.Compare yearly performance of products to their average sales and previous year’s sales

6.Identify categories contributing the most to overall sales

7.Segment products into cost ranges and count products in each segment

🧑‍🤝‍🧑 Customer Segmentation Report

VIP Customers → ≥ 12 months history, spending > €5,000

Regular Customers → ≥ 12 months history, spending ≤ €5,000

New Customers → < 12 months history

Highlights:

Consolidates key customer metrics – names, ages, transaction details

Segments customers by spending behavior & age groups

Aggregates customer-level metrics:

total orders

total sales

total quantity purchased

total products

lifespan (in months)

Calculates KPIs:

recency (months since last order)

average order value (AOV)

average monthly spend

📦 Product Segmentation Report

Highlights:

Captures product details – name, category, subcategory, cost

Segments products into High-Performers, Mid-Range, Low-Performers based on revenue

Aggregates product-level metrics:

total orders

total sales

total quantity sold

total customers (unique)

lifespan (in months)

Calculates KPIs:

recency (months since last sale)

average order revenue (AOR)

average monthly revenue

⚙️ Tools & Technologies

SQL Server (T-SQL) – Data Warehouse & Analytics

CSV Data Sources – Input datasets (CRM & ERP)

SQL Server Management Studio (SSMS) – Development environment

Star Schema & Medallion Architecture – Data modeling

📌 Key Highlights

✔️ Built complete ETL pipeline (Extract → Transform → Load)
✔️ Applied data cleaning & transformation best practices
✔️ Designed a Star Schema Data Warehouse in Gold Layer
✔️ Implemented SCD Type 1 for dimension management
✔️ Performed EDA & advanced analytics using SQL
✔️ Delivered customer & product segmentation reports

🚀 How to Run

Clone this repository

git clone https://github.com/Sheshadri06/datawarehouse-analytics-sql.git
cd datawarehouse-analytics-sql


Import the CSV datasets from source_crm/ and source_erp/ into SQL Server staging tables.

Run the ETL SQL scripts in sequence (Bronze → Silver → Gold).

Query the Gold Layer (Star Schema) for analytics.

🧑‍💻 Author

Lakka Sheshadri

B.Tech Electronics & Communication Engineering (ECE), JNTU Anantapur (2027)

Aspiring Data Analyst → Data Scientist

🛠️ Skills

Technical: SQL, Python, Pandas, Power BI, Data Warehousing, Data Cleaning, Data Visualization

Analyst Skills: Storytelling with data, Communication, Business Problem-Solving, Analytical Thinking

AI Readiness: Ability to leverage AI-powered tools for automation, analysis, and reporting

📬 Connect With Me

📌 linkedin:https://www.linkedin.com/in/lakka-sheshadri-ba202a299/

📧 Email: lakkasheshadri@gmail.com
