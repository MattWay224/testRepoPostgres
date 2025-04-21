/*
 Задание 3. Выведите топ-5 покупателей, которые взяли в аренду за всё время наибольшее количество фильмов.
 */

SELECT
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    COUNT(rental.rental_id) AS rental_count

FROM customer
JOIN rental ON rental.customer_id = customer.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY rental_count DESC
LIMIT 5;
