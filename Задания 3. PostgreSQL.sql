/*
 Задание 1. Сделайте запрос к таблице payment и с помощью оконных функций добавьте вычисляемые
 колонки согласно условиям:
    - Пронумеруйте все платежи от 1 до N по дате
    - Пронумеруйте платежи для каждого покупателя, сортировка платежей должна быть по дате
    - Посчитайте нарастающим итогом сумму всех платежей для каждого покупателя, сортировка должна быть сперва по дате платежа, а затем по сумме платежа от наименьшей к большей
    - Пронумеруйте платежи для каждого покупателя по стоимости платежа от наибольших к меньшим так, чтобы платежи с одинаковым значением имели одинаковое значение номера.
Можно составить на каждый пункт отдельный SQL-запрос, а можно объединить все колонки в одном запросе.

 */

SELECT
    payment_id,
    customer_id,
    amount,
    payment_date,
    row_number() OVER (ORDER BY payment_date) AS first,
    row_number() OVER (PARTITION BY customer_id ORDER BY payment_date) AS second,
    sum(amount) OVER (
        PARTITION BY customer_id
        ORDER BY payment_date, amount
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS third,
    rank() OVER (PARTITION BY customer_id ORDER BY amount DESC) AS fourth
FROM payment;
