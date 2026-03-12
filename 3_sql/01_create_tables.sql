-- ===========================================
-- 01_create_tables.sql
-- Schema creation script for Amazon Sales Analysis
-- Note: We drop all tables at the beginning to ensure clean setup.
--       payment_methods table was created first but then was removed for simplicity; 
--       orders.payment_method will be stored as TEXT directly.
-- ===========================================

-- 1. Drop existing tables if they exist
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS payment_methods;

-- ===========================================
-- 2. Customers table
-- ===========================================
CREATE TABLE customers (
    customer_id TEXT PRIMARY KEY,
    customer_name TEXT,
    city TEXT,
    state TEXT,
    country TEXT
);

-- ===========================================
-- 3. Products table
-- ===========================================
CREATE TABLE products (
    product_id TEXT PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    brand TEXT
);

-- ===========================================
-- 4. Orders (fact table)
-- ===========================================
CREATE TABLE orders (
    order_id TEXT PRIMARY KEY,
    order_date DATE,

    customer_id TEXT,
    product_id TEXT,

    quantity INT,
    unit_price NUMERIC(10, 2),
    discount NUMERIC(10, 2),
    tax NUMERIC(10, 2),
    shipping_cost NUMERIC(10, 2),
    total_amount NUMERIC(12, 2),

    order_status TEXT,
    payment_method TEXT,

    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),

    CONSTRAINT fk_product
        FOREIGN KEY (product_id) REFERENCES products(product_id)
);
