-- Create the Students table
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Create the Faculty table
CREATE TABLE faculty (
    faculty_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT,
    email VARCHAR(100) UNIQUE NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Create the Departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) UNIQUE NOT NULL
);

-- Create the Courses table
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_code VARCHAR(10) UNIQUE NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    faculty_id INT,
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
);

-- Create the Enrollments table
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    enrollment_date DATE NOT NULL,
    grade DECIMAL(3,2),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Insert sample data
INSERT INTO students (first_name, last_name, date_of_birth, email) 
VALUES ('brono', 'mar', '2000-12-15', 'bronomar@gmail.com');

INSERT INTO departments (department_name) 
VALUES ('Computer Science');

INSERT INTO faculty (first_name, last_name, department_id, email) 
VALUES ('John', 'Doe', 1, 'jdoe@university.com');

INSERT INTO courses (course_code, course_name, faculty_id) 
VALUES ('CS101', 'Introduction to Programming', 1);

INSERT INTO enrollments (student_id, course_id, enrollment_date, grade) 
VALUES (1, 1, '2025-03-28', 85.5);

-- Queries
-- 1. Retrieve all students enrolled in a specific course
SELECT s.student_id, s.first_name, s.last_name, c.course_code, c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_code = 'CS101';


-- 2. Find all faculty members in a particular department
SELECT f.faculty_id, f.first_name, f.last_name 
FROM faculty f
WHERE f.department_id = 1;

-- 3. List all courses a particular student is enrolled in
SELECT c.course_code, c.course_name 
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
WHERE e.student_id = 1;

-- 4. Retrieve students who have not enrolled in any course
SELECT s.student_id, s.first_name, s.last_name 
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

-- 5. Find the average grade of students in a specific course
SELECT c.course_code, c.course_name, AVG(e.grade) as average_grade
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
WHERE c.course_code = 'CS101'
GROUP BY c.course_id, c.course_code, c.course_name;
