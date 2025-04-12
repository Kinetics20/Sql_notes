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

DROP TABLE table1;
DROP TABLE table2;

SELECT *
from table2
limit 500;

SELECT *
from table1
limit 500;


SELECT *
FROM table1 AS t1
INNER JOIN table2 AS t2 ON t1.ID = t2.ID;


SELECT *
FROM table1 AS t1
INNER JOIN table2 AS t2 USING(ID);

# implicite cross join
SELECT *
FROM table1 AS t1, table2 AS t2;


SELECT *
FROM table1 AS t1
LEFT JOIN table2 AS t2 ON t1.ID = t2.ID;


SELECT *
FROM table1 AS t1
RIGHT JOIN table2 AS t2 ON t1.ID = t2.ID;

SELECT *
FROM table1 AS t1
LEFT JOIN table2 AS t2 ON t1.ID = t2.ID
UNION
SELECT *
FROM table1 AS t1
RIGHT JOIN table2 AS t2 ON t1.ID = t2.ID;

SELECT *
FROM table1 AS t1
JOIN table2 AS t2 ON t1.ID = t2.ID;


SELECT *
FROM table1 AS t1
LEFT OUTER JOIN table2 AS t2 ON t1.ID = t2.ID;

SELECT *
FROM table1 AS t1
LEFT JOIN table2 AS t2 ON t1.ID = t2.ID
UNION
SELECT *
FROM table1 AS t1
RIGHT JOIN table2 AS t2 ON t1.ID = t2.ID;


#            UNION vs UNION ALL
# duuplikaty usuwa (DISTINCT) vs zostawia
# wydajnosc  wolniejszy ( sortowanie) vs szybszy
#

# UNION vs UNION ALL

# | Cecha       | `UNION`                          | `UNION ALL`                    |
# |-------------|----------------------------------|--------------------------------|
# | Duplikaty   | Usuwa duplikaty (`DISTINCT`)     | Zostawia wszystkie             |
# | Wydajność   | Wolniejszy (musi sortować i porównywać) | Szybszy (bez sortowania)       |
# | Czytelność  | Wynik bardziej „czysty"          | Wynik może zawierać powtórzenia |
# | Zastosowanie| Gdy chcesz unikalne dane         | Gdy chcesz pełny zbiór         |


# explicite cross join
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
FROM Employee
LIMIT 500;

SELECT e1.Name AS EmployName, e2.Name AS ManagerName
FROM Employee AS e1
INNER JOIN Employee AS e2 ON e1.Manager = e2.EmployeeID;

SELECT e1.Name AS EmployName, IFNULL(e2.Name, 'Top Manager') AS ManagerName
FROM Employee AS e1
LEFT JOIN Employee AS e2 ON e1.Manager = e2.EmployeeID;


