CREATE TABLE manager(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    surname VARCHAR(64) NOT NULL,
    birthdate DATE
);

CREATE TABLE tutor(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    surname VARCHAR(64) NOT NULL,
    birthdate DATE,
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES manager(id)
);

CREATE TABLE study_group(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    creation_date DATE,
    start_date DATE,
    end_date DATE,
    programming_language VARCHAR(32)
);

CREATE TABLE student(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    surname VARCHAR(64) NOT NULL,
    birthdate DATE,
    parent_id INT
    FOREIGN KEY (parent_id) REFERENCES parent(id)
);

CREATE TABLE parent(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    surname VARCHAR(64) NOT NULL,
    birthdate DATE
);

CREATE TABLE belongs2group(
    id INT AUTO_INCREMENT PRIMARY KEY,
    study_group_id INT,
    student_id INT,
    tutor_id INT,
    FOREIGN KEY (study_group_id) REFERENCES study_group (id),
    FOREIGN KEY (student_id) REFERENCES student (id),
    FOREIGN KEY (tutor_id) REFERENCES tutor (id)
);

CREATE TABLE timetable(
    id INT AUTO_INCREMENT PRIMARY KEY,
    study_group_id INT,
    day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', ' Friday', 'Saturday', 'Sunday') NOT NULL,
    start_time TIME,
    end_time TIME,
    FOREIGN KEY (study_group_id) REFERENCES study_group (id)
);