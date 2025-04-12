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
    INNER JOIN Classes cl on sc.ClassId = cl.ClassId;


SELECT *
FROM Students AS st
WHERE st.StudentId IN (SELECT DISTINCT sc.StudentId
                        FROM StudentClass AS sc
                        )
LIMIT 500;

SELECT
    (SELECT st.StudentName FROM Students st WHERE st.StudentId = sc.StudentId) AS StudentName,
    (SELECT cl.ClassName FROM Classes cl WHERE cl.ClassId = sc.ClassId ) AS ClassName

FROM StudentClass sc;


SELECT DISTINCT st.StudentName
FROM Students st
LEFT JOIN StudentClass AS sc ON st.StudentId = sc.StudentId
WHERE sc.ClassId IS NULL;

SELECT
    DISTINCT (SELECT st.studentName FROM Students st WHERE st.StudentId = sc.StudentId) AS StudentName
FROM StudentClass sc;


SELECT st.StudentName
FROM Students st
WHERE st.StudentId NOT IN (SELECT DISTINCT sc.studentID
                           FROM StudentClass sc);
# clienty ktorzy kochaja dramy id imie i nazwisko

select *
from category
WHERE name LIKE '%dra%';


# filmy z kategorii drama

SELECT ct.name, fl.*
FROM film AS fl
            INNER JOIN film_category AS fc ON fl.film_id = fc.film_id
            INNER  JOIN sakila.category ct on fc.category_id = ct.category_id
WHERE ct.name = 'Drama';


SELECT fl.*
FROM film AS fl
WHERE fl.film_id IN (SELECT fc.film_id
                         FROM film_category AS fc
                         WHERE fc.category_id IN (SELECT ct.category_id
                                                  FROM category AS ct
                                                  WHERE ct.name = 'DRAMA'));


SELECT DISTINCT ct.customer_id, ct.first_name, ct.last_name, COUNT(*) AS rental_drama_count
FROM customer AS ct
    INNER JOIN sakila.rental ren on ct.customer_id = ren.customer_id
    INNER JOIN sakila.inventory inv on ren.inventory_id = inv.inventory_id
    INNER JOIN sakila.film_category fc ON fc.film_id = inv.film_id
    INNER JOIN sakila.category c on fc.category_id = c.category_id
WHERE c.name = 'DRAMA'
GROUP BY ct.customer_id
ORDER BY rental_drama_count DESC
LIMIT 500;


SELECT ct.customer_id, ct.first_name, ct.last_name
FROM customer ct
WHERE ct.customer_id IN (SELECT ren.customer_id
                         FROM rental ren
                         WHERE ren.inventory_id IN (SELECT inv.inventory_id
                                                    FROM inventory inv
                                                    WHERE inv.film_id IN (SELECT ct.film_id
                                                                          FROM film_category ct
                                                                          WHERE ct.category_id IN (SELECT c.category_id
                                                                                                FROM category c
                                                                                                WHERE c.name = 'DRAMA'))))
ORDER BY ct.customer_id ;


SELECT ct.customer_id,
       ct.first_name,
       ct.last_name,
       (SELECT COUNT(*) FROM rental ren WHERE ren.customer_id = ct.customer_id) AS rentals_count
FROM customer ct
WHERE ct.customer_id IN (SELECT ren.customer_id
                         FROM rental ren);




