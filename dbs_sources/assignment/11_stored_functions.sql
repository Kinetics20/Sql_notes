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

DELIMITER  ;


SELECT *
FROM language
LIMIT 500;

SHOW CREATE TABLE language;


SELECT get_language(6);


SELECT title, get_language(language_id) AS lang
FROM film
LIMIT 500;

SELECT *
FROM film
WHERE language_id != 1
LIMIT 500;

DROP FUNCTION get_language;


# ile wypozyczen mial klient


DELIMITER $$

CREATE FUNCTION count_rentals(customer_id INT)
    RETURNS SMALLINT UNSIGNED
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE rental_count SMALLINT UNSIGNED;

    SELECT COUNT(*)
    INTO rental_count
    FROM rental ren
    WHERE  ren.customer_id = customer_id;

    RETURN rental_count;


END $$


DELIMITER ;

SELECT cust.first_name, cust.last_name,count_rentals(cust.customer_id) AS TotalMovieREnted
FROM customer cust
ORDER BY TotalMovieREnted DESC
LIMIT 500;


# get film title with category name (Dinosaur Academy (Dama))

DELIMITER //

CREATE FUNCTION get_film_title(film_id INT)
    RETURNS VARCHAR(255)
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE film_name VARCHAR(255);

    SELECT CONCAT(fl.title, '(', c.name, ')')
    INTO film_name
    FROM film fl
    INNER JOIN sakila.film_category fc on fl.film_id = fc.film_id
    INNER JOIN sakila.category c on fc.category_id = c.category_id
    WHERE fl.film_id = film_id
    LIMIT 500;

    RETURN film_name;

END //

DELIMITER ;


SELECT get_film_title(2);

SELECT first_name, last_name, get_film_title(film_id)
FROM actor
INNER JOIN sakila.film_actor fa on actor.actor_id = fa.actor_id
LIMIT 500;


# customer full name

DELIMITER //

CREATE FUNCTION get_customer_full_name(customer_id INT)
    RETURNS VARCHAR(255)
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE full_name VARCHAR(255);

    SELECT CONCAT(cust.first_name, ' ', cust.last_name )
    INTO full_name
    FROM customer cust
    WHERE cust.customer_id = customer_id
    LIMIT 500;

    RETURN full_name;

END //

DELIMITER ;
DROP FUNCTION get_customer_full_name;


SELECT rental_date, get_customer_full_name(customer_id)
FROM rental
LIMIT 500;


SELECT DATEDIFF(rental_date, return_date), rental_id
FROM rental
WHERE rental_id = 1
LIMIT 500;

DELIMITER //

CREATE FUNCTION calc_rental_days(rental_id INT)
    RETURNS SMALLINT UNSIGNED
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE days SMALLINT UNSIGNED;

    SELECT DATEDIFF(rental_date, return_date)
    INTO days
    FROM rental ren
    WHERE ren.rental_id = rental_id
    LIMIT 1;

    RETURN days;

END //

DELIMITER ;

DROP FUNCTION calc_rental_days;


SELECT  calc_rental_days(4);


SELECT *
FROM payment
LIMIT 500;


DELIMITER //

CREATE FUNCTION avg_payment_for_customer(customer_id INT)
    RETURNS DECIMAL(6, 2)
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE avg_payment DECIMAL(6, 2);

    SELECT IFNULL(AVG(pay.amount), 0)
    INTO avg_payment
    FROM payment pay
    WHERE pay.customer_id = customer_id
    LIMIT 1;

    RETURN avg_payment;

END //

DELIMITER ;

SELECT first_name, last_name,avg_payment_for_customer(1)
FROM customer;



DELIMITER //



CREATE FUNCTION stddev_payment_for_customer(customer_id INT)
    RETURNS DECIMAL(6, 2)
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE stddev_payment DECIMAL(6, 2);

    SELECT IFNULL(STD(pay.amount), 0)
    INTO stddev_payment
    FROM payment pay
    WHERE pay.customer_id = customer_id
    LIMIT 1;

    RETURN stddev_payment;

END //

DELIMITER ;

SELECT first_name, last_name, avg_payment_for_customer(customer_id), stddev_payment_for_customer(customer_id)
FROM customer;

# median

DELIMITER //

CREATE FUNCTION median_payment_for_customer(customer_id INT)
    RETURNS DECIMAL(6, 2)
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE count_payments SMALLINT UNSIGNED;
    DECLARE median_value DECIMAL(6, 2);
    DECLARE offset_value SMALLINT UNSIGNED;

    SELECT COUNT(*)
    INTO count_payments
    FROM payment pay
    WHERE pay.customer_id = customer_id
    LIMIT 1;

    IF count_payments = 0 THEN
        RETURN NULL;
    END IF;

    IF MOD(count_payments, 2) = 1 THEN
        SET offset_value = FLOOR(count_payments / 2);

        SELECT pay.amount
        INTO median_value
        FROM payment pay
        WHERE pay.customer_id = customer_id
        ORDER BY pay.amount
        LIMIT 1 OFFSET offset_value;
    ELSE
        SET offset_value = FLOOR(count_payments / 2) - 1;

        SELECT AVG(mid_values.amount)
        INTO median_value
        FROM (SELECT pay.amount
              FROM payment pay
              WHERE pay.customer_id = customer_id
              ORDER BY pay.amount
              LIMIT 2 OFFSET offset_value) AS mid_values;
    END IF;

    RETURN median_value;

END //

DELIMITER ;

DROP FUNCTION median_payment_for_customer;


SELECT median_payment_for_customer(3);

