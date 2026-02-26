SELECT
	j.customer_id,
	order_date,
	product_name,
	price,
	member,
	CASE
		WHEN member = 'N'
			THEN NULL
		WHEN member = 'Y'
			THEN DENSE_RANK() OVER(
				PARTITION BY j.customer_id,member
				ORDER BY order_date ASC
				)
	END AS ranking
FROM joined_things as j;
-- "joined_things" is a VIEW created from the "join all the things" bonus question