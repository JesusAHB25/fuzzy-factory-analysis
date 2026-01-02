-- Block 1: Rentability and Business Health

-- Problem 1: Margin of real benefit per product

SELECT
    p.product_id, 
    p.product_name, 
    SUM(oi.price_usd) AS total_revenue,
    SUM(oi.cogs_usd) AS total_cost, -- Substract COGS (Cost of Goods Sold) and Refunds from Revenue.
    -- COALESCE replaces NULL refunds with 0 so the subtraction math doesn't break.
    SUM(COALESCE(oir.refund_amount_usd, 0)) AS total_refund,
    SUM(oi.price_usd - oi.cogs_usd - COALESCE(oir.refund_amount_usd, 0)) AS net_revenue
FROM products p 
INNER JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN order_item_refunds oir ON oi.order_item_id = oir.order_item_id
-- Is better to use a LEFT JOIN for refunds because most items are NOT refunded.
GROUP BY p.product_id, p.product_name
ORDER BY net_revenue DESC;

-- Problem 2: "Filter" of trusted customers (Those who doesn't has a lot of returns per product)

SELECT
    o.user_id,
    COUNT(oi.order_id) AS amount_of_orders,
    (SUM(COALESCE(refund_amount_usd, 0)) / SUM(oi.price_usd)) AS total_spend
FROM orders o
    LEFT JOIN order_items oi   -- THEN ON order_items for order_id
        ON oi.order_id = o.order_id LEFT JOIN order_item_refunds oir -- AND AGAIN on order_item_refunds for refund_amount_usd
            ON oi.order_id = oir.order_id
GROUP BY
o.user_id
    HAVING COUNT(oi.order_id) >= 2
ORDER BY total_spend DESC
LIMIT 10;
