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
