-- =====================================================
-- Strategic Business Analysis (Time-aware where relevant)
-- =====================================================


-- =====================================================
-- 1. Revenue & Growth
-- =====================================================

-- 1.1 Monthly Revenue Trend
SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(total_amount) AS monthly_revenue
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

-- 1.2 Monthly Net Revenue (after discounts)
SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(total_amount - discount) AS monthly_net_revenue
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

-- 1.3 Monthly Estimated Profit (Revenue - Shipping Cost)
SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(total_amount - shipping_cost) AS monthly_estimated_profit
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;


-- =====================================================
-- 2. Product Performance (Overall)
-- =====================================================

-- 2.1 Top 10 Products by Revenue
SELECT
    p.product_name,
    SUM(o.total_amount) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 10;

-- 2.2 Revenue by Category
SELECT
    p.category,
    SUM(o.total_amount) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;


-- =====================================================
-- 3. Customer Value (Overall)
-- =====================================================

-- 3.1 Top 10 Customers by Total Spend
SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 10;

-- 3.2 Average Order Value
SELECT
    AVG(total_amount) AS average_order_value
FROM orders;


-- =====================================================
-- 4. Geographic Analysis (Operational View)
-- =====================================================

-- 4.1 Revenue by State
SELECT
    c.state,
    SUM(o.total_amount) AS total_revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.state
ORDER BY total_revenue DESC;

-- 4.2 Average Shipping Cost by State
SELECT
    c.state,
    AVG(o.shipping_cost) AS avg_shipping_cost
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.state
ORDER BY avg_shipping_cost DESC;

-- 4.3 Cancellation Rate by State
SELECT
    c.state,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
    ROUND(
        SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END)::numeric
        / COUNT(*) * 100,
        2
    ) AS cancellation_rate_percent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.state
ORDER BY cancellation_rate_percent DESC;


-- =====================================================
-- 5. Payment & Order Success
-- =====================================================

-- 5.1 Revenue by Payment Method (Overall)
SELECT
    payment_method,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY payment_method
ORDER BY total_revenue DESC;

-- 5.2 Cancellation Rate by Payment Method (Overall)
SELECT
    payment_method,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
    ROUND(
        SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END)::numeric
        / COUNT(*) * 100,
        2
    ) AS cancellation_rate_percent
FROM orders
GROUP BY payment_method
ORDER BY cancellation_rate_percent DESC;

-- 5.3 Monthly Cancellation Rate (Strategic Trend)
SELECT
    DATE_TRUNC('month', order_date) AS month,
    ROUND(
        SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END)::numeric
        / COUNT(*) * 100,
        2
    ) AS monthly_cancellation_rate_percent
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;


-- =====================================================
-- 6. Discount & Margin Impact
-- =====================================================

-- 6.1 Total Discount Given
SELECT
    SUM(discount) AS total_discount
FROM orders;

-- 6.2 Estimated Gross Revenue (Before Discount)
SELECT
    SUM(total_amount + discount) AS estimated_gross_revenue
FROM orders;

-- 6.3 Monthly Discount Impact
SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(discount) AS monthly_discount_given
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;


-- =====================================================
-- 7. Customer Segmentation (RFM-lite)
-- =====================================================

-- 7.1 Customer Purchase Frequency & Spend
SELECT
    customer_id,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_spent,
    MAX(order_date) AS last_purchase_date
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC;

-- 7.2 Revenue Contribution by Customer Quintile (Top 20% Analysis)
WITH customer_revenue AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),
ranked_customers AS (
    SELECT
        *,
        NTILE(5) OVER (ORDER BY total_spent DESC) AS revenue_quintile
    FROM customer_revenue
)
SELECT
    revenue_quintile,
    SUM(total_spent) AS revenue_in_segment
FROM ranked_customers
GROUP BY revenue_quintile
ORDER BY revenue_quintile;


-- =====================================================
-- 8. Retention & Repeat Purchase Rate
-- =====================================================

-- 8.1 Overall Repeat Purchase Rate
SELECT
    ROUND(
        COUNT(DISTINCT CASE WHEN order_count > 1 THEN customer_id END)::numeric
        / COUNT(DISTINCT customer_id) * 100,
        2
    ) AS repeat_purchase_rate_percent
FROM (
    SELECT
        customer_id,
        COUNT(order_id) AS order_count
    FROM orders
    GROUP BY customer_id
) t;

-- 8.2 Monthly Repeat Purchase Rate
WITH customer_orders AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', order_date) AS month,
        COUNT(order_id) AS monthly_orders
    FROM orders
    GROUP BY customer_id, DATE_TRUNC('month', order_date)
)
SELECT
    month,
    ROUND(
        COUNT(DISTINCT CASE WHEN monthly_orders > 1 THEN customer_id END)::numeric
        / COUNT(DISTINCT customer_id) * 100,
        2
    ) AS monthly_repeat_rate_percent
FROM customer_orders
GROUP BY month
ORDER BY month;
