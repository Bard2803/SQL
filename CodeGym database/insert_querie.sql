-- Insert managers
INSERT INTO manager (name, surname, birthdate) VALUES ('John', 'Doe', '1980-01-01');
INSERT INTO manager (name, surname, birthdate) VALUES ('Jane', 'Doe', '1981-01-01');

-- Insert tutors
INSERT INTO tutor (name, surname, birthdate, manager_id) VALUES ('Alice', 'Smith', '1990-01-01', 1);
INSERT INTO tutor (name, surname, birthdate, manager_id) VALUES ('Bob', 'Johnson', '1991-01-01', 1);
INSERT INTO tutor (name, surname, birthdate, manager_id) VALUES ('Charlie', 'Brown', '1992-01-01', 2);
INSERT INTO tutor (name, surname, birthdate, manager_id) VALUES ('David', 'Davis', '1993-01-01', 2);

-- Insert study groups
INSERT INTO study_group (name, creation_date, start_date, end_date, programming_language) VALUES ('Group1', '2022-01-01', '2022-02-01', '2022-03-01', 'Python');
INSERT INTO study_group (name, creation_date, start_date, end_date, programming_language) VALUES ('Group2', '2022-01-02', '2022-02-02', '2022-03-02', 'Java');

-- Insert parents
INSERT INTO parent (name, surname, birthdate) VALUES ('Frank', 'Brown', '1975-01-01');
INSERT INTO parent (name, surname, birthdate) VALUES ('Nancy', 'Van Pelt', '1976-01-01');

-- Insert students
INSERT INTO student (name, surname, birthdate, parent_id) VALUES ('Emily', 'Brown', '2005-01-01', 1);
INSERT INTO student (name, surname, birthdate, parent_id) VALUES ('Ethan', 'Brown', '2006-01-01', 1);
INSERT INTO student (name, surname, birthdate, parent_id) VALUES ('Olivia', 'Van Pelt', '2007-01-01', 2);
INSERT INTO student (name, surname, birthdate, parent_id) VALUES ('Owen', 'Van Pelt', '2008-01-01', 2);

-- Insert group memberships
INSERT INTO belongs2group (study_group_id, student_id, tutor_id) VALUES (1, 1, 1);
INSERT INTO belongs2group (study_group_id, student_id, tutor_id) VALUES (1, 2, 1);
INSERT INTO belongs2group (study_group_id, student_id, tutor_id) VALUES (2, 3, 2);
INSERT INTO belongs2group (study_group_id, student_id, tutor_id) VALUES (2, 4, 2);
INSERT INTO belongs2group (study_group_id, student_id, tutor_id) VALUES (1, 3, 3);
INSERT INTO belongs2group (study_group_id, student_id, tutor_id) VALUES (1, 4, 3);
INSERT INTO belongs2group (study_group_id, student_id, tutor_id) VALUES (2, 1, 4);
INSERT INTO belongs2group (study_group_id, student_id, tutor_id) VALUES (2, 2, 4);

