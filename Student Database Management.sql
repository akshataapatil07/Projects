-- Create Database
CREATE DATABASE StudentDatabaseManagement;

-- Use the Database
USE StudentDatabaseManagement;

-- Create Students Table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Address VARCHAR(255),
    ContactNumber VARCHAR(15)
);

-- Create Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100),
    HeadOfDepartment VARCHAR(100)
);

-- Create Courses Table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create Enrollments Table
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    Grade CHAR(2),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Create Attendance Table
CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    AttendanceDate DATE,
    Status VARCHAR(10),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

INSERT INTO Students (FirstName, LastName, DateOfBirth, Address, ContactNumber)
VALUES ('John', 'Doe', '2000-01-01', '123 Main St', '123-456-7890');

SELECT * FROM Students;

UPDATE Students
SET Address = '456 Elm St'
WHERE StudentID = 1;

DELETE FROM Students
WHERE StudentID = 1;

INSERT INTO Departments (DepartmentName, HeadOfDepartment)
VALUES ('Computer Science', 'Dr. Smith');

INSERT INTO Courses (CourseName, DepartmentID)
VALUES ('Database Systems', 1);

-- Check if the student exists
SELECT * FROM Students WHERE StudentID = 1;

-- If the student does not exist, insert the student
INSERT INTO Students (FirstName, LastName, DateOfBirth, Address, ContactNumber)
VALUES ('John', 'Doe', '2000-01-01', '123 Main St', '123-456-7890');

-- Check if the course exists
SELECT * FROM Courses WHERE CourseID = 1;

-- If the course does not exist, insert the course
INSERT INTO Courses (CourseName, DepartmentID)
VALUES ('Database Systems', 1);


-- Check for Existing Students
SELECT * FROM Students;

-- Insert Student Record if not exists
INSERT INTO Students (FirstName, LastName, DateOfBirth, Address, ContactNumber)
VALUES ('John', 'Doe', '2000-01-01', '123 Main St', '123-456-7890');

-- Check for Existing Courses
SELECT * FROM Courses;

-- Insert Course Record if not exists
INSERT INTO Courses (CourseName, DepartmentID)
VALUES ('Database Systems', 1);

-- Check for Existing Departments
SELECT * FROM Departments;

-- Insert Department Record if not exists
INSERT INTO Departments (DepartmentName, HeadOfDepartment)
VALUES ('Computer Science', 'Dr. Smith');

-- Insert Enrollment Record
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate, Grade)
VALUES (2, 1, '2024-01-01', 'A');

-- Show table structure for Students
SHOW CREATE TABLE Students;

-- Show table structure for Courses
SHOW CREATE TABLE Courses;

-- Show table structure for Enrollments
SHOW CREATE TABLE Enrollments;

SELECT s.*
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.DepartmentID = 1;

SELECT c.CourseName
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
WHERE e.StudentID = 1;

SELECT a.AttendanceDate, a.Status
FROM Attendance a
WHERE a.StudentID = 1;

UPDATE Students
SET Address = '456 Elm St'
WHERE StudentID = 1;

UPDATE Enrollments
SET Grade = 'B+'
WHERE StudentID = 1 AND CourseID = 1;

DELETE FROM Students
WHERE StudentID = 1;


SELECT s.FirstName, s.LastName, e.Grade
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.CourseID = 1;


-- Finally, insert the enrollment record
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate, Grade)
VALUES (1, 1, '2024-01-01', 'A');


INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate, Grade)
VALUES (1, 1, '2024-01-01', 'A');



