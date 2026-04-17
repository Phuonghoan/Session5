-- Truy vấn hiển thị tổng doanh thu (SUM(total_price)) và số lượng sản phẩm bán được (SUM(quantity))

SELECT 
   p.category,
   SUM(o.total_price) AS total_sales,
   SUM(o.quantity) AS total_quantity
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category

-- Chỉ hiển thị những nhóm có tổng doanh thu lớn hơn 2000
HAVING SUM(o.total_price) > 2000

-- Sắp xếp kết quả theo tổng doanh thu giảm dần
ORDER BY total_sales DESC;

--  Truy vấn con (Subquery) để tìm sản phẩm có doanh thu cao nhất trong bảng orders
SELECT 
	p.product_name,
	SUM(o.total_price) AS total_revenue,
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(o.total_price) = (
SELECT MAX (total_revenue)
FROM (SELECT SUM(total_price) AS total_revenue FROM orders GROUP BY product_id) AS revenue_table
);

-- Tổng doanh thu theo từng category
SELECT 
    p.category,
    SUM(o.total_price) AS total_revenue
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category;