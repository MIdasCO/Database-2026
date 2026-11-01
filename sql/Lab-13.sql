SELECT COUNT(*) AS total_students, COUNT(birth_date) AS dated_students
FROM students;

SELECT COUNT(DISTINCT faculty_id) AS represented_faculties,
       SUM(salary) AS total_salaries,
       ROUND(AVG(salary), 2) AS average_salary,
       MIN(salary) AS lowest_salary,
       MAX(salary) AS highest_salary
FROM instructors;

SELECT f.faculty_name, COUNT(i.instructor_id) AS instructor_count,
       COALESCE(SUM(i.salary), 0) AS total_salary,
       ROUND(AVG(i.salary), 2) AS average_salary
FROM faculties AS f
LEFT JOIN instructors AS i USING (faculty_id)
GROUP BY f.faculty_id, f.faculty_name
ORDER BY f.faculty_id;

SELECT c.course_name, COUNT(e.student_id) AS enrollment_count,
       STRING_AGG(s.first_name, ', ' ORDER BY s.first_name) AS students
FROM courses AS c
LEFT JOIN enrollments AS e USING (course_id)
LEFT JOIN students AS s USING (student_id)
GROUP BY c.course_id, c.course_name
ORDER BY c.course_id;

SELECT course_id, ARRAY_AGG(grade ORDER BY grade) AS grades
FROM enrollments GROUP BY course_id ORDER BY course_id;

SELECT f.faculty_name, COUNT(e.student_id) AS enrollments
FROM faculties AS f
JOIN courses AS c USING (faculty_id)
LEFT JOIN enrollments AS e USING (course_id)
GROUP BY f.faculty_id, f.faculty_name
HAVING COUNT(e.student_id) >= 2
ORDER BY enrollments DESC;

SELECT first_name, salary,
       ROUND(AVG(salary) OVER (PARTITION BY faculty_id), 2) AS faculty_average
FROM instructors ORDER BY instructor_id;
