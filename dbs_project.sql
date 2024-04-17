USE project1;
-- Write the commands for creating tables and inserting values --
CREATE TABLE Course (
    course_ID varchar(10) PRIMARY KEY,
    department VARCHAR(50),
    course_number INT,
    course_name VARCHAR(100),
    semester TEXT,
    year INT
);

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);
CREATE TABLE Assignment (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT,
    assignment_name VARCHAR(100),
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);
CREATE TABLE Enrollment (
    enrollment_id INT PRIMARY KEY,
    course_id INT,
    student_id INT,
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);
CREATE TABLE Category (
    category_id INT PRIMARY KEY,
    course_id INT,
    category_name VARCHAR(50),
    weight_percentage FLOAT,
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE Grades (
    grade_id INT PRIMARY KEY,
    category_id INT,
    student_id INT,
    assignment_name VARCHAR(100),
    score FLOAT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);
INSERT INTO Course (course_id, department, course_number, course_name, semester, year)
VALUES 
    ('CS1', 'Computer Science', 101, 'Introduction to Computer Science', 'Fall', 2023),
    (2, 'Computer Science', 201, 'Data Structures and Algorithms', 'Fall', 2023),
    (3, 'Computer Science', 301, 'Database Systems', 'Spring', 2024),
    (4, 'Computer Science', 401, 'Software Engineering', 'Spring', 2024),
    (5, 'Computer Science', 501, 'Machine Learning', 'Fall', 2024);
INSERT INTO Student (student_id, first_name, last_name)
VALUES 
    (101, 'Richard', 'Davis'),
    (202, 'Jeneel', 'Farrell'),
    (303, 'Monica', 'Halsey'),
    (404, 'Jared', 'Lacey'),
    (505, 'Kayla', 'Vezile'),
    (606, 'Khanya', 'Lodge'),
    (701, 'Mia', 'Felix'),
    (808, 'Lori', 'White'),
    (999, 'Peter', 'Gfiffin'),
    (102, 'Will', 'Smith');



ALTER TABLE Enrollment DROP FOREIGN KEY enrollment_ibfk_1;
ALTER TABLE Category DROP FOREIGN KEY category_ibfk_1;

ALTER TABLE Course MODIFY COLUMN course_id VARCHAR(10);

CREATE TEMPORARY TABLE TempCourse AS
SELECT course_id
FROM Course;

UPDATE Course
SET course_id = CONCAT('CS', course_id)
WHERE course_id IN (SELECT course_id FROM TempCourse);

DROP TEMPORARY TABLE IF EXISTS TempCourse;


ALTER TABLE Grades DROP FOREIGN KEY grades_ibfk_1; 
ALTER TABLE Enrollment DROP COLUMN enrollment_id;

INSERT INTO Enrollment (course_id, student_id)
VALUES 
    (1, 101),
    (2, 202),
    (3, 303),
    (4, 404),
    (5, 505),
    (1, 606),
    (2, 701),
    (3, 808),
    (4, 999),
    (5, 102);

ALTER TABLE Grades 
ADD COLUMN assignment_id INT,
ADD FOREIGN KEY (assignment_id) REFERENCES Assignment(assignment_id);

INSERT INTO Category (category_id, course_id, category_name, weight_percentage)
VALUES 
    (1, 1, 'Participation', 10),
    (2, 1, 'Homework', 20),
    (3, 1, 'Tests', 50),
    (4, 1, 'Projects', 20),
    
    (5, 2, 'Participation', 10),
    (6, 2, 'Homework', 20),
    (7, 2, 'Tests', 50),
    (8, 2, 'Projects', 20),

    (9, 3, 'Participation', 10),
    (10, 3, 'Homework', 20),
    (11, 3, 'Tests', 50),
    (12, 3, 'Projects', 20);

ALTER TABLE Grades DROP COLUMN grade_id;

INSERT INTO Grades (category_id, student_id, assignment_name, score)
VALUES 
    (1, 101, 'Participation', 85),
    (2, 101, 'HW1', 90),
    (3, 101, 'Midterm', 75),
    (4, 101, 'Project1', 80),
    
    (1, 202, 'Participation', 90),
    (2, 202, 'HW1', 85),
    (3, 202, 'Midterm', 80),
    (4, 202, 'Project1', 95),
    
    (1, 303, 'Participation', 80),
    (2, 303, 'HW1', 88),
    (3, 303, 'Midterm', 85),
    (4, 303, 'Project1', 92),
    
    (1, 404, 'Participation', 75),
    (2, 404, 'HW1', 82),
    (3, 404, 'Midterm', 78),
    (4, 404, 'Project1', 88),

    (1, 505, 'Participation', 85),
    (2, 505, 'HW1', 90),
    (3, 505, 'Midterm', 85),
    (4, 505, 'Project1', 95),
    
    (1, 606, 'Participation', 80),
    (2, 606, 'HW1', 85),
    (3, 606, 'Midterm', 75),
    (4, 606, 'Project1', 80),
    
    (1, 701, 'Participation', 90),
    (2, 701, 'HW1', 95),
    (3, 701, 'Midterm', 85),
    (4, 701, 'Project1', 90),

    (1, 808, 'Participation', 85),
    (2, 808, 'HW1', 80),
    (3, 808, 'Midterm', 82),
    (4, 808, 'Project1', 88),
    
    (1, 999, 'Participation', 95),
    (2, 999, 'HW1', 90),
    (3, 999, 'Midterm', 92),
    (4, 999, 'Project1', 85),
    

    (1, 102, 'Participation', 88),
    (2, 102, 'HW1', 85),
    (3, 102, 'Midterm', 90),
    (4, 102, 'Project1', 95);


-- Compute the average, maximum, and minimum scores for all assignments
SELECT AVG(score) AS average_score, MAX(score) AS highest_score, MIN(score) AS lowest_score
FROM Grades;

-- Optionally, if you want to include the assignment name in the result:
SELECT assignment_name, AVG(score) AS average_score, MAX(score) AS highest_score, MIN(score) AS lowest_score
FROM Grades
GROUP BY assignment_name;

INSERT INTO Assignment (category_id, assignment_name)
VALUES (category_id_value, 'HW2');


SELECT category_id FROM Category WHERE category_name = 'Homework';
INSERT INTO Assignment (category_id, assignment_name)
VALUES (2, 'HW2'); 

-- Assuming course_id_value refers to the specific course ID where you want to make changes
UPDATE Category
SET weight_percentage = 
    CASE 
        WHEN category_name = 'Participation' THEN 5
        WHEN category_name = 'Homework' THEN 25
        ELSE weight_percentage -- Keep the existing weight_percentage for other categories
    END
WHERE course_id = 1
AND category_name IN ('Participation', 'Homework');

UPDATE Grades
SET score = score + 2
WHERE category_id IS NOT NULL AND student_id IS NOT NULL AND assignment_name IS NOT NULL
AND student_id IN (SELECT student_id FROM Student WHERE last_name LIKE '%Q%');

SELECT student_id, SUM(score * weight_percentage / 100) AS total_grade
FROM Grades
JOIN Category ON Grades.category_id = Category.category_id
GROUP BY student_id;


SELECT student_id, SUM(score * weight_percentage / 100) AS total_grade
FROM (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY category_id, student_id ORDER BY score ASC) AS ranking
    FROM Grades
) ranked_grades
JOIN Category ON ranked_grades.category_id = Category.category_id
WHERE ranking > 1
GROUP BY student_id;

SELECT * FROM Course;
SELECT * FROM Student;
SELECT * FROM Assignment;
SELECT * FROM Enrollment;
SELECT * FROM Category;
SELECT * FROM Grades;


