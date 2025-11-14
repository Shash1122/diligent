-- 1. List all orders with user details and total price.
-- This query joins the orders and users tables to show who placed each order,
-- and it calculates the total price for each order by summing the items.
SELECT
    o.order_id,
    u.first_name,
    u.last_name,
    u.email,
    SUM(oi.quantity * oi.price) AS total_price
FROM
    orders AS o
JOIN
    users AS u ON o.user_id = u.user_id
JOIN
    order_items AS oi ON o.order_id = oi.order_id
GROUP BY
    o.order_id;

-- 2. List products and their categories.
-- This query joins the products and categories tables to show the category for each product.
SELECT
    p.product_name,
    c.category_name
FROM
    products AS p
JOIN
    categories AS c ON p.category_id = c.category_id;

-- 3. Find top 5 users by total spending.
-- This query identifies the top 5 spenders by joining users, orders, and order_items,
-- calculating the total amount spent by each user, and ordering the results.
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    SUM(oi.quantity * oi.price) AS total_spent
FROM
    users AS u
JOIN
    orders AS o ON u.user_id = o.user_id
JOIN
    order_items AS oi ON o.order_id = oi.order_id
GROUP BY
    u.user_id
ORDER BY
    total_spent DESC
LIMIT 5;

-- 4. Find the best-selling products (based on quantity).
-- This query finds the most popular products by summing the total quantity sold for each product.
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM
    products AS p
JOIN
    order_items AS oi ON p.product_id = oi.product_id
GROUP BY
    p.product_name
ORDER BY
    total_quantity_sold DESC;

-- 5. Show order items with product, category, and user info.
-- This query provides a detailed view of each order item, including product,
-- category, and the user who placed the order, by joining five tables.
SELECT
    oi.order_item_id,
    o.order_id,
    p.product_name,
    c.category_name,
    u.first_name || ' ' || u.last_name AS user_name,
    oi.quantity,
    oi.price
FROM
    order_items AS oi
JOIN
    products AS p ON oi.product_id = p.product_id
JOIN
    categories AS c ON p.category_id = c.category_id
JOIN
    orders AS o ON oi.order_id = o.order_id
JOIN
    users AS u ON o.user_id = u.user_id;

-- 6. Generate monthly revenue.
-- This query calculates the total revenue for each month by grouping the orders
-- by month and year and summing the total price of all items sold in that period.
SELECT
    strftime('%Y-%m', o.order_date) AS month,
    SUM(oi.quantity * oi.price) AS monthly_revenue
FROM
    orders AS o
JOIN
    order_items AS oi ON o.order_id = oi.order_id
GROUP BY
    month
ORDER BY
    month;

-- 7. Show users who never placed an order.
-- This query finds users who have not placed any orders by performing a LEFT JOIN
-- from the users table to the orders table and filtering for users with no matching orders.
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM
    users AS u
LEFT JOIN
    orders AS o ON u.user_id = o.user_id
WHERE
    o.order_id IS NULL;
