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
