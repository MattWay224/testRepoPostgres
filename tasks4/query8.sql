/*
 Задание 8. Для каждого магазина определите и выведите одним SQL-запросом следующие аналитические показатели:
    - день, в который арендовали больше всего фильмов (в формате год-месяц-день);
    - количество фильмов, взятых в аренду в этот день;
    - день, в который продали фильмов на наименьшую сумму (в формате год-месяц-день);
    - сумму продажи в этот день.
 */

WITH store_info AS (SELECT inventory.store_id,
                           date(rental.rental_date) AS day,
                           count(*)                 AS film_rentals
                    FROM rental
                             JOIN inventory ON rental.inventory_id = inventory.inventory_id
                    GROUP BY inventory.store_id, date(rental.rental_date)),
     max_rental AS (SELECT DISTINCT ON (store_id) store_id, day, film_rentals
                    FROM store_info
                    ORDER BY store_id, film_rentals DESC),
     payment_by_day AS (SELECT staff.store_id,
                               date(payment.payment_date) AS day,
                               sum(payment.amount)        AS total_payment
                        FROM payment
                                 JOIN staff ON staff.staff_id = payment.staff_id
                        GROUP BY staff.store_id, date(payment.payment_date)),
     min_sales AS (SELECT DISTINCT ON (store_id) store_id, day, total_payment
                   FROM payment_by_day
                   ORDER BY store_id, total_payment)

SELECT max_rental.store_id,

       max_rental.day AS busiest_rental_day,
       max_rental.film_rentals,

       min_sales.day  AS lowest_sales_day,
       min_sales.total_payment

FROM max_rental
         JOIN min_sales ON min_sales.store_id = max_rental.store_id;
