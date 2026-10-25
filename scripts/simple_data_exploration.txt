--Data Exploration--
--Explore All Objects in the Database--
SELECT * FROM INFORMATION_SCHEMA.TABLES

--Explore All Columns in the Database--
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers'

--Explore All Countries our Customers Come From--
SELECT DISTINCT country FROM gold.dim_customers;

--Explore All Product Categories and Names--
SELECT DISTINCT category, subcategory, product_name FROM gold.dim_products;

--Exploration Example--
--Find the date of the first and last order--
SELECT
MIN(order_date) AS first_date,
MAX(order_date) AS last_date
FROM gold.fact_sales;

--How Many years of sales are available--
SELECT
DATEDIFF(year, MIN(order_date), MAX(order_date)) AS order_range_years
FROM gold.fact_sales;

--Find the youngest and oldest customer--
SELECT
MIN(birth_date) AS oldest_birth_date,
DATEDIFF(year, MIN(birth_date), GETDATE()) AS oldest_age,
MAX(birth_date) AS youngest_birth_date,
DATEDIFF(year, MAX(birth_date), GETDATE()) AS youngest_age
FROM gold.dim_customers;
