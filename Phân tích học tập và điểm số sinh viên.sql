-- ALIAS
SELECT 
    s.full_name AS "Tên sinh viên",
    c.course_name AS "Môn học",
    e.score AS "Điểm"
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON c.course_id = e.course_id;

-- Aggregate Functions
SELECT
    s.full_name,
    AVG(e.score) AS diem_trung_binh,
    MAX(e.score) AS diem_cao_nhat,
    MIN(e.score) AS diem_thap_nhat
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.full_name;

-- GROUP BY / HAVING
-- Tìm ngành học có điểm trung bình cao hơn 7.5
SELECT
    s.major,
    AVG(e.score) AS diem_trung_binh
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.major
HAVING AVG(e.score) > 7.5;

-- JOIN
-- Liệt kê tất cả sinh viên, môn học, số tín chỉ và điểm
SELECT
    s.full_name,
    c.course_name,
    c.credit,
    e.score
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON c.course_id = e.course_id;

-- Subquery
-- Tìm sinh viên có điểm trung bình cao hơn điểm trung bình toàn trường
SELECT
    s.full_name,
    AVG(e.score) AS diem_trung_binh
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.full_name
HAVING AVG(e.score) > (
    SELECT AVG(score)
    FROM enrollments
);