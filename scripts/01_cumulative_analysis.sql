--******************************************--
--           CUMULATIVE ANALYSIS            --
--******************************************--


--Total Sales per Month--
SELECT
DATETRUNC(month, order_date) AS order_date,
SUM(sales_amount) AS total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
ORDER BY DATETRUNC(month, order_date);


--Running Total Sales Over Time--
SELECT
order_date,
total_sales,
SUM(total_sales) OVER (ORDER BY order_date ASC) AS running_total_sales
FROM
(
	SELECT
	DATETRUNC(month, order_date) AS order_date,
	SUM(sales_amount) AS total_sales
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(month, order_date)
)t
;


--Running Total Sales Over Time by Year (dodamo PARTITION BY)--
SELECT
order_date,
total_sales,
SUM(total_sales) OVER (PARTITION BY order_date ORDER BY order_date ASC) AS running_total_sales
FROM
(
	SELECT
	DATETRUNC(month, order_date) AS order_date,
	SUM(sales_amount) AS total_sales
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(month, order_date)
)t
;


--Moving Average of the Price--
SELECT
order_date,
total_sales,
SUM(total_sales) OVER (ORDER BY order_date ASC) AS running_total_sales,
AVG(avg_price) OVER (ORDER BY order_date ASC) AS moving_avg_price
FROM
(
	SELECT
	DATETRUNC(year, order_date) AS order_date,
	SUM(sales_amount) AS total_sales,
	AVG(price) AS avg_price
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(year, order_date)
)t
;
