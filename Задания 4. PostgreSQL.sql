/*
 Задание 1. Напишите SQL-запрос, который выводит всю информацию
 о фильмах со специальным атрибутом (поле special_features) равным “Behind the Scenes”.
 */

SELECT *
FROM film
WHERE special_features @> ARRAY ['Behind the Scenes'];

/*
 Задание 2. Напишите ещё 2 варианта поиска фильмов с атрибутом “Behind the Scenes”,
 используя другие функции или операторы языка SQL для поиска значения в массиве.
 */

SELECT *
FROM film
WHERE 'Behind the Scenes' = ANY (special_features);

/*
 Задание 4. Для каждого покупателя посчитайте, сколько он брал в аренду фильмов
 со специальным атрибутом “Behind the Scenes”. Обязательное условие для выполнения задания:
 используйте запрос из задания 1, помещённый в подзапрос, который необходимо использовать для решения задания.
 */

SELECT customer_id,
       count(*) AS rentals
FROM rental
         JOIN inventory ON rental.inventory_id = inventory.inventory_id
         JOIN (SELECT *
               FROM film
               WHERE special_features @> ARRAY ['Behind the Scenes']) subquery ON inventory.film_id = subquery.film_id
GROUP BY customer_id;


/*
 Задание 6. С помощью explain analyze проведите анализ скорости выполнения запросов из предыдущих заданий и ответьте на вопросы:
с каким оператором или функцией языка SQL, используемыми при выполнении домашнего задания, поиск значения в массиве происходит быстрее;
какой вариант вычислений работает быстрее: с использованием CTE или с использованием подзапроса.
 */

-- шаблон
EXPLAIN ANALYSE
-- запрос
SELECT *
FROM film
WHERE special_features @> ARRAY ['Behind the Scenes'];

-- query 1
-- planning time: 0.149 ms, execution time: 0.760 ms, rows=538

-- query 2.1
-- planning time: 0.092 ms, execution time: 0.338 ms, rows=538

-- query 2.2
-- planning time: 0.183 ms, execution time: 1.239 ms, rows=538
/*
 Итог: С функцией ANY в массиве поиск значений происходит быстрее остальных
 */

-- query 3 (with)
-- planning time 14.789 ms, execution time: 10.869 ms

-- query 4 (subquery)
-- planning time 0.739 ms, execution time: 8.234 ms

/*
 Итог: с использованием подзапроса вычисления происходят быстрее,
 однако на мой взгляд первый вариант выглядит более структурированным
 */

