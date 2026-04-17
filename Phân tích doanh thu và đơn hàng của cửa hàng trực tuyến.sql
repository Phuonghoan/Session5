-- Hiển thị danh sách tất cả đơn hàng
SELECT 
    c.customer_name AS ten_khach,
    o.order_date AS ngay_dat_hang,
    o.total_amount AS tong_tien
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

-- Tổng doanh thu
SELECT SUM(total_amount) AS tong_doanh_thu
FROM orders;

-- Trung bình giá trị đơn hàng
SELECT AVG(total_amount) AS trung_binh_don_hang
FROM orders;

-- Đơn hàng lớn nhất
SELECT MAX(total_amount) AS don_hang_lon_nhat
FROM orders;

-- Đơn hàng nhỏ nhất
SELECT MIN(total_amount) AS don_hang_nho_nhat
FROM orders;

-- Số lượng đơn hàng
SELECT COUNT(order_id) AS so_luong_don_hang
FROM orders;

-- Tổng doanh thu theo từng thành phố
SELECT 
    c.city,
    SUM(o.total_amount) AS tong_doanh_thu
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city

-- Chỉ lấy thành phố > 10000
HAVING SUM(o.total_amount) > 10000;

-- Liệt kê tất cả sản phẩm đã bán kèm tên khách hàng, ngày đặt hàng, số lượng và giá
SELECT
    c.customer_name,
    o.order_date,
    oi.product_name,
    oi.quantity,
    oi.price
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id;

-- Tìm tên khách hàng có tổng doanh thu cao nhất
SELECT c.customer_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) = (
    SELECT MAX(tong_doanh_thu)
    FROM (
        SELECT customer_id, SUM(total_amount) AS tong_doanh_thu
        FROM orders
        GROUP BY customer_id
    ) sub
);