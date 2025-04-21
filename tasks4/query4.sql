/*
 Задание 4. Для каждого покупателя посчитайте, сколько он брал в аренду фильмов
 со специальным атрибутом “Behind the Scenes”. Обязательное условие для выполнения задания:
 используйте запрос из задания 1, помещённый в подзапрос, который необходимо использовать для решения задания.
 */

SELECT customer_id,
       count(*) AS rentals
FROM rental
         JOIN inventory ON rental.inventory_id = inventory.inventory_id
         JOIN (SELECT *
               FROM film
               WHERE special_features @> ARRAY ['Behind the Scenes']) subquery ON inventory.film_id = subquery.film_id
GROUP BY customer_id;
