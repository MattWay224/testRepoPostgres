/*
 Задание 6. 20 августа 2005 года в магазинах проходила акция:
 покупатель каждого сотого платежа получал дополнительную скидку на следующую аренду.
 С помощью оконной функции выведите всех покупателей, которые в день проведения акции получили скидку.
 */
WITH subquery AS (SELECT customer_id,
             row_number() over (ORDER BY payment_id) AS row_number
      FROM payment
      WHERE date(payment_date) = '2005-08-20')

SELECT *
FROM subquery
WHERE row_number % 100 = 0;
