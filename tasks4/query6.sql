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
