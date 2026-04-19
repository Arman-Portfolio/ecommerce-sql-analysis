-- =========================================
-- REVENUE ANALYSIS
-- =========================================

-- Total revenue
SELECT SUM(payment_value) AS total_revenue
FROM payments;

-- Average order value
SELECT AVG(payment_value) AS avg_value
FROM payments;

-- Revenue by state
SELECT 
    c.customer_state,
    SUM(p.payment_value) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY revenue DESC;

-- Orders by city
SELECT 
    c.customer_city,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_city
ORDER BY total_orders DESC;


-- =========================================
-- ADVANCED ANALYSIS
-- =========================================

-- Top 10 products by sales
SELECT product_id,
       COUNT(*) AS total_sales
FROM order_items
GROUP BY product_id
ORDER BY total_sales DESC
LIMIT 10;

-- Top 10 products by revenue
SELECT 
    product_id,
    SUM(price) AS revenue
FROM order_items
GROUP BY product_id
ORDER BY revenue DESC
LIMIT 10;

-- Top customers by spending
SELECT 
    c.customer_id,
    SUM(p.payment_value) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- Payment type usage
SELECT 
    payment_type,
    COUNT(*) AS usage_count
FROM payments
GROUP BY payment_type
ORDER BY usage_count DESC;

-- Monthly revenue trend
SELECT 
    TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM') AS month,
    SUM(p.payment_value) AS total_revenue
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY month
ORDER BY month;
