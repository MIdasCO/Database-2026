\copy (SELECT student_id, first_name, last_name, email, birth_date FROM students ORDER BY student_id) TO '/private/tmp/auca_lab17_students.csv' WITH (FORMAT csv, HEADER true)

CREATE TABLE lab17_students_copy AS
SELECT student_id, first_name, last_name, email, birth_date
FROM students WITH NO DATA;

\copy lab17_students_copy FROM '/private/tmp/auca_lab17_students.csv' WITH (FORMAT csv, HEADER true)

SELECT COUNT(*) AS source_rows FROM students;
SELECT COUNT(*) AS imported_rows FROM lab17_students_copy;

SELECT COUNT(*) AS mismatched_rows FROM (
    (SELECT student_id, first_name, last_name, email, birth_date FROM students
     EXCEPT
     SELECT student_id, first_name, last_name, email, birth_date FROM lab17_students_copy)
    UNION ALL
    (SELECT student_id, first_name, last_name, email, birth_date FROM lab17_students_copy
     EXCEPT
     SELECT student_id, first_name, last_name, email, birth_date FROM students)
) AS differences;

SELECT * FROM lab17_students_copy ORDER BY student_id;
