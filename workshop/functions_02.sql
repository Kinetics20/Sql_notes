SET GLOBAL log_bin_trust_function_creators = 1;

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


# get film title with category name (Dinosaur Academy (Drama))

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
    INNER JOIN film_category fc on fl.film_id = fc.film_id
    INNER JOIN category c on fc.category_id = c.category_id
    WHERE fl.film_id = film_id;


    RETURN film_name;

END //

DELIMITER ;


drop function get_film_title;

select get_film_title(2);

SELECT first_name, last_name, get_film_title(film_id)
FROM actor
JOIN sakila.film_actor fa on actor.actor_id = fa.actor_id
LIMIT 500;


# customer full name

DELIMITER //

CREATE FUNCTION get_customer_full_name(customer_id INT)
    RETURNS VARCHAR(255)
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE full_name VARCHAR(255);

    SELECT CONCAT(cust.first_name, ' ', cust.last_name)
    INTO full_name
    FROM customer cust
    WHERE cust.customer_id = customer_id
    LIMIT 500;

    RETURN full_name;

END //

DELIMITER ;

SELECT rental_date, get_customer_full_name(customer_id)
FROM rental
LIMIT 500;


# get_rental_days

SELECT DATEDIFF(return_date, rental_date), rental_id
FROM rental
WHERE rental_id = 3
LIMIT 500;


DELIMITER //

CREATE FUNCTION calc_rental_days(rental_id INT)
    RETURNS SMALLINT UNSIGNED
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE days SMALLINT UNSIGNED;

    SELECT DATEDIFF(return_date, rental_date)
    INTO days
    FROM rental ren
    WHERE ren.rental_id = rental_id
    LIMIT 1;

    RETURN days;

END //

DELIMITER ;

SELECT calc_rental_days(18);


# avg payment for customer

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
    LIMIT 500;

    RETURN avg_payment;

END //

DELIMITER ;


select first_name, last_name, avg_payment_for_customer(2)
FROM customer;

DELIMITER //

CREATE FUNCTION stddev_payment_for_customer(customer_id INT)
    RETURNS DECIMAL(6, 2)
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE stddev_payment DECIMAL(6, 2);

    SELECT IFNULL(STDDEV(pay.amount), 0)
    INTO stddev_payment
    FROM payment pay
    WHERE pay.customer_id = customer_id
    LIMIT 500;

    RETURN stddev_payment;

END //

DELIMITER ;


select first_name, last_name, avg_payment_for_customer(2), stddev_payment_for_customer(customer_id)
FROM customer;

# median

DELIMITER //

CREATE FUNCTION median_pyment_for_customer(customer_id INT)
    RETURNS DECIMAL(4, 2)
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


DROP FUNCTION median_pyment_for_customer;


SELECT median_pyment_for_customer(2);

SELECT COUNT(*)
FROM payment
WHERE   customer_id = 2
LIMIT 500;

SELECT amount
FROM payment
WHERE   customer_id = 2
ORDER BY amount
LIMIT 500;




SELECT AVG(mid_values.amount)
FROM (SELECT pay.amount
      FROM payment pay
      WHERE pay.customer_id = 1
      ORDER BY pay.amount
      LIMIT 2 OFFSET 16) AS mid_values