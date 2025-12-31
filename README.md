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

## -- Create Database --
```  sql 
CREATE DATABASE Sales_Analysis;
								

```sql
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
