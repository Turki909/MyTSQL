-- ------------------------------------------------------------------------------
-- Q3 What was the first item from the menu purchased by each customer?          |
-- ------------------------------------------------------------------------------
with cte as(
	select 
		customer_id,
		product_name,
		DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY order_date) as first_product
	FROM sales INNER JOIN menu 
		on sales.product_id = menu.product_id)
SELECT distinct
	customer_id,
	product_name
FROM cte
WHERE first_product = 1;
