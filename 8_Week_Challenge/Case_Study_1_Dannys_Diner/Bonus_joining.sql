CREATE OR ALTER VIEW joined_things
AS

SELECT 
	sales.customer_id,
	order_date,
	product_name,
	price,
	CASE
		WHEN sales.order_date < members.join_date
			OR members.join_date IS NULL
			THEN 'N'
		ELSE 'Y'
	END AS member
FROM sales
INNER JOIN menu 
	ON menu.product_id = sales.product_id
LEFT JOIN members
	ON sales.customer_id = members.customer_id

GO