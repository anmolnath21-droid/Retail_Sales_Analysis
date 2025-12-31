-- Create Database --
CREATE DATABASE Sales_Analysis 

-- Create Table --
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
				total_sale FLOAT
								);
-- DATA CLEANING --		
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

--- Removing Null Values---
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

-- Data Exploration --

-- How many sales transaction we have? --
SELECT
	COUNT(*) AS total_transaction
FROM retail_sales

-- How many customers we have? --
SELECT
	COUNT(customer_id) AS total_customers_id
FROM retail_sales

-- How many category we have? --
SELECT
	 DISTINCT category AS unique_category
FROM retail_sales

-- Data Analysis & Business Problems & Answers --

-- Q. Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT *
	FROM retail_sales
WHERE sale_date = '2022-11-05'

-- Q. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT *
	FROM retail_sales
WHERE category = 'Clothing' 
AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
AND quantity >=4

-- Write a SQL query to calculate the total sales (total_sale) for each category:
SELECT 
	category, 
	SUM(total_sale) AS net_sales,
	COUNT(*) AS total_orders
FROM retail_sales
	GROUP BY category
	ORDER BY SUM(total_sale) DESC

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category:
SELECT ROUND (AVG(age)) AS avg_age
	FROM retail_sales
WHERE 
	category = 'Beauty'

-- Write a SQL query to find all transactions where the total_sale is greater than 1000:
SELECT * 
	FROM retail_sales
WHERE 
	total_sale > 1000

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category:
SELECT 
	category, 
	gender, 
	count(transactions_id) AS total_transaction
FROM retail_sales
GROUP BY 
	category, gender

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
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

-- Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
	customer_id, 
	SUM(total_sale) AS total_sales
FROM retail_sales
	GROUP BY 
		customer_id
	ORDER BY 
		SUM(total_sale) DESC 
LIMIT 5

-- Write a SQL query to find the number of unique customers who purchased items from each category:
SELECT
	category,
	COUNT (DISTINCT customer_id) 
FROM retail_sales
GROUP BY category

-- End of the project --