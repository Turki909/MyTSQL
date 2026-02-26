-- --------------------------------------------------------------------------------------------------------------
--   Q5                         Which item was the most popular for each customer?                                 |
-- --------------------------------------------------------------------------------------------------------------
WITH cte AS(
	SELECT 
		customer_id,
		product_name,
		COUNT(product_name) as product_count,
		rank() OVER(
			PARTITION BY customer_id 
			ORDER BY COUNT(product_name) DESC
			) AS rnk
	FROM sales
	INNER JOIN menu 
		ON sales.product_id = menu.product_id
	GROUP BY 
		customer_id,
		product_name
)

SELECT
	customer_id,
	product_name,
	product_count
FROM cte
WHERE 
	rnk = 1
ORDER BY 
	customer_id ASC;