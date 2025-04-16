

DROP VIEW secure_data;

# DML operation

SELECT *
FROM language;

CREATE VIEW dml_operation
AS
SELECT *
FROM language;

SELECT *
FROM dml_operation;

# INSERT / create / through VIEW dml_operation

INSERT INTO dml_operation (name, last_update)
VALUES ('Suahili', '2025-04-16 12:22');

# UPDATE / change exist value / through VIEW dml_operation

UPDATE dml_operation
SET name = 'Irish'
WHERE name = 'Suahili';

UPDATE dml_operation
SET name = 'Polish'
WHERE language_id = 7;

# DELETE

SELECT
FROM dml_operation
WHERE language_id = 7;

DELETE
FROM dml_operation
WHERE language_id = 7;

SHOW CREATE TABLE language;


CREATE VIEW dml_operation_2
AS
SELECT language_id, last_update
FROM language;

SELECT *
FROM dml_operation_2
LIMIT 500;

INSERT INTO dml_operation_2 (name, last_update)
VALUES ('Polish','2025-04-16 12:22');

UPDATE dml_operation_2
SET last_update= '2025-04-16 12:22'
WHERE language_id = 6;

SELECT *
FROM language
LIMIT 500;

CREATE VIEW dml_operation_3
AS
SELECT *
FROM language
WHERE YEAR(last_update) < 2010;

SELECT *
FROM dml_operation_3
LIMIT 500;

UPDATE dml_operation_3
SET last_update = '2008-03-22 12:17'
WHERE language_id = 6;

CREATE VIEW dml_operation_4
AS
SELECT *
FROM language
WHERE YEAR(last_update) < 2010
WITH CHECK OPTION ;


SELECT *
FROM dml_operation_4
LIMIT 500;


UPDATE dml_operation_4
SET last_update = '2008-03-22 12:17'
WHERE language_id = 5;

SELECT *
FROM dml_operation_4
LIMIT 500;

SELECT *
FROM language
LIMIT 500;

UPDATE dml_operation_4
SET last_update = '2020-03-22 12:17'
WHERE language_id = 5;

UPDATE dml_operation_3
SET last_update = '2020-03-22 12:17'
WHERE language_id = 5;