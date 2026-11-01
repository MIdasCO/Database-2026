CREATE TABLE lab11_people (
    person_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE
);

INSERT INTO lab11_people (first_name, last_name, birth_date)
VALUES ('Aibek', 'Sharshenov', '2002-05-12');

INSERT INTO lab11_people (first_name, last_name, birth_date) VALUES
    ('Ainura', 'Toktomamatova', '2001-09-23'),
    ('Bakyt', 'Mamatov', '2003-01-15'),
    ('Gulzat', 'Sultanova', '2002-07-30');

SELECT * FROM lab11_people ORDER BY person_id;

UPDATE lab11_people SET birth_date = '2002-05-15'
WHERE first_name = 'Aibek' AND last_name = 'Sharshenov';

UPDATE lab11_people SET last_name = 'Updated'
WHERE person_id IN (2, 3);

DELETE FROM lab11_people
WHERE first_name = 'Gulzat' AND last_name = 'Sultanova';

DELETE FROM lab11_people WHERE birth_date < '2002-01-01';

SELECT * FROM lab11_people ORDER BY person_id;
