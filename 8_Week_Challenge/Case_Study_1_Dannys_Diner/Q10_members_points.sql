-- --------------------------------------------------------------------------------------------------------------
-- 	Q10			In the first week after a customer joins the program (including their join date)				|
--							 they earn 2x points on all items, not just sushi -									|		
--					how many points do customer A and B have at the end of January?								|
-- --------------------------------------------------------------------------------------------------------------
SELECT 
	sales.customer_id,
	SUM(CASE
			WHEN order_date BETWEEN join_date AND DATEADD(DAY,6,join_date)
				THEN (2 * (price * 10))
			WHEN product_name = 'sushi' 
				THEN (2 * (price * 10))
			ELSE (price * 10)
		END) AS members_points
FROM sales 
INNER JOIN menu 
	ON menu.product_id = sales.product_id
INNER JOIN members 
	ON members.customer_id = sales.customer_id
WHERE order_date < '20210201'
GROUP BY 
	sales.customer_id;