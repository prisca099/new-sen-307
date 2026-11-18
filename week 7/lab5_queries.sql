
-- VUA-SEN307 Lab 5: SELECT, Filtering and Joins
-- Name: NJOUK PRISCA NKECHI  Matric: vug_sen_24_11862


USE sen_307_11862;


SELECT 'Departments' AS tbl, COUNT(*) AS total FROM Department
UNION ALL SELECT 'Lecturers',   COUNT(*) FROM Lecturer
UNION ALL SELECT 'Students',    COUNT(*) FROM Student
UNION ALL SELECT 'Courses',     COUNT(*) FROM Course
UNION ALL SELECT 'Enrolments',  COUNT(*) FROM Enrolment
UNION ALL SELECT 'Allocations', COUNT(*) FROM CourseAllocation;


-- Task 1: Students in one department, sorted A-Z

SELECT s.matric_no, s.full_name, d.dept_name
FROM Student s
INNER JOIN Department d ON s.dept_id = d.dept_id
WHERE d.dept_name = 'Software Engineering'
ORDER BY s.full_name ASC;
-- Explanation: Student only stores a dept_id number, so I join it to Department
-- to get the department name. The WHERE clause keeps only Software Engineering
-- students and ORDER BY s.full_name ASC sorts them alphabetically A-Z.


-- Task 2: Courses with their lecturers (INNER JOIN)

SELECT c.course_code, c.course_title, l.full_name AS lecturer
FROM Course c
INNER JOIN CourseAllocation ca ON c.course_id = ca.course_id
INNER JOIN Lecturer l ON ca.lecturer_id = l.lecturer_id
ORDER BY c.course_code, l.full_name;
-- Explanation: Course and Lecturer are not linked directly. CourseAllocation sits
-- between them, so I join Course -> CourseAllocation -> Lecturer. INNER JOIN keeps
-- only rows that match in every table. SEN307 appears twice because it is taught
-- by two lecturers.


-- Task 3: Students and their courses (LEFT JOIN)

SELECT s.full_name, c.course_title
FROM Student s
LEFT JOIN Enrolment e ON s.student_id = e.student_id
LEFT JOIN Course c ON e.course_id = c.course_id
ORDER BY s.full_name;
-- Explanation: LEFT JOIN keeps every student (the left table) even if they have no
-- enrolment. For those students the course_title column is NULL.

-- Task 3 (part b): only the students with no courses
SELECT s.full_name, c.course_title
FROM Student s
LEFT JOIN Enrolment e ON s.student_id = e.student_id
LEFT JOIN Course c ON e.course_id = c.course_id
WHERE c.course_title IS NULL
ORDER BY s.full_name;
-- Explanation: Adding WHERE c.course_title IS NULL keeps only the unmatched rows.
-- This shows the two students I created in Week 6 with no enrolments.
-- (Use IS NULL, not = NULL, because NULL is never equal to anything.)


-- Task 4: Filtering with AND / OR / IN / BETWEEN

SELECT matric_no, full_name, gender, date_of_birth, dept_id
FROM Student
WHERE gender = 'F'
  AND dept_id IN (1, 3)
  AND date_of_birth BETWEEN '2004-01-01' AND '2005-12-31'
ORDER BY full_name;
-- Explanation: This uses AND, IN and BETWEEN together. It returns female students
-- in department 1 (Software Engineering) or 3 (Artificial Intelligence) who were
-- born between 2004-01-01 and 2005-12-31 (BETWEEN includes both end dates).

-- Task 4 (part b): the same idea with OR, using brackets
SELECT matric_no, full_name, gender, date_of_birth, dept_id
FROM Student
WHERE (dept_id = 1 OR dept_id = 3)
  AND gender = 'M'
  AND date_of_birth BETWEEN '2003-01-01' AND '2005-12-31'
ORDER BY full_name;
-- Explanation: Brackets around the OR make MySQL test "department 1 or 3" first and
-- then apply the AND conditions. Without brackets, AND is evaluated before OR and
-- the result would be wrong.


-- Task 5: Paginating enrolments with LIMIT and OFFSET

-- Page 1 (rows 1-10)
SELECT * FROM Enrolment
ORDER BY enrolment_id
LIMIT 10 OFFSET 0;
-- Explanation: LIMIT 10 returns 10 rows and OFFSET 0 starts at the first row.

-- Page 2 (rows 11-20)
SELECT * FROM Enrolment
ORDER BY enrolment_id
LIMIT 10 OFFSET 10;
-- Explanation: OFFSET 10 skips the first 10 rows, so this returns rows 11-20.
-- Why ORDER BY is always needed with LIMIT: a table has no guaranteed row order.
-- Without ORDER BY, MySQL may return rows in a different order each time, so pages
-- could repeat or miss rows. ORDER BY enrolment_id makes the order fixed.


-- Challenge: Task 3 rewritten with RIGHT JOIN
SELECT s.full_name, c.course_title
FROM Course c
RIGHT JOIN Enrolment e ON e.course_id = c.course_id
RIGHT JOIN Student s ON s.student_id = e.student_id
ORDER BY s.full_name;
-- Explanation: I swapped the table order so Student is now on the right, and used
-- RIGHT JOIN, which keeps all rows from the right table. The result is the same as
-- the LEFT JOIN version.
-- Which is easier to read? The LEFT JOIN version. It starts from the main table
-- (Student) and reads left to right as "all students, plus their courses". The RIGHT
-- JOIN version makes you read backwards, and most developers rewrite RIGHT JOIN as
-- LEFT JOIN for that reason.
