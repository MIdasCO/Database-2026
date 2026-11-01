SELECT s.first_name, c.course_name, e.grade
FROM students AS s
INNER JOIN enrollments AS e USING (student_id)
INNER JOIN courses AS c USING (course_id)
ORDER BY s.student_id, c.course_id;

SELECT c.course_name, e.student_id, e.grade
FROM courses AS c
LEFT JOIN enrollments AS e USING (course_id)
ORDER BY c.course_id, e.student_id;

SELECT c.course_name, e.student_id
FROM enrollments AS e
RIGHT JOIN courses AS c USING (course_id)
ORDER BY c.course_id, e.student_id;

SELECT c.course_name, e.student_id
FROM courses AS c
FULL OUTER JOIN enrollments AS e USING (course_id)
ORDER BY c.course_id, e.student_id;

SELECT f.faculty_name, c.course_name
FROM (SELECT * FROM faculties WHERE faculty_id <= 2) AS f
CROSS JOIN (SELECT * FROM courses WHERE course_id <= 2) AS c
ORDER BY f.faculty_id, c.course_id;

SELECT i.first_name AS instructor, m.first_name AS manager
FROM instructors AS i
LEFT JOIN instructors AS m ON i.manager_id = m.instructor_id
ORDER BY i.instructor_id;

SELECT s.first_name, c.course_name, e.semester, e.grade
FROM students AS s
JOIN enrollments AS e USING (student_id)
JOIN courses AS c USING (course_id)
ORDER BY s.student_id, c.course_id;

SELECT c.course_name
FROM courses AS c
LEFT JOIN enrollments AS e USING (course_id)
WHERE e.student_id IS NULL
ORDER BY c.course_id;

CREATE INDEX idx_enrollments_course_id ON enrollments(course_id);
\d enrollments
