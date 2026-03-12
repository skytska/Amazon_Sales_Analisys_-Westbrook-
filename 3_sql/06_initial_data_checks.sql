-- ==========================================
-- INITIAL DATA CHECKS AFTER LOADING TO DB
-- ==========================================

-- 1. Check for duplicate order_id

SELECT
    order_id,
    COUNT(*) AS order_count
FROM public.orders
GROUP BY order_id
HAVING COUNT(*) > 1;


-- 2. Null checks in orders table

SELECT
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS null_order_id,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS null_order_date,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS null_product_id,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS null_quantity,
    SUM(CASE WHEN unit_price IS NULL THEN 1 ELSE 0 END) AS null_unit_price,
    SUM(CASE WHEN discount IS NULL THEN 1 ELSE 0 END) AS null_discount,
    SUM(CASE WHEN tax IS NULL THEN 1 ELSE 0 END) AS null_tax,
    SUM(CASE WHEN shipping_cost IS NULL THEN 1 ELSE 0 END) AS null_shipping_cost,
    SUM(CASE WHEN total_amount IS NULL THEN 1 ELSE 0 END) AS null_total_amount,
    SUM(CASE WHEN payment_method IS NULL THEN 1 ELSE 0 END) AS null_payment_method,
    SUM(CASE WHEN order_status IS NULL THEN 1 ELSE 0 END) AS null_order_status
FROM public.orders;


-- 3. Distinct values exploration

-- Distinct order statuses
SELECT DISTINCT order_status
FROM public.orders
ORDER BY 1;

-- Distinct payment methods (from fact table)
SELECT DISTINCT payment_method
FROM public.orders
ORDER BY 1;

-- Distinct product categories
SELECT DISTINCT category
FROM public.products
ORDER BY 1;

-- Distinct countries
SELECT DISTINCT country
FROM public.customers
ORDER BY 1;


-- 4. Date range check

SELECT
    MIN(order_date) AS earliest_order_date,
    MAX(order_date) AS latest_order_date
FROM public.orders;


-- 5. Price and revenue checks

-- Min & max total amount
SELECT
    MIN(total_amount) AS min_total_amount,
    MAX(total_amount) AS max_total_amount
FROM public.orders;

-- Orders with zero total amount
SELECT
    total_amount,
    COUNT(*) AS count_orders
FROM public.orders
WHERE total_amount = 0
GROUP BY total_amount;
