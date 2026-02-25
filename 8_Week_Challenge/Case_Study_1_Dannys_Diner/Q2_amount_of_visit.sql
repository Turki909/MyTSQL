-- -----------------------------------------------------------------------------
-- Question 2:How many days has each customer visited the restaurant?
-- -----------------------------------------------------------------------------

SELECT
	customer_id,
	count(distinct order_date) as visit_amount
FROM SALES
group by customer_id