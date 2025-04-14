SELECT *
FROM film
LIMIT 500;

SELECT *
FROM film_category
LIMIT 500;

SELECT *
FROM category
LIMIT 500;


SELECT ct.name, fl.title, fl.release_year
FROM film fl
    INNER JOIN film_category fc ON fl.film_id = fc.film_id
    INNER JOIN category ct ON fc.category_id = ct.category_id
WHERE ct.name = 'Action';


SELECT fl.film_id, fl.title, fl.release_year
FROM film fl
WHERE fl.film_id IN (SELECT fc.film_id
                    FROM film_category fc
                    WHERE category_id IN (SELECT ct.category_id
                                        FROM category ct
                                        WHERE ct.name = 'drama'

                    )
                    );

SELECT ct.customer_id, ct.first_name, ct.last_name, COUNT(*) rental_drama_count
FROM customer ct
INNER JOIN rental ren ON ct.customer_id = ren.customer_id
INNER JOIN inventory inv ON ren.inventory_id = inv.inventory_id
INNER JOIN film_category fc ON inv.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'drama'
GROUP BY ct.customer_id
ORDER BY rental_drama_count DESC
LIMIT 500;