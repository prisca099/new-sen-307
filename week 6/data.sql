-- ============================================================
-- VUA-SEN307 Week 6 Practical - Lab 4: DML (Insert, Update, Delete)
-- BEFORE RUNNING: do a Find & Replace for these two placeholders
--   YOUR_MATRIC_NO  -> your real matric number (e.g. 20231234)
--   YOUR FULL NAME  -> your real full name
-- and change the database name on the next line to yours.
-- ============================================================

USE sen307_YOUR_MATRIC_NO;

-- ---------------- PART 1: Departments and Courses (provided) ----------------
INSERT INTO Department (dept_name) VALUES
('Software Engineering'),
('Computer Science'),
('Artificial Intelligence'),
('Data Science'),
('Cybersecurity');

INSERT INTO Course (course_code, course_title, credit_units, description, dept_id) VALUES
('SEN307', 'Database Systems', 3,
 'Relational database design, SQL queries, normalization, transactions and indexing using MySQL.',
 (SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')),
('SEN301', 'Software Architecture', 3,
 'Architectural styles, design patterns, microservices and how to structure large software systems.',
 (SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')),
('COS301', 'Operating Systems', 3,
 'Processes, threads, CPU scheduling, memory management and file systems.',
 (SELECT dept_id FROM Department WHERE dept_name = 'Computer Science')),
('COS305', 'Computer Networks', 3,
 'TCP/IP, routing, switching, LAN and WAN design and network protocols.',
 (SELECT dept_id FROM Department WHERE dept_name = 'Computer Science')),
('AIN301', 'Introduction to Artificial Intelligence', 3,
 'Intelligent agents, search algorithms, knowledge representation and reasoning.',
 (SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),
('AIN305', 'Machine Learning', 3,
 'Supervised and unsupervised learning, neural networks, deep learning and model evaluation.',
 (SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),
('AIN307', 'Natural Language Processing', 3,
 'Text processing, word embeddings, language models, sentiment analysis and chatbots.',
 (SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),
('DTS301', 'Data Visualization and Analytics', 2,
 'Exploratory data analysis, charts, dashboards and telling stories with data.',
 (SELECT dept_id FROM Department WHERE dept_name = 'Data Science')),
('DTS305', 'Big Data Technologies', 3,
 'Distributed storage and processing of very large datasets with Hadoop and Spark.',
 (SELECT dept_id FROM Department WHERE dept_name = 'Data Science')),
('CYB301', 'Network Security', 3,
 'Firewalls, cryptography, intrusion detection and protecting networks from attacks.',
 (SELECT dept_id FROM Department WHERE dept_name = 'Cybersecurity'));

-- Should list 5 departments, 10 courses in total
SELECT d.dept_name, COUNT(c.course_id) AS courses
FROM Department d LEFT JOIN Course c ON d.dept_id = c.dept_id
GROUP BY d.dept_name;

-- Note the IDs (expected: departments 1-5, courses 1-10 in the order above)
SELECT dept_id, dept_name FROM Department;
SELECT course_id, course_code FROM Course;

-- ---------------- PART 2: Your own data ----------------
-- Step 1: Lecturers (10, two per department)
-- dept_id: 1 SE, 2 CS, 3 AI, 4 DS, 5 Cyber  (verify against the query above!)
INSERT INTO Lecturer (staff_no, full_name, email, dept_id) VALUES
('VUA/ST/101', 'Dr Amaka Okafor',    'a.okafor@vua.edu.ng',    1),
('VUA/ST/102', 'Dr Musa Bello',      'm.bello@vua.edu.ng',     1),
('VUA/ST/103', 'Dr Chinedu Eze',     'c.eze@vua.edu.ng',       2),
('VUA/ST/104', 'Dr Fatima Abdullahi','f.abdullahi@vua.edu.ng', 2),
('VUA/ST/105', 'Dr Tunde Adeyemi',   't.adeyemi@vua.edu.ng',   3),
('VUA/ST/106', 'Dr Ngozi Nwosu',     'n.nwosu@vua.edu.ng',     3),
('VUA/ST/107', 'Dr Ibrahim Danjuma', 'i.danjuma@vua.edu.ng',   4),
('VUA/ST/108', 'Dr Blessing Udoh',   'b.udoh@vua.edu.ng',      4),
('VUA/ST/109', 'Dr Segun Balogun',   's.balogun@vua.edu.ng',   5),
('VUA/ST/110', 'Dr Hauwa Suleiman',  'h.suleiman@vua.edu.ng',  5);

-- Step 2: Students (20). Row 1 is YOU. Students 19 and 20 get NO enrolments on purpose.
INSERT INTO Student (matric_no, full_name, gender, date_of_birth, dept_id) VALUES
('YOUR_MATRIC_NO', 'YOUR FULL NAME',        'M', '2005-03-14', 1),
('20231235', 'John Musa',                   'M', '2004-11-02', 2),
('20231236', 'Chiamaka Okeke',              'F', '2005-07-21', 1),
('20231237', 'Yusuf Garba',                 'M', '2003-09-30', 3),
('20231238', 'Aisha Mohammed',              'F', '2006-01-15', 3),
('20231239', 'Emeka Nnamdi',                'M', '2004-05-08', 1),
('20231240', 'Folake Adebayo',              'F', '2005-12-19', 4),
('20231241', 'Samuel Ojo',                  'M', '2003-02-27', 2),
('20231242', 'Zainab Lawal',                'F', '2006-08-11', 5),
('20231243', 'Daniel Eboh',                 'M', '2004-10-03', 4),
('20231244', 'Ifeoma Chukwu',               'F', '2007-04-25', 3),
('20231245', 'Abubakar Sani',               'M', '2005-06-09', 5),
('20231246', 'Temitope Akinola',            'F', '2003-12-01', 2),
('20231247', 'Peter Ikenna',                'M', '2006-03-18', 1),
('20231248', 'Hadiza Umar',                 'F', '2004-07-29', 4),
('20231249', 'Victor Okonkwo',              'M', '2007-01-06', 3),
('20231250', 'Grace Effiong',               'F', '2005-09-13', 5),
('20231251', 'Kelechi Anyanwu',             'M', '2004-02-22', 2),
('20231252', 'Maryam Yakubu',               'F', '2006-11-30', 1),
('20231253', 'Oluwaseun Adeleke',           'M', '2003-06-17', 4);

-- Step 3: Check IDs (students should be 1-20, lecturers 1-10)
SELECT student_id, matric_no, full_name FROM Student;
SELECT lecturer_id, full_name FROM Lecturer;

-- Enrolments: 40 rows, students 1-18 only (19 and 20 stay unenrolled).
-- Course 1 (SEN307) has 7 students. No student appears twice in the same course.
INSERT INTO Enrolment (student_id, course_id) VALUES
(1,1),(1,2),(1,5),
(2,1),(2,3),(2,6),
(3,1),(3,5),(3,8),
(4,1),(4,6),(4,10),
(5,1),(5,2),
(6,1),(6,7),
(7,3),(7,4),
(8,5),(8,6),
(9,5),(9,7),
(10,6),(10,8),
(11,8),(11,9),
(12,9),(12,10),
(13,10),(13,4),
(14,2),(14,3),
(15,4),(15,5),
(16,7),(16,8),
(17,9),(17,1),
(18,10),(18,6);

-- Course allocations: every course has a lecturer; course 1 has TWO (lecturers 1 and 2)
INSERT INTO CourseAllocation (course_id, lecturer_id) VALUES
(1,1),(1,2),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,6),
(8,7),
(9,8),
(10,9);

-- ---------------- PART 3: UPDATE a record ----------------
SELECT matric_no, full_name, dept_id FROM Student WHERE matric_no = 'YOUR_MATRIC_NO';

UPDATE Student SET dept_id = 2 WHERE matric_no = 'YOUR_MATRIC_NO';
-- If you get Error 1175 (safe update mode), run these three lines instead:
-- SET SQL_SAFE_UPDATES = 0;
-- UPDATE Student SET dept_id = 2 WHERE matric_no = 'YOUR_MATRIC_NO';
-- SET SQL_SAFE_UPDATES = 1;

SELECT matric_no, full_name, dept_id FROM Student WHERE matric_no = 'YOUR_MATRIC_NO';

-- ---------------- PART 4: Referential integrity ----------------
-- Step 1: department with a student in it
INSERT INTO Department (dept_name) VALUES ('Library and Information Science');

INSERT INTO Student (matric_no, full_name, dept_id)
VALUES ('20239999', 'Transfer Student',
        (SELECT dept_id FROM Department WHERE dept_name = 'Library and Information Science'));

-- Step 2: this DELETE is EXPECTED TO FAIL with Error 1451.
-- Run it ALONE (select just this line, then Ctrl+Enter), screenshot the error,
-- and then leave it commented so the rest of the script runs top-to-bottom.
-- DELETE FROM Department WHERE dept_name = 'Library and Information Science';

-- Step 3: fix it properly
-- (a) reassign the dependent student
UPDATE Student
SET dept_id = (SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')
WHERE matric_no = '20239999';

-- (b) now the delete succeeds
DELETE FROM Department WHERE dept_name = 'Library and Information Science';

SELECT * FROM Department;   -- back to 5 departments

-- ---------------- FINAL CHECK ----------------
SELECT 'Departments' AS tbl, COUNT(*) AS total FROM Department
UNION ALL SELECT 'Lecturers',   COUNT(*) FROM Lecturer
UNION ALL SELECT 'Students',    COUNT(*) FROM Student
UNION ALL SELECT 'Courses',     COUNT(*) FROM Course
UNION ALL SELECT 'Enrolments',  COUNT(*) FROM Enrolment
UNION ALL SELECT 'Allocations', COUNT(*) FROM CourseAllocation;
