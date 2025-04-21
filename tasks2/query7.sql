/*
 Задание 7. Посчитайте для каждого фильма, сколько раз его брали в аренду,
 а также общую стоимость аренды фильма за всё время.
 */

SELECT
    film.film_id,
    film.title,
    count(rental.rental_id) AS count_rent,
    sum(payment.amount) AS total_amount
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY film.film_id, film.title
