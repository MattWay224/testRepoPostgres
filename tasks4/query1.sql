/*
 Задание 1. Напишите SQL-запрос, который выводит всю информацию
 о фильмах со специальным атрибутом (поле special_features) равным “Behind the Scenes”.
 */

SELECT *
FROM film
WHERE special_features @> ARRAY ['Behind the Scenes'];
