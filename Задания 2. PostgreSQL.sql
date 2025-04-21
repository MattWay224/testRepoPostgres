/*
 Задание 1. Выведите для каждого покупателя его адрес, город и страну проживания.
 */

SELECT
    customer.customer_id,
    address.address,
    city.city,
    country.country
FROM customer
         JOIN address ON customer.address_id = address.address_id
         JOIN city ON address.city_id = city.city_id
         JOIN country ON city.country_id = country.country_id;

/*
 Задание 2. С помощью SQL-запроса посчитайте для каждого магазина количество его покупателей.
    - Доработайте запрос и выведите только те магазины, у которых количество покупателей больше 300.
        Для решения используйте фильтрацию по сгруппированным строкам с функцией агрегации.
    - Доработайте запрос, добавив в него информацию о городе магазина, фамилии и имени продавца,
        который работает в нём.
 */

SELECT
    store.store_id "Индекс магазина",
    count(*) AS "Количество покупателей",
    city.city AS "Город магазина",
    concat(staff.first_name, ' ', staff.last_name) AS "ФИО"

FROM store
         JOIN address ON store.address_id = address.address_id
         JOIN city ON address.city_id = city.city_id
         JOIN staff ON store.manager_staff_id = staff.staff_id
         JOIN customer ON customer.store_id = store.store_id
GROUP BY store.store_id, city.city, staff.first_name, staff.last_name
HAVING COUNT(*) > 300;

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

/*
 Задание 5. Используя данные из таблицы городов, составьте одним запросом всевозможные пары городов так,
 чтобы в результате не было пар с одинаковыми названиями городов.
 Для решения необходимо использовать декартово произведение.
 */

SELECT
    c1.city AS first_city,
    c2.city AS second_city
FROM city c1
         CROSS JOIN city c2
WHERE c1.city <> c2.city;

/*
 Задание 6. Используя данные из таблицы rental о дате выдачи фильма в аренду
 (поле rental_date) и дате возврата (поле return_date), вычислите для каждого покупателя среднее количество дней,
 за которые он возвращает фильмы.
 */

SELECT
    rental_id,
    customer_id,
    avg(extract(DAY FROM return_date - rental_date)) AS days_amount
FROM rental
WHERE return_date IS NOT NULL
GROUP BY rental_id, customer_id;

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

/*
 Задание 9. Посчитайте количество продаж, выполненных каждым продавцом.
 Добавьте вычисляемую колонку «Премия». Если количество продаж превышает 7 300,
 то значение в колонке будет «Да», иначе должно быть значение «Нет».
 */

SELECT
    staff.staff_id,
    concat(staff.first_name, ' ', staff.last_name) AS "Фамилия и имя",
    count(payment.payment_id) as "Количество продаж",
    CASE
        WHEN count(payment.payment_id) > 7300 THEN 'Да'
        ELSE 'Нет'
        END AS Премия
FROM staff
         JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id, concat(staff.first_name, ' ', staff.last_name);
