-- Tổng doanh thu và số đơn hàng của mỗi khách hàng, chỉ hiện khách > 2000

SELECT 
    c.customer_name,
    SUM(o.total_price) AS total_revenue,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_price) > 2000;

-- Doanh thu trung bình của tất cả khách hàng, rồi hiện khách có doanh thu lớn hơn mức đó

SELECT *
FROM (
    SELECT 
        c.customer_id,
        c.customer_name,
        SUM(o.total_price) AS total_revenue
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.customer_name
) t
WHERE total_revenue > (
    SELECT AVG(customer_revenue)
    FROM (
        SELECT SUM(o.total_price) AS customer_revenue
        FROM customers c
        JOIN orders o ON c.customer_id = o.customer_id
        GROUP BY c.customer_id
    ) x
);

-- Thành phố có tổng doanh thu cao nhất

SELECT 
    c.city,
    SUM(o.total_price) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_price) = (
    SELECT MAX(city_revenue)
    FROM (
        SELECT SUM(o.total_price) AS city_revenue
        FROM customers c
        JOIN orders o ON c.customer_id = o.customer_id
        GROUP BY c.city
    ) t
);

-- INNER JOIN 3 bảng để hiện chi tiết

SELECT 
    c.customer_name,
    c.city,
    SUM(oi.quantity) AS total_products,
    SUM(oi.quantity * oi.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name, c.city;