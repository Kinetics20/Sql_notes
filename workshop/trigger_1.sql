SELECT *
FROM language
LIMIT 500;

CREATE TABLE  audit_language (
    language_id TINYINT,
    name CHAR(20),
    last_update TIMESTAMP,
    row_value CHAR(20)
);

DROP TABLE audit_language;

SELECT *
FROM audit_language
LIMIT 500;

DELIMITER //

CREATE TRIGGER language_after_update
    AFTER UPDATE
    ON language
    FOR EACH ROW

BEGIN
    INSERT INTO audit_language (language_id, name, last_update, row_value)
    VALUES (OLD.language_id, OLD.name, OLD.last_update, 'before update');

    INSERT INTO audit_language (language_id, name, last_update, row_value)
    VALUES (NEW.language_id, NEW.name, NEW.last_update, 'after update');

END //

DELIMITER ;

UPDATE language
SET name = 'Python'
WHERE name = 'SQL';

SELECT *
FROM audit_language
LIMIT 500;

DROP TRIGGER language_after_update;


DELIMITER //

CREATE TRIGGER language_before_insert
    BEFORE INSERT
    ON  language
    FOR EACH ROW

BEGIN

    SET NEW.name = CONCAT(UPPER(SUBSTRING(NEW.name, 1, 1)), LOWER(SUBSTRING(NEW.name FROM 2)));

CREATE TRIGGER language_before_update
    BEFORE UPDATE
    ON  language
    FOR EACH ROW

BEGIN

    SET NEW.name = CONCAT(UPPER(SUBSTRING(NEW.name, 1, 1)), LOWER(SUBSTRING(NEW.name FROM 2)));


END //

DELIMITER ;


DROP TRIGGER language_before_update;

INSERT INTO language (name)
VALUES ('suahILI');

SELECT *
FROM language
LIMIT 500;


UPDATE language
SET name = 'polISH'
WHERE   language_id = 10;

SELECT *
FROM language
LIMIT 500;

DELIMITER //

    CREATE TRIGGER set_rental_rate
        BEFORE UPDATE
        ON film
        FOR EACH ROW

    BEGIN
        IF NEW.rental_rate < 0.99 THEN
            SET NEW.rental_rate = 0.99;
        END IF ;

    END //

DELIMITER ;


DROP TRIGGER set_rental_rate;

UPDATE film
SET rental_rate = 0.25
WHERE film_id =1;

SELECT *
FROM film
LIMIT 500;