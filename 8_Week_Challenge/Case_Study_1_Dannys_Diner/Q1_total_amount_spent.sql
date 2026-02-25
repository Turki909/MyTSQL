-- -----------------------------------------------------------------------------
-- Question 1: What is the total amount each customer spent at the restaurant?
-- -----------------------------------------------------------------------------

SELECT 
	customer_id,
	concat('$',sum(price)) as totalspent
FROM sales
INNER JOIN menu 
	on menu.product_id = sales.product_id
GROUP BY 
	customer_id;