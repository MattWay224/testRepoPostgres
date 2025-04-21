/*
 Задание 5. Создайте материализованное представление с запросом из
 предыдущего задания и напишите запрос для обновления материализованного представления.
 */

CREATE MATERIALIZED VIEW mv_films_behind_the_scenes AS
SELECT customer_id,
       count(*) AS rentals
FROM rental
         JOIN inventory ON rental.inventory_id = inventory.inventory_id
         JOIN (SELECT *
               FROM film
               WHERE special_features @> ARRAY ['Behind the Scenes']) subquery ON inventory.film_id = subquery.film_id
GROUP BY customer_id;

REFRESH MATERIALIZED VIEW mv_films_behind_the_scenes;