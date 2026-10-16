-- E-Commerce Sales Analysis (Olist dataset), SQLite-compatible

-- 1. Monthly orders and payment value
WITH monthly_orders AS (
    SELECT strftime('%Y-%m', order_purchase_timestamp) AS month,
           COUNT(*) AS total_orders
    FROM olist_orders_dataset
    GROUP BY strftime('%Y-%m', order_purchase_timestamp)
),
monthly_payments AS (
    SELECT strftime('%Y-%m', o.order_purchase_timestamp) AS month,
           SUM(p.payment_value) AS total_payment_value
    FROM olist_orders_dataset AS o
    JOIN olist_order_payments_dataset AS p ON o.order_id = p.order_id
    GROUP BY strftime('%Y-%m', o.order_purchase_timestamp)
)
SELECT mo.month, mo.total_orders,
       ROUND(mp.total_payment_value, 2) AS total_payment_value
FROM monthly_orders AS mo
LEFT JOIN monthly_payments AS mp ON mo.month = mp.month
WHERE mo.month IS NOT NULL
ORDER BY mo.month;

-- 2. Top 10 categories by product sales value (item price; freight excluded)
SELECT COALESCE(t.product_category_name_english, p.product_category_name, 'unknown') AS category,
       COUNT(DISTINCT oi.order_id) AS total_orders,
       COUNT(*) AS items_sold,
       ROUND(SUM(oi.price), 2) AS product_sales
FROM olist_order_items_dataset AS oi
JOIN olist_products_dataset AS p ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation AS t
    ON p.product_category_name = t.product_category_name
GROUP BY category
ORDER BY product_sales DESC
LIMIT 10;

-- 3. Delivery performance for delivered orders with both dates available
SELECT COUNT(*) AS delivered_orders,
       SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 ELSE 0 END) AS late_orders,
       ROUND(100.0 * SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 ELSE 0 END) / COUNT(*), 2) AS late_delivery_percentage,
       ROUND(AVG(julianday(order_delivered_customer_date) - julianday(order_purchase_timestamp)), 2) AS avg_delivery_days
FROM olist_orders_dataset
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;

-- 4. Review score comparison: late vs on-time deliveries
WITH delivery_status AS (
    SELECT order_id,
           CASE WHEN order_delivered_customer_date > order_estimated_delivery_date
                THEN 'Late' ELSE 'On Time' END AS delivery_group
    FROM olist_orders_dataset
    WHERE order_status = 'delivered'
      AND order_delivered_customer_date IS NOT NULL
      AND order_estimated_delivery_date IS NOT NULL
)
SELECT d.delivery_group,
       COUNT(DISTINCT d.order_id) AS total_orders,
       ROUND(AVG(r.review_score), 2) AS avg_review_score,
       COUNT(r.review_score) AS review_records
FROM delivery_status AS d
LEFT JOIN olist_order_reviews_dataset AS r ON d.order_id = r.order_id
GROUP BY d.delivery_group
ORDER BY d.delivery_group;
