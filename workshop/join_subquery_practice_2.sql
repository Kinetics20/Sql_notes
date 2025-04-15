SELECT ct.customer_id,
       ct.first_name,
       ct.last_name,
       (SELECT COUNT(*) FROM rental ren WHERE ren.customer_id = ct.customer_id) AS rentals_count
FROM customer ct
WHERE ct.customer_id IN (SELECT ren.customer_id
                         FROM rental ren)
;