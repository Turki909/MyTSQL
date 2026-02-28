--Q1
SELECT
    COUNT(order_id) AS order_count
FROM customer_orders_clean;

--Q2
SELECT
    COUNT(DISTINCT order_id) AS Distinct_order_count
FROM customer_orders_clean;

--Q3
SELECT
    runner_id,
    COUNT(pickup_time) AS delivery_counts
FROM runner_orders_clean
WHERE cancellation IS NULL
GROUP BY runner_id;

--Q4
SELECT
    c.pizza_id,
    count(*) AS counts
FROM customer_orders_clean AS c
INNER JOIN runner_orders_clean AS r
    on r.order_id = c.order_id
WHERE r.cancellation IS NULL
GROUP BY c.pizza_id;

--Q5
