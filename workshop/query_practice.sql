SELECT
    c1.name AS category,

    (
        SELECT COUNT(DISTINCT fc2.film_id)
        FROM film_category AS fc2
        WHERE fc2.category_id = c1.category_id
    ) AS film_count,

    (
        SELECT AVG(f2.rental_rate)
        FROM film AS f2
        WHERE f2.film_id IN (
            SELECT DISTINCT fc3.film_id
            FROM film_category AS fc3
            INNER JOIN film AS f3 ON fc3.film_id = f3.film_id
            INNER JOIN film_actor AS fa3 ON f3.film_id = fa3.film_id
            WHERE fc3.category_id = c1.category_id
            GROUP BY fc3.film_id
            HAVING COUNT(DISTINCT fa3.actor_id) > 10
        )
    ) AS avg_rental_rate,

    (
        SELECT SUM(p2.amount)
        FROM payment AS p2
        INNER JOIN rental AS r2 ON p2.rental_id = r2.rental_id
        INNER JOIN inventory AS i2 ON r2.inventory_id = i2.inventory_id
        INNER JOIN film AS f2 ON i2.film_id = f2.film_id
        INNER JOIN film_category AS fc2 ON f2.film_id = fc2.film_id
        WHERE fc2.category_id = c1.category_id
    ) AS total_payment

FROM category AS c1

UNION ALL

SELECT *
FROM (
    SELECT
        c1.name AS category,

        (
            SELECT COUNT(DISTINCT fc2.film_id)
            FROM film_category AS fc2
            WHERE fc2.category_id = c1.category_id
        ) AS film_count,

        (
            SELECT AVG(f2.rental_rate)
            FROM film AS f2
            WHERE f2.film_id IN (
                SELECT DISTINCT fc3.film_id
                FROM film_category AS fc3
                INNER JOIN film AS f3 ON fc3.film_id = f3.film_id
                INNER JOIN film_actor AS fa3 ON f3.film_id = fa3.film_id
                WHERE fc3.category_id = c1.category_id
                GROUP BY fc3.film_id
                HAVING COUNT(DISTINCT fa3.actor_id) > 10
            )
        ) AS avg_rental_rate,

        (
            SELECT SUM(p2.amount)
            FROM payment AS p2
            INNER JOIN rental AS r2 ON p2.rental_id = r2.rental_id
            INNER JOIN inventory AS i2 ON r2.inventory_id = i2.inventory_id
            INNER JOIN film AS f2 ON i2.film_id = f2.film_id
            INNER JOIN film_category AS fc2 ON f2.film_id = fc2.film_id
            WHERE fc2.category_id = c1.category_id
        ) AS total_payment

    FROM category AS c1
) AS t1

ORDER BY total_payment DESC
LIMIT 10;