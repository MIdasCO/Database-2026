SELECT first_name, salary
FROM instructors
WHERE salary > (SELECT AVG(salary) FROM instructors)
ORDER BY salary DESC;

WITH faculty_pay AS (
    SELECT f.faculty_name, COUNT(i.instructor_id) AS staff,
           COALESCE(SUM(i.salary), 0) AS total_pay
    FROM faculties AS f
    LEFT JOIN instructors AS i USING (faculty_id)
    GROUP BY f.faculty_id, f.faculty_name
)
SELECT * FROM faculty_pay WHERE staff > 0 ORDER BY total_pay DESC;

WITH RECURSIVE org_chart AS (
    SELECT instructor_id, first_name, manager_id, 0 AS depth,
           first_name::TEXT AS path
    FROM instructors WHERE manager_id IS NULL
    UNION ALL
    SELECT i.instructor_id, i.first_name, i.manager_id,
           o.depth + 1, o.path || ' > ' || i.first_name
    FROM instructors AS i
    JOIN org_chart AS o ON i.manager_id = o.instructor_id
)
SELECT first_name, depth, path FROM org_chart ORDER BY path;

SELECT student_id FROM enrollments WHERE course_id = 1
INTERSECT
SELECT student_id FROM enrollments WHERE course_id = 2
ORDER BY student_id;

SELECT student_id FROM enrollments WHERE course_id = 1
EXCEPT
SELECT student_id FROM enrollments WHERE course_id = 2
ORDER BY student_id;

SELECT student_id FROM enrollments WHERE course_id = 1
UNION
SELECT student_id FROM enrollments WHERE course_id = 2
ORDER BY student_id;

SELECT f.faculty_name, i.first_name, i.salary,
       ROW_NUMBER() OVER (PARTITION BY i.faculty_id ORDER BY i.salary DESC) AS row_number,
       RANK() OVER (ORDER BY i.salary DESC) AS salary_rank
FROM instructors AS i
JOIN faculties AS f USING (faculty_id)
ORDER BY f.faculty_id, row_number;

SELECT c.course_name,
       COUNT(*) FILTER (WHERE e.grade = 'A') AS grade_a,
       COUNT(*) FILTER (WHERE e.grade = 'B+') AS grade_b_plus,
       COUNT(*) FILTER (WHERE e.grade = 'B') AS grade_b
FROM courses AS c
LEFT JOIN enrollments AS e USING (course_id)
GROUP BY c.course_id, c.course_name
ORDER BY c.course_id;

EXPLAIN SELECT s.first_name, c.course_name
FROM students AS s
JOIN enrollments AS e USING (student_id)
JOIN courses AS c USING (course_id)
WHERE c.course_name = 'Database Systems';
