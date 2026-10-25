--*********************************--
--       RANKING ANALYSIS      --
--*********************************--

--Top 5 Products by Revenue--
SELECT TOP 5
p.product_name,
SUM(f.sales_amount) total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;

--Worst 5 Products by Revenue--
SELECT TOP 5
p.product_name,
SUM(f.sales_amount) total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC;


--Window Functions Example: Top 5 Products by Revenue--
SELECT *
FROM (
	SELECT
	p.product_name,
	SUM(f.sales_amount) total_revenue,
	ROW_NUMBER() OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_products
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p
	ON p.product_key = f.product_key
	GROUP BY p.product_name
)t
WHERE rank_products <= 5


--Top 10 Customers by Generated Revenue--
SELECT TOP 10
c.customer_key,
c.first_name,
c.last_name,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY total_revenue DESC;


--The 3 Customers with the Fewest Orders Placed--
SELECT TOP 3
c.customer_key,
c.first_name,
c.last_name,
COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY total_orders ASC;
