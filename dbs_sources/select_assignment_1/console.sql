SELECT *
FROM actor
LIMIT 500;

SELECT actor_id, first_name, last_name
FROM actor
WHERE NOT (first_name = 'KENNETH' OR (last_name = 'TEMPLE' and actor_id < 100))
LIMIT 500;

SELECT *
FROM actor
WHERE first_name IN ('JOHN', 'NICK', 'JOE', 'VIVIEN')
LIMIT 500;



SELECT *
FROM actor
WHERE actor_id NOT IN (1, 3, 5, 7, 20)
LIMIT 500;

SELECT *
FROM actor
WHERE first_name IN ('JOHN', 'NICK', 'JOE', 'VIVIEN')
  AND actor_id NOT IN(
    SELECT actor_id
    FROM actor
    WHERE last_name = 'DEGENERES')
LIMIT 500;


SELECT actor_id
FROM actor
WHERE last_name = 'DEGENERES'
LIMIT 500;

SELECT *
FROM actor
WHERE actor_id BETWEEN 10 AND 20
LIMIT 500;

SELECT *
FROM actor
WHERE actor_id NOT BETWEEN 10 AND 20
LIMIT 500;

SELECT *
FROM actor
WHERE first_name LIKE 'A%' AND first_name LIKE '%A'
LIMIT 500;

SELECT *
FROM actor
WHERE first_name LIKE 'AL%' AND first_name LIKE '%N'
LIMIT 500;

SELECT *
FROM actor
WHERE first_name LIKE 'AL%'
LIMIT 500;

SELECT *
FROM actor
WHERE first_name LIKE 'A__E'
LIMIT 500;

SELECT *
FROM actor
WHERE first_name LIKE 'A__E%'
LIMIT 500;

SELECT *
FROM actor
WHERE first_name LIKE 'A%E%'
LIMIT 500;

SELECT *
FROM actor
WHERE first_name NOT LIKE 'A%' AND first_name NOT LIKE '%A'
LIMIT 500;

SELECT *
FROM actor
WHERE first_name NOT LIKE 'Z%' OR first_name NOT LIKE '%A'
LIMIT 500;

SELECT *
FROM address
LIMIT 500;

SELECT *
FROM address
WHERE address_id BETWEEN 1 AND 5
LIMIT 500;

SELECT *
FROM address
LIMIT 5;

SELECT *
FROM address
LIMIT 6 OFFSET 14;

SELECT *
FROM actor
LIMIT 500;

SELECT CONCAT(first_name, '-', last_name) AS Fullname
FROM actor
ORDER BY Fullname
LIMIT 500;

SELECT district, postal_code
FROM address
ORDER BY district, postal_code DESC
LIMIT 500;