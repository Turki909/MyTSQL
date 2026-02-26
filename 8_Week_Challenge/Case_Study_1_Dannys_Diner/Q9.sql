-- --------------------------------------------------------------------------------------------------------------
-- Q9				If each $1 spent equates to 10 points and sushi has a 2x points multiplier						 |
--								how many points would each customer have?										 |
-- --------------------------------------------------------------------------------------------------------------
SELECT 
	customer_id,
	SUM(CASE
			WHEN product_name = 'sushi'
				THEN (2 * (price * 10))
			ELSE (price * 10)
	END) AS points
FROM sales 
INNER JOIN menu 
	ON menu.product_id = sales.product_id
GROUP BY 
	customer_id;