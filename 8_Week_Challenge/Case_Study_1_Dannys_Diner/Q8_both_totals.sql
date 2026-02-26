-- --------------------------------------------------------------------------------------------------------------
-- 			  What is the total items and amount spent for each member before they became a member?              |
-- --------------------------------------------------------------------------------------------------------------
SELECT 
	s.customer_id,
	COUNT(s.product_id) AS total_count,
	SUM(price) AS total_spent


FROM sales AS s
INNER JOIN members as mem
	ON s.customer_id = mem.customer_id
	AND s.order_date < mem.join_date
INNER JOIN menu as m
	ON m.product_id = s.product_id
GROUP BY 
	s.customer_id;