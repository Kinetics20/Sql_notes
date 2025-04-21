SELECT *
FROM payment
LIMIT 500;

SELECT SUM(amount)
FROM payment
LIMIT 500;

SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY customer_id DESC
LIMIT 500;

SELECT customer_id, SUM(amount) AS Amount
FROM payment
GROUP BY customer_id
ORDER BY Amount DESC
LIMIT 500;


SELECT staff_id, SUM(amount) AS Amount
FROM payment
GROUP BY staff_id
ORDER BY Amount DESC
LIMIT 500;


# amount incoming assets by customer and months

SELECT customer_id,
       DATE_FORMAT(payment_date, '%Y-%m') AS PaymentMonth,
       SUM(amount) AS Amount
FROM payment
GROUP BY customer_id, PaymentMonth
ORDER BY customer_id, Amount DESC
LIMIT 500;

SELECT staff_id,
       DATE_FORMAT(payment_date, '%Y-%m') AS PaymentMonth,
       SUM(amount) AS Amount
FROM payment
GROUP BY staff_id, PaymentMonth
ORDER BY staff_id, Amount DESC
LIMIT 500;


CREATE OR REPLACE VIEW payment_report
AS
SELECT cust.first_name,
       cust.last_name,
       cust.email,
       SUM(p.amount) AS CustomerTotal,
       COUNT(p.amount) AS CustomerPaymentCount,
       AVG(p.amount) AS CustomerAvgPayment,
       MAX(p.payment_date) AS CustomerLastPayment
FROM customer cust
JOIN payment p ON cust.customer_id = p.customer_id
GROUP BY cust.customer_id;

SELECT SUM(CustomerTotal)
FROM payment_report
LIMIT 500;

SELECT SUM(CustomerTotal) FROM payment_report;
SELECT SUM(amount) FROM payment;


SELECT (SELECT SUM(CustomerTotal) FROM payment_report) = (SELECT SUM(amount) FROM payment);



CREATE TEMPORARY TABLE tmp_film_actors
AS
SELECT fl.film_id,
       fl.title,
       COUNT(fa.actor_id) AS ActorsCount

FROM film fl
JOIN film_actor fa ON fl.film_id = fa.film_id
GROUP BY fl.film_id
ORDER BY ActorsCount DESC
LIMIT 500;

SELECT *
FROM tmp_film_actors
LIMIT 500;



SELECT COUNT(actor_id) , film_id
FROM film_actor
GROUP BY film_id;


WITH cte AS (SELECT fa.film_id, COUNT(fa.actor_id) AS ActorsCount
                 FROM film_actor fa
                 GROUP BY 1)
SELECT fl.film_id,
       fl.title,
       ActorsCount
FROM film fl
JOIN cte c ON c.film_id = fl.film_id
LIMIT 500;


CREATE TEMPORARY TABLE tmp_film_rentals
AS
SELECT fl.film_id,
       fl.title,
       COUNT(ren.rental_id) AS RentalCount
FROM film fl
LEFT JOIN inventory inv ON fl.film_id = inv.film_id
LEFT JOIN rental ren ON inv.inventory_id = ren.inventory_id
GROUP BY fl.film_id
ORDER BY RentalCount;


SELECT *
FROM tmp_film_rentals
LIMIT 500;

# Napisz zapytanie, które zwróci kwotę wpłat z filmu w następującym formacie:
#
# id filmu,
# kwota wpłat z filmu.
# Wyniki zapisz do tabeli tymczasowej, np. tmp_film_payments.

CREATE TEMPORARY TABLE tmp_film_payments
AS
SELECT inv.film_id, inv.inventory_id, SUM(p.amount) AS Amount
FROM payment as p
         INNER JOIN rental as ren USING (rental_id)
INNER JOIN inventory as inv USING (inventory_id)
GROUP BY inv.inventory_id;

DROP TEMPORARY TABLE tmp_film_payments;

SELECT *
FROM tmp_film_payments;



# Przygotuj raport, który wyświetli top 10 najchętniej wypożyczanych filmów.
# Przyjmij następujące założenia biznesowe do przygotowania raportu:
#
# nazwa filmu,
# liczba aktorów, którzy w nim grali,
# kwota przychodu filmu,
# liczba wypożyczeń filmu.


SELECT tfa.title,
       tfa.ActorsCount,
       tfp.Amount,
       tfr.RentalCount
FROM tmp_film_rentals tfr
JOIN tmp_film_actors tfa on tfr.film_id = tfa.film_id
JOIN tmp_film_payments tfp on tfa.film_id = tfp.film_id
ORDER BY tfp.Amount
LIMIT 10;


# Napisz zapytanie, które wygeneruje raport o:
#
# sumie sprzedaży danego sklepu oraz jego pracownikach,
# całkowitej sumie sprzedaży danego sklepu (bez podziału na pracowników),
# całkowitej sumie sprzedaży.


SELECT s.store_id,
       pt.staff_id,
        SUM(pt.amount) AS Sales
FROM payment pt
JOIN staff s ON pt.staff_id = s.staff_id
GROUP BY s.store_id, pt.staff_id
WITH ROLLUP
ORDER BY 1, 2;

SELECT *
FROM store
LIMIT 500;


# Na podstawie tabeli payment napisz zapytanie, które:
#
# wyznaczy sumę wpłat w podziale na klienta oraz pracownika,
# wyznaczy sumę wpłat per klient,
# wyznaczy sumę wpłat.

SELECT pt.customer_id,
       pt.staff_id,
        SUM(pt.amount) AS Amount
FROM payment pt
GROUP BY pt.customer_id, pt.staff_id
WITH ROLLUP
HAVING pt.customer_id < 4
ORDER BY 1, 2;

SELECT pt.customer_id,
       pt.staff_id,
        SUM(pt.amount) AS Amount
FROM payment pt
WHERE pt.customer_id <4
GROUP BY pt.customer_id, pt.staff_id
WITH ROLLUP
ORDER BY 1, 2;

SELECT pt.customer_id,
       pt.staff_id,
        SUM(pt.amount) AS Total
FROM payment pt
WHERE pt.customer_id <4
GROUP BY pt.customer_id, pt.staff_id
WITH ROLLUP
HAVING Total > 70
ORDER BY 1, 2;





