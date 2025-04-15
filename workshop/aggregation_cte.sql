SELECT ct.customer_id, ct.first_name, ct.last_name, COUNT(pt.amount)
FROM payment pt
INNER JOIN customer ct ON pt.customer_id = ct.customer_id
WHERE pt.amount > (SELECT AVG(pt2.amount)
                    FROM payment pt2
                    WHERE pt2.customer_id = pt.customer_id)
GROUP BY ct.customer_id
LIMIT 500;


# CTE = common table expression


WITH avg_apyment_per_customer AS (
    SELECT customer_id,
           AVG(amount) AS avg_amount
    FROM payment
    GROUP BY customer_id
)

SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(p.amount)
FROM payment p
INNER JOIN avg_apyment_per_customer appc ON appc.customer_id = p.customer_id
INNER JOIN customer c ON p.customer_id = c.customer_id
WHERE p.amount > appc.avg_amount
GROUP BY c.customer_id
LIMIT 500;