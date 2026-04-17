-- ALIAS
SELECT 
    e.emp_name AS "Tên nhân viên",
    d.dept_name AS "Phòng ban",
    e.salary AS "Lương"
FROM employees AS e
JOIN departments AS d 
    ON e.dept_id = d.dept_id;

-- Aggregate Functions
-- i. Tổng quỹ lương toàn công ty
SELECT SUM(salary) AS tong_quy_luong
FROM employees;

-- ii. Mức lương trung bình
SELECT AVG(salary) AS luong_trung_binh
FROM employees;

-- iii. Lương cao nhất, thấp nhất
SELECT 
    MAX(salary) AS luong_cao_nhat,
    MIN(salary) AS luong_thap_nhat
FROM employees;

-- iv. Số nhân viên
SELECT COUNT(*) AS so_nhan_vien
FROM employees;

-- GROUP BY / HAVING
-- a. Mức lương trung bình của từng phòng ban
SELECT 
    d.dept_name AS phong_ban,
    AVG(e.salary) AS luong_trung_binh
FROM employees e
JOIN departments d 
    ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- b. Chỉ hiển thị những phòng ban có lương trung bình > 15000000
SELECT 
    d.dept_name AS phong_ban,
    AVG(e.salary) AS luong_trung_binh
FROM employees e
JOIN departments d 
    ON e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING AVG(e.salary) > 15000000;

-- JOIN
-- Liệt kê danh sách dự án cùng với phòng ban phụ trách và nhân viên thuộc phòng ban đó
SELECT 
    p.project_name AS du_an,
    d.dept_name AS phong_ban,
    e.emp_name AS nhan_vien
FROM projects p
JOIN departments d 
    ON p.dept_id = d.dept_id
JOIN employees e 
    ON d.dept_id = e.dept_id
ORDER BY p.project_name, e.emp_name;

-- Subquery
-- Tìm nhân viên có lương cao nhất trong mỗi phòng ban
SELECT 
    e.emp_name,
    d.dept_name,
    e.salary
FROM employees e
JOIN departments d 
    ON e.dept_id = d.dept_id
WHERE (e.dept_id, e.salary) IN (
    SELECT dept_id, MAX(salary)
    FROM employees
    GROUP BY dept_id
);