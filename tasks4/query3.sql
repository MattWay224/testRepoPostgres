/*
 Задание 3. Для каждого покупателя посчитайте,
 сколько он брал в аренду фильмов со специальным атрибутом “Behind the Scenes”.
Обязательное условие для выполнения задания: используйте запрос из задания 1, помещённый в CTE.
 */

WITH films_behind_the_scenes AS (SELECT *
                                 FROM film
                                 WHERE special_features @> ARRAY ['Behind the Scenes'])
SELECT customer_id,
       count(*) AS rentals
FROM rental
         JOIN inventory i ON rental.inventory_id = i.inventory_id
         JOIN films_behind_the_scenes f ON i.film_id = f.film_id
GROUP BY customer_id;
