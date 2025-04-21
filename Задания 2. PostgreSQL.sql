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
    COUNT(*) AS "Количество покупателей",
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
