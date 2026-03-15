/* ---------------------------------------------------------------------------
-- Case Study #5: Data Mart
-- Section C: Before & After Analysis
-- Author: Turki Alajmi
-- Date: March 2026
-- Tool used: Microsoft SQL Server (T-SQL)
--------------------------------------------------------------------------- */

/* ---------------------------------------------------------------------------
This technique is usually used when we inspect an important event and want to inspect the
impact before and after a certain point in time.

Taking the week_date value of 2020-06-15 as the baseline week where the Data Mart
sustainable packaging changes came into effect.

We would include all week_date values for 2020-06-15 as the start of the period after the change and
the previous week_date values would be before

Using this analysis approach - answer the following questions:
--------------------------------------------------------------------------- */

------------------------------------------------------------------------
-- Q1: What is the total sales for the 4 weeks before and after 2020-06-15?
-- What is the growth or reduction rate in actual values and percentage of sales?
------------------------------------------------------------------------

WITH before_4_weeks AS (
    SELECT
        SUM(CAST(sales AS BIGINT)) AS before_sales
    FROM data_mart.clean_weekly_sales
    WHERE week_date < '20200615'
      AND week_date >= DATEADD(WEEK, -4, '20200615')


),
    after_4_weeks AS (
        SELECT
            SUM(CAST(sales AS BIGINT)) AS after_sales
        FROM data_mart.clean_weekly_sales
        WHERE week_date >= '20200615'
          AND week_date < DATEADD(WEEK, 4, '20200615')

    )

SELECT
    before_sales,
    after_sales,
    after_sales - before_sales AS sales_difference,
    CAST(((after_sales - before_sales) * 100.0) / before_sales AS DECIMAL(5, 2)) AS growth
FROM before_4_weeks
CROSS JOIN after_4_weeks;

------------------------------------------------------------------------
-- Q2: What about the entire 12 weeks before and after?
------------------------------------------------------------------------

-- Note this is the exact same query from Q-1 but the only difference is
-- Paramater changes from 4 weeks to 12 weeks.
WITH before_12_weeks AS (
    SELECT
        SUM(CAST(sales AS BIGINT)) AS before_sales
    FROM data_mart.clean_weekly_sales
    WHERE week_date < '20200615'
      AND week_date >= DATEADD(WEEK, -12, '20200615')


),
    after_12_weeks AS (
        SELECT
            SUM(CAST(sales AS BIGINT)) AS after_sales
        FROM data_mart.clean_weekly_sales
        WHERE week_date >= '20200615'
          AND week_date < DATEADD(WEEK, 12, '20200615')

    )

SELECT
    before_sales,
    after_sales,
    after_sales - before_sales AS sales_difference,
    CAST(((after_sales - before_sales) * 100.0) / before_sales AS DECIMAL(5, 2)) AS growth
FROM before_12_weeks
CROSS JOIN after_12_weeks;

------------------------------------------------------------------------
-- Q3: How do the sale metrics for these 2 periods before and after
-- compare with the previous years in 2018 and 2019?
------------------------------------------------------------------------

-- Note to find the parameters i used
-- SELECT TOP 1 week_number FROM data_mart.clean_weekly_sales
-- WHERE week_date = '20200615' which returns 24 as the starting number

WITH before_after_sales AS (
    SELECT
        calendar_year,
        SUM(CASE
                WHEN week_number BETWEEN 20 AND 23 THEN
                    CAST(sales AS BIGINT) END) AS before_sales,
        SUM(CASE
                WHEN week_number BETWEEN 24 AND 27 THEN
                    CAST(sales AS BIGINT) END) AS after_sales
    FROM data_mart.clean_weekly_sales
    WHERE week_number BETWEEN 20 AND 27
    GROUP BY calendar_year
)

SELECT
    calendar_year,
    before_sales,
    after_sales,
    after_sales - before_sales AS difference,
    CAST(((after_sales - before_sales) * 100.0) / before_sales AS DECIMAL(5, 2)) AS growth
FROM before_after_sales
ORDER BY
    calendar_year;

-- For the 12 weeks before and after periods we just change parameters in the cte as follows :
WITH before_after_sales AS (
    SELECT
        calendar_year,
        SUM(CASE
                WHEN week_number BETWEEN 12 AND 23 THEN
                    CAST(sales AS BIGINT) END) AS before_sales,
        SUM(CASE
                WHEN week_number BETWEEN 24 AND 35 THEN
                    CAST(sales AS BIGINT) END) AS after_sales
    FROM data_mart.clean_weekly_sales
    WHERE week_number BETWEEN 12 AND 35
    GROUP BY calendar_year
)

SELECT
    calendar_year,
    before_sales,
    after_sales,
    after_sales - before_sales AS difference,
    CAST(((after_sales - before_sales) * 100.0) / before_sales AS DECIMAL(5, 2)) AS growth
FROM before_after_sales
ORDER BY
    calendar_year;