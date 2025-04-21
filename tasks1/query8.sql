/*
 Задание 8. Получите информацию о трёх фильмах с самым длинным описанием фильма.
 */
SELECT *
FROM film
ORDER BY length(description) DESC
LIMIT 3;
