SELECT s.student_id, s.student_name, c.course_name
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id;

SELECT s.student_id, s.student_name
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.course_id IS NULL;

SELECT c.course_id, c.course_name, s.student_name
FROM students s
RIGHT JOIN enrollments e ON s.student_id = e.student_id
RIGHT JOIN courses c ON e.course_id = c.course_id;

SELECT s.student_id, s.student_name, d.department_name
FROM students s
INNER JOIN departments d ON s.department_id = d.department_id;

SELECT s.student_name, c.course_name
FROM students s
CROSS JOIN courses c;
