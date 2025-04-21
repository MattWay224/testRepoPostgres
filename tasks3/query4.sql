/*
 Задание 4. С помощью оконной функции для каждого
 покупателя выведите данные о его последней оплате аренды.
 */

SELECT *
FROM (SELECT customer_id,
             amount,
             payment_date,
             row_number() OVER (
                 PARTITION BY customer_id
                 ORDER BY payment_date) AS row_number
      FROM payment) AS last_payment
WHERE row_number = 1;
