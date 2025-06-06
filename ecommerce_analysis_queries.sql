
-- 📊 Task 3: SQL for Data Analysis
-- 👩‍💻 Created by: Yashika Sharma

-- =====================================
-- 🔍 Business Question 1:
-- What is the total number of orders and total revenue?
-- Helps understand overall performance.
-- =====================================
SELECT COUNT(order_id) AS total_orders, SUM(total_amount) AS total_revenue
FROM orders;

-- =====================================
-- 🔍 Business Question 2:
-- What is the average order value per customer?
-- Measures customer profitability.
-- =====================================
SELECT customer_id, AVG(total_amount) AS avg_order_value
FROM orders
GROUP BY customer_id;

-- =====================================
-- 🔍 Business Question 3:
-- Who are the top 5 customers by spending?
-- Useful for loyalty programs.
-- =====================================
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- =====================================
-- 🔍 Business Question 4:
-- How many orders were placed each month?
-- For identifying seasonality.
-- =====================================
SELECT strftime('%Y-%m', order_date) AS month, COUNT(*) AS orders
FROM orders
GROUP BY month
ORDER BY month;

-- =====================================
-- 🔍 Business Question 5:
-- What products were most frequently ordered?
-- Helps optimize inventory.
-- =====================================
SELECT product_id, COUNT(*) AS order_count
FROM order_items
GROUP BY product_id
ORDER BY order_count DESC
LIMIT 10;

-- =====================================
-- 🔍 Business Question 6:
-- Join customers with their orders (INNER JOIN).
-- For building customer profiles.
-- =====================================
SELECT c.name, o.order_id, o.total_amount
FROM customers c
INNER JOIN orders o ON c.id = o.customer_id;

-- =====================================
-- 🔍 Business Question 7:
-- LEFT JOIN: Customers with or without orders.
-- Helps identify inactive users.
-- =====================================
SELECT c.name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id;

-- =====================================
-- 🔍 Business Question 8:
-- Create a view to analyze monthly revenue.
-- Optimizes repeated reporting.
-- =====================================
CREATE VIEW monthly_revenue AS
SELECT strftime('%Y-%m', order_date) AS month, SUM(total_amount) AS revenue
FROM orders
GROUP BY month;

-- =====================================
-- 🔍 Business Question 9:
-- Which customers spent more than the average?
-- For targeted marketing.
-- =====================================
SELECT name FROM customers
WHERE id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING SUM(total_amount) > (
        SELECT AVG(total_amount) FROM orders
    )
);
