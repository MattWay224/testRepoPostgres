/*
 Задание 2. С помощью оконной функции выведитe
 для каждого покупателя стоимость платежа и стоимость платежа
 из предыдущей строки со значением по умолчанию 0.0 с сортировкой по дате.
 */

SELECT
    customer_id,
    amount,
    lag(amount, 1, 0.0) OVER (
        PARTITION BY customer_id
        ORDER BY payment_date
        ) AS pred_amount
FROM payment;
