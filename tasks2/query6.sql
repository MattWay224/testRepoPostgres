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
