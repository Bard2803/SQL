-- SELECT QUERIES
SELECT * FROM tutor
WHERE manager_id = (
SELECT id FROM manager
WHERE name = 'John');

SELECT * FROM study_group
WHERE id IN (
SELECT study_group_id FROM belongs2group
WHERE tutor_id = (
SELECT id FROM tutor
WHERE name = 'Bob'));

SELECT study_group.name, tutor.name, student.name, student.surname FROM study_group
JOIN belongs2group ON study_group.id = belongs2group.study_group_id
JOIN tutor ON belongs2group.tutor_id = tutor.id
JOIN student ON belongs2group.student_id = student.id
WHERE tutor.name = 'Bob';

SELECT * FROM parent
WHERE id IN (
SELECT parent_id FROM student
WHERE name = 'Emily' AND surname = 'Brown');

-- UPDATE QUERIES
UPDATE student
SET parent_id = (
SELECT id FROM parent
WHERE name = 'Nancy' AND surname = 'Van Pelt')

UPDATE student
SET parent_id = (
SELECT id FROM parent
WHERE name = 'Frank' AND surname = 'Brown');

-- DELETE QUERIES
DELETE FROM belongs2group
WHERE student_id = (
SELECT id FROM student
WHERE name = 'Olivia' AND surname = 'Van Pelt');

DELETE FROM student
WHERE name = 'Olivia' AND surname = 'Van Pelt';

DELETE FROM parent
WHERE name = 'Nancy' AND surname = 'Van Pelt';

DELETE FROM study_group
WHERE name = 'Group2';



