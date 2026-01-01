# SQL Retail Sales Analysis

## Project Overview
This project analyzes retail sales data using SQL to answer key business questions
such as customer behavior, category performance, monthly sales trends, and best-selling periods.

## Tools & Technologies
- SQL (PostgreSQL)
- GitHub
- CSV Dataset

## Dataset
- `retail_sales_raw.csv` – original dataset
- `retail_sales_cleaned.csv` – cleaned dataset after removing NULL values

## Key Business Questions Answered
- Total sales by category
- Best selling month in each year
- Customer demographics analysis
- High-value transactions
- Monthly & yearly sales trends

## Key Insights
- Clothing and Electronics generate the highest revenue
- November shows peak sales due to festive season
- Female customers contribute higher transaction count in Beauty category

## How to Run
1. Create database
2. Run SQL files in order from `sql/` folder
3. Analyze outputs

## Project Structure

**Create Database**
``` sql 
CREATE DATABASE Sales_Analysis;
```								
**Create Table**
``` sql 
CREATE TABLE Retail_Sales(
				transactions_id INT PRIMARY KEY,
				sale_date DATE,
				sale_time TIME,
				customer_id INT,
				gender VARCHAR (20),
				age INT,
				category VARCHAR (20),
				quantity INT,
				price_per_unit FLOAT,
				cogs FLOAT,
				total_sale FLOAT );

```
**Data Exploration & Cleaning**

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

**DATA CLEANING**
```sql 
SELECT
	* 
	FROM Retail_sales
WHERE (
	transactions_id IS NULL
	OR sale_date IS NULL
	OR sale_time IS NULL
	OR customer_id IS NULL
	OR gender IS NULL
	OR category IS NULL
	OR quantity IS NULL
	OR price_per_unit IS NULL
	OR cogs IS NULL
	OR total_sale IS NULL );
```
**Removing Null Values**
``` sql 
DELETE 
	FROM retail_sales
WHERE (
	transactions_id IS NULL
	OR sale_date IS NULL
	OR sale_time IS NULL
	OR customer_id IS NULL
	OR gender IS NULL
	OR category IS NULL
	OR quantity IS NULL
	OR price_per_unit IS NULL
	OR cogs IS NULL
	OR total_sale IS NULL);
```
## Data Analysis and findings
**The following sql query were developed to answer specific business questions** 

**How many sales transaction we have?**
``` sql
SELECT
	COUNT(*) AS total_transaction
FROM retail_sales
```
**How many customers we have?**
```sql
SELECT
	COUNT(customer_id) AS total_customers_id
FROM retail_sales
```
**How many category we have?**
```sql
SELECT
	 DISTINCT category AS unique_category
FROM retail_sales
```
## Data Analysis & Business Problems & Answers

**Write a SQL query to retrieve all columns for sales made on '2022-11-05:**
``` sql
SELECT *
	FROM retail_sales
WHERE sale_date = '2022-11-05'
```

**Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:**
``` sql
SELECT *
	FROM retail_sales
WHERE category = 'Clothing' 
AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
AND quantity >=4
```
**Write a SQL query to calculate the total sales (total_sale) for each category:**

``` sql
SELECT 
	category, 
	SUM(total_sale) AS net_sales,
	COUNT(*) AS total_orders
FROM retail_sales
	GROUP BY category
	ORDER BY SUM(total_sale) DESC
```

**Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category:**
``` sql
SELECT ROUND (AVG(age)) AS avg_age
	FROM retail_sales
WHERE 
	category = 'Beauty'
```

**Write a SQL query to find all transactions where the total_sale is greater than 1000:**
```sql
SELECT * 
	FROM retail_sales
WHERE 
	total_sale > 1000
```
**Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category:**
``` sql
SELECT 
	category, 
	gender, 
	count(transactions_id) AS total_transaction
FROM retail_sales
GROUP BY 
	category, gender
```
**Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:**
``` sql
SELECT
	year,
	month,
	avg_sales
FROM (
SELECT
	EXTRACT (YEAR FROM sale_date) AS year,
	EXTRACT (MONTH FROM sale_date) AS month,
	avg(total_sale) AS avg_sales,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY avg(total_sale) DESC) AS rank
FROM retail_sales
GROUP BY 1, 2 
) AS t
WHERE rank = 1
```

**Write a SQL query to find the top 5 customers based on the highest total sales**  
``` sql

SELECT 
	customer_id, 
	SUM(total_sale) AS total_sales
FROM retail_sales
	GROUP BY 
		customer_id
	ORDER BY 
		SUM(total_sale) DESC 
LIMIT 5
```

**Write a SQL query to find the number of unique customers who purchased items from each category:**
``` sql
SELECT
	category,
	COUNT (DISTINCT customer_id) 
FROM retail_sales
GROUP BY category
```
## SQL Retail Sales Analysis – Findings & Report

**Data Overview**
**The dataset contains retail sales transactions with customer demographics, product categories, pricing, and sales values.**
**Data cleaning was performed by removing records with NULL values to ensure accuracy and reliability of analysis.**
**Analysis covers transaction trends, customer behavior, category performance, and time-based sales patterns.**

## Key Findings

**Multiple product categories contribute to sales, with Clothing emerging as a top-performing category.**
**November is the best-selling month, showing strong seasonal demand.**
**A small group of high-value customers contributes a large share of total revenue.**
**High-value transactions (total_sale > 1000) significantly impact overall sales.**
**Customer demographics (age & gender) influence purchasing behavior across categories.**
**Sales patterns show clear monthly and yearly seasonality.**
**Data cleaning improved analysis accuracy by removing incomplete records.**

## Conclusion
**This SQL Retail Sales Analysis demonstrates how structured SQL queries can be used to derive actionable business insights from raw transactional data.**
## Key Takeaways:
**Seasonal trends significantly impact sales performance.**
**Customer demographics play a crucial role in category-wise sales.**
**High-value customers contribute disproportionately to revenue.**
**Data cleaning is essential to ensure reliable analytical outcomes.**

## Business Recommendations:

**Focus marketing campaigns around peak months (November).**
**Introduce loyalty programs for top customers.**
**Tailor promotions based on gender and category preferences.**
**Strengthen inventory planning for high-demand categories.**


