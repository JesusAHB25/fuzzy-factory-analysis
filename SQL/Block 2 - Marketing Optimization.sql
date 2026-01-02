-- Problem 3: Conversion Funnel Analysis

WITH session_views AS (
    SELECT
        website_session_id,
        -- MAX() picks up the '1' if the user touched that page even once.
        MAX(CASE WHEN pageview_url = '/home' THEN 1 ELSE 0 END) AS saw_home,
        MAX(CASE WHEN pageview_url = '/cart' THEN 1 ELSE 0 END) AS saw_cart,
        MAX(CASE WHEN pageview_url = '/billing' THEN 1 ELSE 0 END) AS saw_billing
        -- One session has multiple pageviews. We use a CTE to "simplify" each session 
        -- into a single row with binary flags (1 or 0).
    FROM website_pageviews
    GROUP BY website_session_id
)

SELECT
    SUM(saw_home) AS total_sessions,
    SUM(saw_billing) AS reached_billing,
    -- Calculate percentage of users who made it from start to finish.
    ROUND(SUM(saw_billing) / SUM(saw_home)::DECIMAL, 4) * 100 AS conversion_rate
FROM session_views;

-- Problem 4: Ads Performance

SELECT
    ws.utm_source,
    COUNT(ws.website_session_id) AS total_sessions,
    COUNT(o.order_id) AS total_orders,
    COUNT(o.order_id) / COUNT(ws.website_session_id)::DECIMAL AS conversion_rate
FROM
    website_sessions ws 
LEFT JOIN 
    orders o 
        ON ws.website_session_id = o.website_session_id
WHERE ws.utm_source IN ('gsearch', 'bsearch')
GROUP BY 
    ws.utm_source
ORDER BY
    SUM(o.order_id) DESC;








