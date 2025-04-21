/*
 Задание 2. Напишите ещё 2 варианта поиска фильмов с атрибутом “Behind the Scenes”,
 используя другие функции или операторы языка SQL для поиска значения в массиве.
 */

SELECT *
FROM film
WHERE 'Behind the Scenes' = ANY (special_features);

SELECT DISTINCT film.*
FROM film,
     unnest(film.special_features) AS feature
WHERE feature = 'Behind the Scenes';