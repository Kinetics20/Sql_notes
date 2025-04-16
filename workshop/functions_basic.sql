SET GLOBAL log_bin_trust_function_creators = 0;

DELIMITER //

CREATE FUNCTION get_language(lang_id INT)
    RETURNS VARCHAR(20)
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE lang_name VARCHAR(20);

    SELECT name
    INTO lang_name
    FROM language lan
    WHERE lan.language_id = lang_id
    LIMIT 1;

    RETURN lang_name;


END //



DELIMITER ;


SELECT get_language(10);

DROP FUNCTION get_language;


SHOW create table language;

SELECT title, language_id AS lang
FROM film
LIMIT 500;


SELECT title, get_language(language_id) AS lang
FROM film
LIMIT 500;

SELECT *
FROM film
WHERE film.language_id != 1
LIMIT 500;


DELIMITER $$

CREATE FUNCTION count_rentals(customer_id INT)
    RETURNS SMALLINT UNSIGNED
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE rentals_count SMALLINT UNSIGNED;

    SELECT COUNT(*)
    INTO rentals_count
    FROM rental ren
    WHERE ren.customer_id = customer_id;

    RETURN rentals_count;

END $$

DELIMITER ;

SELECT cust.first_name, cust.last_name, count_rentals(customer_id) AS TotalMoviesRented
FROM customer cust
ORDER BY TotalMoviesRented DESC
LIMIT 500;


