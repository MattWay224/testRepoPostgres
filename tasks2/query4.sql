/*
 Задание 4. Посчитайте для каждого покупателя 4 аналитических показателя:
    - количество взятых в аренду фильмов;
    - общую стоимость платежей за аренду всех фильмов (значение округлите до целого числа);
    - минимальное значение платежа за аренду фильма;
    - максимальное значение платежа за аренду фильма.
 */

SELECT
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    count(rental.rental_id) AS rental_count,
    round(sum(payment.amount)) AS total_paid,
    min(payment.amount) AS min_payment,
    max(payment.amount) AS max_payment
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN payment ON payment.rental_id = rental.rental_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name;
