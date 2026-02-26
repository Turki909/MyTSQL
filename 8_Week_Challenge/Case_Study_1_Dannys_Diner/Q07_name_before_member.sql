-- --------------------------------------------------------------------------------------------------------------
-- Q7		   Which item was purchased just before the customer became a member?                            |
-- --------------------------------------------------------------------------------------------------------------

WITH cte as (
	SELECT 
		s.customer_id AS customer,
		join_date,
		order_date,
		product_name AS product,
		RANK() OVER(
			PARTITION BY s.customer_id
			ORDER BY order_date DESC
			) AS last_purchase
	FROM sales as s
	INNER JOIN members 
		ON s.customer_id = members.customer_id
		AND s.order_date < members.join_date
	INNER JOIN menu
		ON menu.product_id = s.product_id
)

SELECT 
	customer,
	product
FROM cte
WHERE last_purchase = 1;
