-- Block 3: Behavior and retention

-- Problem 5: "Second purchase" Analysis


WITH first_session AS (
    SELECT
        user_id,
        created_at AS first_session_date
    FROM
        website_sessions
    WHERE
        is_repeat_session = 0
),
second_session AS (
    SELECT
        user_id,
        created_at AS second_session_date
    FROM
        website_sessions
    WHERE
        is_repeat_session = 1
)

SELECT
    AVG(EXTRACT(DAY FROM s.second_session_date - f.first_session_date)) AS days_passed_before_buying_again
FROM
    first_session f JOIN second_session s
    ON f.user_id = s.user_id;


-- Problem 6: The "hook" product

SELECT
    o.primary_product_id,
    p.product_name,
    COUNT(o.user_id) AS total_new_customers,
    -- Count the user if their total order count in the database is > 1.
    COUNT(CASE WHEN (SELECT COUNT(*) FROM orders o2 WHERE o2.user_id = o.user_id) > 1 THEN 1 END) AS returning_clients
    -- Identify the 1st product ever bought by a user and check if they 
    -- ever placed a 2nd order. This identifies which product creates the most loyalty.
FROM orders o 
LEFT JOIN products p ON o.primary_product_id = p.product_id
-- Only analyze the 1st order ('Hook') for each customer.
WHERE o.order_id IN (SELECT MIN(order_id) FROM orders GROUP BY user_id) 
GROUP BY 
    o.primary_product_id, p.product_name
ORDER BY 
    returning_clients DESC;


