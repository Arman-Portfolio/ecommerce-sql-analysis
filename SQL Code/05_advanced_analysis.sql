-- =========================================
-- MASTER DATASET (FULL JOIN MODEL)
-- =========================================
-- Purpose: Create a single table for analysis

SELECT 
    c.customer_id,
    c.customer_city,
    c.customer_state,

    o.order_id,
    o.order_status,
    o.order_purchase_timestamp,

    oi.product_id,
    oi.price,
    oi.freight_value,

    pr.product_category_name,

    s.seller_id,
    s.seller_city,
    s.seller_state,

    p.payment_type,
    p.payment_installments,
    p.payment_value,

    r.review_score

FROM customers c

JOIN orders o 
    ON c.customer_id = o.customer_id

JOIN order_items oi 
    ON o.order_id = oi.order_id

JOIN products pr 
    ON oi.product_id = pr.product_id

JOIN sellers s 
    ON oi.seller_id = s.seller_id

JOIN payments p 
    ON o.order_id = p.order_id

LEFT JOIN reviews r 
    ON o.order_id = r.order_id;

-- =========================================
-- CUSTOMER LIFETIME VALUE
-- =========================================

SELECT 
    c.customer_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(p.payment_value) AS total_spent,
    AVG(p.payment_value) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;

-- =========================================
-- RFM (Recency, Frequency, Monetary)
-- =========================================

SELECT 
    c.customer_id,
    MAX(o.order_purchase_timestamp) AS last_purchase,
    COUNT(o.order_id) AS frequency,
    SUM(p.payment_value) AS monetary
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_id;

-- =========================================
-- DELIVERY DELAY ANALYSIS
-- =========================================

SELECT 
    o.order_id,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,

    (o.order_delivered_customer_date - o.order_estimated_delivery_date) AS delay

FROM orders o
WHERE o.order_delivered_customer_date IS NOT NULL;

-- =========================================
-- SELLER PERFORMANCE
-- =========================================

SELECT 
    s.seller_id,
    s.seller_city,
    COUNT(oi.order_id) AS total_orders,
    SUM(oi.price) AS total_revenue
FROM sellers s
JOIN order_items oi ON s.seller_id = oi.seller_id
GROUP BY s.seller_id, s.seller_city
ORDER BY total_revenue DESC;

-- =========================================
-- CATEGORY PERFORMANCE
-- =========================================

SELECT 
    pr.product_category_name,
    COUNT(oi.product_id) AS total_sales,
    SUM(oi.price) AS revenue
FROM products pr
JOIN order_items oi ON pr.product_id = oi.product_id
GROUP BY pr.product_category_name
ORDER BY revenue DESC;

-- =========================================
-- CUSTOMER RETENTION | Repeat vs One-time Customers
-- =========================================

SELECT 
    CASE 
        WHEN COUNT(order_id) = 1 THEN 'One-time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS total_customers
FROM orders
GROUP BY customer_id;

-- =========================================
-- MONTHLY GROWTH
-- =========================================

WITH monthly_revenue AS (
    SELECT 
        DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
        SUM(p.payment_value) AS revenue
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    GROUP BY month
)

SELECT 
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
    (revenue - LAG(revenue) OVER (ORDER BY month)) / 
    LAG(revenue) OVER (ORDER BY month) * 100 AS growth_percentage
FROM monthly_revenue;

-- =========================================
-- REVIEW IMPACT ON REVENUE | Review vs Revenue
-- =========================================

SELECT 
    r.review_score,
    AVG(p.payment_value) AS avg_order_value
FROM reviews r
JOIN orders o ON r.order_id = o.order_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY r.review_score
ORDER BY r.review_score DESC;

