/*
 Задание 8. Доработайте запрос из предыдущего задания и выведите
 с помощью него фильмы, которые ни разу не брали в аренду.
 */

SELECT film.film_id, film.title
FROM film
WHERE film.film_id NOT IN (SELECT film.film_id
                           FROM film
                                    JOIN inventory ON film.film_id = inventory.film_id
                                    JOIN rental ON inventory.inventory_id = rental.inventory_id
                           GROUP BY film.film_id, film.title);
