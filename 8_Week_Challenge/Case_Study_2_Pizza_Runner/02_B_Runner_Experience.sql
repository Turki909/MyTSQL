------------------------------------------------------------------------
--Q01 How many runners signed up for each 1-week period?
--    (i.e. week starts 2021-01-01)
------------------------------------------------------------------------

WITH histo AS (
    SELECT
        runner_id,
        registration_date,
        (DATEDIFF(DAY, '20210101', registration_date) / 7) + 1 AS week_histo
/*  This week_histo column uses the integer devision concept to throw
    the decimal point and +1 to make the starting week from 0 >> 1 */
    FROM runners
)
SELECT
    week_histo,
    COUNT(*) AS runners_registering
FROM histo
GROUP BY
    week_histo;

------------------------------------------------------------------------
--Q02 What was the average time in minutes it took for each runner to
--    arrive at the Pizza Runner HQ to pickup the order?
------------------------------------------------------------------------

WITH distinct_orders AS (
    SELECT DISTINCT
        r.runner_id AS runner,
        r.order_id,
        DATEDIFF(MINUTE, c.order_time, r.pickup_time) AS picktime
    FROM runner_orders_clean AS r
    INNER JOIN customer_orders_clean AS c
        ON r.order_id = c.order_id
    WHERE r.cancellation IS NULL
)

SELECT
    runner,
    AVG(picktime) AS avg_pickup_time
FROM distinct_orders
GROUP BY
    runner;

------------------------------------------------------------------------
--Q03 Is there any relationship between the number of pizzas and how
--    long the order takes to prepare?
------------------------------------------------------------------------


------------------------------------------------------------------------
--Q04 What was the average distance travelled for each customer?
------------------------------------------------------------------------


------------------------------------------------------------------------
--Q05 What was the difference between the longest and shortest delivery
--    times for all orders?
------------------------------------------------------------------------


------------------------------------------------------------------------
--Q06 What was the average speed for each runner for each delivery and
--    do you notice any trend for these values?
------------------------------------------------------------------------


------------------------------------------------------------------------
--Q07 What is the successful delivery percentage for each runner?
------------------------------------------------------------------------