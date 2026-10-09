-- How did order volume and order value change over time?

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_order_value,
    ROUND(
        SUM(oi.price + oi.freight_value)
        / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY order_month;




-- Which product categories contribute the most to the marketplace's total order value?
SELECT
    COALESCE(
        ct.product_category_name_english,
        p.product_category_name
    ) AS category,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(oi.order_item_id) AS total_items,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_order_value,
    ROUND(AVG(oi.price), 2) AS average_item_price
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY
    COALESCE(
        ct.product_category_name_english,
        p.product_category_name
    )
ORDER BY total_order_value DESC;

-- Which sellers contribute the most to the marketplace's total order value?
SELECT
    oi.seller_id,
    s.seller_city,
    s.seller_state,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(oi.order_item_id) AS total_items,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_order_value,
    ROUND(AVG(oi.price), 2) AS average_item_price
FROM order_items oi
JOIN sellers s
    ON oi.seller_id = s.seller_id
GROUP BY
    oi.seller_id,
    s.seller_city,
    s.seller_state
ORDER BY total_order_value DESC
LIMIT 10;

-- Which product categories have a higher proportion of late orders?
SELECT
    COALESCE(
        ct.product_category_name_english,
        p.product_category_name
    ) AS category,

    COUNT(DISTINCT oi.order_id) AS total_orders,

    COUNT(DISTINCT CASE
        WHEN o.order_delivered_customer_date >
             o.order_estimated_delivery_date
        THEN oi.order_id
    END) AS late_orders,

    ROUND(
        COUNT(DISTINCT CASE
            WHEN o.order_delivered_customer_date >
                 o.order_estimated_delivery_date
            THEN oi.order_id
        END) * 100.0
        / COUNT(DISTINCT oi.order_id),
        2
    ) AS late_rate_percentage

FROM order_items oi

JOIN orders o
    ON oi.order_id = o.order_id

JOIN products p
    ON oi.product_id = p.product_id

LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name

WHERE o.order_delivered_customer_date IS NOT NULL

GROUP BY
    COALESCE(
        ct.product_category_name_english,
        p.product_category_name
    )

HAVING COUNT(DISTINCT oi.order_id) >= 100

ORDER BY late_rate_percentage DESC;


-- Do customers give lower review scores when their orders are delivered late?
SELECT
    CASE
        WHEN o.order_delivered_customer_date IS NULL
            THEN 'Not Delivered'
        WHEN o.order_delivered_customer_date >
             o.order_estimated_delivery_date
            THEN 'Late'
        WHEN o.order_delivered_customer_date =
             o.order_estimated_delivery_date
            THEN 'On Time'
        ELSE 'Early'
    END AS delivery_performance,

    COUNT(DISTINCT o.order_id) AS total_orders,

    ROUND(AVG(r.average_review_score), 2) AS average_review_score

FROM orders o

JOIN (
    SELECT
        order_id,
        AVG(review_score) AS average_review_score
    FROM order_reviews
    GROUP BY order_id
) r
    ON o.order_id = r.order_id

GROUP BY
    CASE
        WHEN o.order_delivered_customer_date IS NULL
            THEN 'Not Delivered'
        WHEN o.order_delivered_customer_date >
             o.order_estimated_delivery_date
            THEN 'Late'
        WHEN o.order_delivered_customer_date =
             o.order_estimated_delivery_date
            THEN 'On Time'
        ELSE 'Early'
    END

ORDER BY average_review_score DESC;

-- Which payment methods are most commonly used, and which contribute the most payment value?
SELECT
    payment_type,
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT order_id) AS unique_orders,
    ROUND(SUM(payment_value), 2) AS total_payment_value,
    ROUND(AVG(payment_value), 2) AS average_payment_value,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM order_payments),
        2
    ) AS transaction_share_percentage,
    ROUND(
        SUM(payment_value) * 100.0 /
        (SELECT SUM(payment_value) FROM order_payments),
        2
    ) AS value_share_percentage
FROM order_payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;

-- Which sellers generate significant order value while also having higher late-delivery rates?
SELECT
    so.seller_id,
    s.seller_city,
    s.seller_state,

    COUNT(DISTINCT so.order_id) AS total_orders,

    ROUND(SUM(so.order_value), 2) AS total_order_value,

    COUNT(DISTINCT CASE
        WHEN o.order_delivered_customer_date >
             o.order_estimated_delivery_date
        THEN so.order_id
    END) AS late_orders,

    ROUND(
        COUNT(DISTINCT CASE
            WHEN o.order_delivered_customer_date >
                 o.order_estimated_delivery_date
            THEN so.order_id
        END) * 100.0
        / COUNT(DISTINCT so.order_id),
        2
    ) AS late_rate_percentage

FROM
(
    SELECT
        oi.seller_id,
        oi.order_id,
        SUM(oi.price + oi.freight_value) AS order_value
    FROM order_items oi
    GROUP BY
        oi.seller_id,
        oi.order_id
) so

JOIN sellers s
    ON so.seller_id = s.seller_id

JOIN orders o
    ON so.order_id = o.order_id

WHERE o.order_delivered_customer_date IS NOT NULL

GROUP BY
    so.seller_id,
    s.seller_city,
    s.seller_state

HAVING COUNT(DISTINCT so.order_id) >= 100

ORDER BY late_rate_percentage DESC;