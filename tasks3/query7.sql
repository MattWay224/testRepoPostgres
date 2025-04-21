/*
 Задание 7. Для каждой страны определите и выведите одним SQL-запросом покупателей, которые попадают под условия:
покупатель, арендовавший наибольшее количество фильмов;
покупатель, арендовавший фильмов на самую большую сумму;
покупатель, который последним арендовал фильм.
 */
WITH customers_under_conditions AS (SELECT customer.customer_id,
                                           country.country,
                                           count(rental.rental_id) AS count_rent,
                                           sum(payment.amount)     AS total_payment,
                                           max(rental.return_date) AS last_rent
                                    FROM customer
                                             JOIN address ON customer.address_id = address.address_id
                                             JOIN city ON address.city_id = city.city_id
                                             JOIN country ON city.country_id = country.country_id
                                             JOIN rental ON customer.customer_id = rental.customer_id
                                             JOIN payment ON rental.rental_id = payment.rental_id
                                    GROUP BY customer.customer_id, country.country_id),
     ranks AS (SELECT *,
                      rank() OVER (PARTITION BY country ORDER BY count_rent DESC)    AS rank_count,
                      rank() OVER (PARTITION BY country ORDER BY total_payment DESC) AS rank_amount,
                      rank() OVER (PARTITION BY country ORDER BY last_rent DESC)     AS rank_last_rent
               FROM customers_under_conditions)
SELECT *
FROM ranks
WHERE rank_count = 1
   OR rank_amount = 1
   OR rank_last_rent = 1;
