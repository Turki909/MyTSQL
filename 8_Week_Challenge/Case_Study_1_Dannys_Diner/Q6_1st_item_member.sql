-- --------------------------------------------------------------------------------------------------------------
-- 				 Which item was purchased first by the customer after they became a member?                   |
-- --------------------------------------------------------------------------------------------------------------
WITH cte as(
	SELECT 
		s.customer_id AS customer,
		join_date,
		order_date,
		product_name,
		RANK() OVER(
			PARTITION BY s.customer_id
			ORDER BY s.order_date ASC
			) AS order_rank
	FROM sales as s
	INNER JOIN members 
		ON s.customer_id = members.customer_id
		AND s.order_date >= members.join_date
	INNER JOIN menu
		ON menu.product_id = s.product_id
)

SELECT 
	customer,
	product_name
FROM cte
WHERE order_rank = 1;