/*
 Задание 3. С помощью оконной функции определите,
 на сколько каждый следующий платеж покупателя больше или меньше текущего.
 */

SELECT
    customer_id,
    amount,
    lead(amount) OVER (
        PARTITION BY customer_id
        ORDER BY payment_date) - amount
    AS difference   /* если нет знака - следующий платеж больше
                       или равен, если присутствует -, то следующий платеж меньше текущего */
FROM payment
