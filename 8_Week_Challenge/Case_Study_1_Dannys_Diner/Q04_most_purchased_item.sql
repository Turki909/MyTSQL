-- --------------------------------------------------------------------------------------------------------------
-- Q4     What is the most purchased item on the menu and how many times was it purchased by all customers? |
-- --------------------------------------------------------------------------------------------------------------
SELECT --TOP 1
	product_name,
	count(sales.product_id) as purchase_count
FROM sales
INNER JOIN menu
	ON sales.product_id = menu.product_id 
GROUP BY 
	product_name
ORDER BY 
	purchase_count DESC
OFFSET 0 ROWS FETCH NEXT 1 ROW ONLY;