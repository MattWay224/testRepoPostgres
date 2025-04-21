/*
 Задание 5. С помощью оконной функции выведите для каждого сотрудника сумму продаж
 за август 2005 года с нарастающим итогом по каждому сотруднику и
 по каждой дате продажи (без учёта времени) с сортировкой по дате.
 */

SELECT staff_id,
       sum(payment_id) OVER (
           PARTITION BY staff_id
           ORDER BY DATE(payment_date)
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
           ) AS total_count
FROM payment
WHERE payment_date BETWEEN '2005-08-01' AND '2005-08-31';
