------------------------------------------------------------------------
-- BONUS: Join All The Things (Recreate the table with member status)
------------------------------------------------------------------------

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
    ON sales.customer_id = members.customer_id;

------------------------------------------------------------------------
-- BONUS: Rank All The Things (Add ranking for member purchases)
------------------------------------------------------------------------

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
            THEN DENSE_RANK() OVER (
            PARTITION BY j.customer_id,member
            ORDER BY order_date ASC
            )
        END AS ranking
FROM joined_things AS j;
-- "joined_things" is a VIEW created from the "join all the things" bonus question