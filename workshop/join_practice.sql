CREATE TABLE table1
(ID INT, Value VARCHAR(10));

INSERT INTO table1 (ID, Value)
SELECT 1,'First'
UNION ALL
SELECT 2,'Second'
UNION ALL
SELECT 3,'Third'
UNION ALL
SELECT 4,'Fourth'
UNION ALL
SELECT 5,'Fifth';

SELECT *
FROM table1
LIMIT 500;

-- Create table 2
CREATE TABLE table2
(ID INT, Value VARCHAR(10));

INSERT INTO table2 (ID, Value)
SELECT 1,'First'
UNION ALL
SELECT 2,'Second - 2'
UNION ALL
SELECT 3,'Third'
UNION ALL
SELECT 6,'Sixth'
UNION ALL
SELECT 7,'Seventh'
UNION ALL
SELECT 8,'Eighth';

SELECT *
FROM table2
LIMIT 500;

SELECT *
FROM table1 AS t1
INNER JOIN table2 AS t2 ON t1.ID = t2.ID;

SELECT *
FROM table1 AS t1
INNER JOIN table2 AS t2 USING(ID);

SELECT *
FROM table1 AS t1, table2 AS t2;

SELECT *
FROM table1 AS t1
LEFT JOIN table2 AS t2 ON t1.ID = t2.ID;

SELECT *
FROM table1 AS t1
RIGHT JOIN table2 AS t2 ON t1.ID = t2.ID;

SELECT *
FROM table2
LIMIT 500;

SELECT *
FROM table1
LIMIT 500;

SELECT *
FROM table1 AS t1
LEFT JOIN table2 AS t2 ON t1.ID = t2.ID
UNION
SELECT *
FROM table1 AS t1
RIGHT JOIN table2 AS t2 ON t1.ID = t2.ID;

SELECT *
FROM table1 AS t1
CROSS JOIN table2 AS t2;


CREATE TABLE Employee(
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Manager INT
);


INSERT INTO Employee (EmployeeID, Name, Manager)
VALUES (1, 'Piotr', 3),
       (2, 'Mateusz', 3),
       (3, 'CEzary', NULL),
       (4, 'Tomasz', 2),
       (5, 'Marcin', 2),
       (6, 'Andrzej', 2);

SELECT *
FROM Employee;


SELECT e1.Name AS EmployeeName, e2.Name AS ManagerName
FROM Employee AS e1
INNER JOIN Employee AS e2 ON e1.Manager = e2.EmployeeID;

SELECT e1.Name AS EmployeeName, IFNULL(e2.Name, 'Supervisor') AS ManagerName
FROM Employee AS e1
LEFT JOIN Employee AS e2 ON e1.Manager = e2.EmployeeID;

-- Students
CREATE TABLE Students
(
    StudentId   INT,
    StudentName VARCHAR(10)
);



INSERT INTO Students (StudentId, StudentName)
SELECT 1, 'John'
UNION ALL
SELECT 2, 'Matt'
UNION ALL
SELECT 3, 'James';


-- Classes
CREATE TABLE Classes
(
    ClassId   INT,
    ClassName VARCHAR(10)
);


INSERT INTO Classes (ClassId, ClassName)
SELECT 1, 'Maths'
UNION ALL
SELECT 2, 'Arts'
UNION ALL
SELECT 3, 'History';


-- StudentClass
CREATE TABLE StudentClass
(
    StudentId INT,
    ClassId   INT
);



INSERT INTO StudentClass (StudentId, ClassId)
SELECT 1, 1
UNION ALL
SELECT 1, 2
UNION ALL
SELECT 3, 1
UNION ALL
SELECT 3, 2
UNION ALL
SELECT 3, 3;


SELECT *
FROM Students;


SELECT *
FROM Classes;

SELECT *
FROM StudentClass;

SELECT st.StudentName, cl.ClassName
FROM Students AS st
INNER JOIN StudentClass AS sc ON st.StudentId = sc.StudentId
INNER JOIN Classes AS cl ON sc.ClassId = cl.ClassId;


SELECT
    (SELECT st.StudentName
    FROM Students st
    WHERE st.StudentId = sc.StudentId) AS StudentName
FROM StudentClass sc;


SELECT
    (SELECT st.StudentName FROM Students st WHERE st.StudentId = sc.StudentId) AS StudentName,
    (SELECT cl.ClassName FROM Classes cl WHERE cl.ClassId = sc.ClassId) AS ClassName

FROM StudentClass sc;

SELECT DISTINCT st.StudentName
FROM Students st
LEFT JOIN StudentClass sc ON st.StudentId = sc.StudentId
WHERE sc.ClassId IS NULL;

SELECT DISTINCT
        (SELECT st.StudentName
        FROM Students st
        WHERE st.StudentId = sc.StudentId) AS StudentName
FROM StudentClass sc;

SELECT st.StudentName
FROM Students st
WHERE st.StudentId NOT IN (
    SELECT DISTINCT sc.StudentId
        FROM StudentClass sc
    );

SELECT *
FROM category
WHERE name LIKE '%ass%'
LIMIT 500;