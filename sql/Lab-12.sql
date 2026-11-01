SELECT student_id, first_name, last_name FROM students ORDER BY student_id;

SELECT first_name, salary, salary * 0.10 AS potential_bonus
FROM instructors ORDER BY instructor_id;

SELECT first_name, salary FROM instructors
WHERE salary > 90000 AND faculty_id IN (1, 2)
ORDER BY salary DESC;

SELECT first_name, salary FROM instructors
WHERE salary BETWEEN 90000 AND 110000 ORDER BY salary;

SELECT first_name, email FROM students
WHERE first_name LIKE 'A%' OR email ILIKE '%@gmail.com'
ORDER BY student_id;

SELECT first_name, email FROM students
WHERE first_name ~ '^[AB]' ORDER BY student_id;

SELECT first_name, last_name FROM students AS s
WHERE EXISTS (SELECT 1 FROM enrollments AS e
              WHERE e.student_id = s.student_id AND e.grade = 'A')
ORDER BY student_id;

SELECT first_name, salary,
       CASE WHEN salary >= 100000 THEN 'Senior'
            WHEN salary >= 80000 THEN 'Mid-level'
            ELSE 'Junior' END AS level
FROM instructors ORDER BY instructor_id;

WITH faculty_averages AS (
    SELECT faculty_id, AVG(salary) AS avg_salary
    FROM instructors GROUP BY faculty_id
)
SELECT i.first_name, i.salary, f.faculty_name,
       ROUND(fa.avg_salary, 2) AS faculty_average
FROM instructors AS i
JOIN faculty_averages AS fa USING (faculty_id)
JOIN faculties AS f USING (faculty_id)
WHERE i.salary > fa.avg_salary
ORDER BY i.instructor_id;
