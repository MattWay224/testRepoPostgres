/*
 Задание 1. Сделайте запрос к таблице payment и с помощью оконных функций добавьте вычисляемые
 колонки согласно условиям:
    - Пронумеруйте все платежи от 1 до N по дате
    - Пронумеруйте платежи для каждого покупателя, сортировка платежей должна быть по дате
    - Посчитайте нарастающим итогом сумму всех платежей для каждого покупателя, сортировка должна быть сперва по дате платежа, а затем по сумме платежа от наименьшей к большей
    - Пронумеруйте платежи для каждого покупателя по стоимости платежа от наибольших к меньшим так, чтобы платежи с одинаковым значением имели одинаковое значение номера.
Можно составить на каждый пункт отдельный SQL-запрос, а можно объединить все колонки в одном запросе.
 */

SELECT payment_id,
       customer_id,
       amount,
       payment_date,
       row_number() OVER (ORDER BY payment_date)                          AS first,
       row_number() OVER (PARTITION BY customer_id ORDER BY payment_date) AS second,
       sum(amount) OVER (
           PARTITION BY customer_id
           ORDER BY payment_date, amount
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
           )                                                              AS third,
       rank() OVER (PARTITION BY customer_id ORDER BY amount DESC)        AS fourth
FROM payment;

/*
 Задание 2. С помощью оконной функции выведитe
 для каждого покупателя стоимость платежа и стоимость платежа
 из предыдущей строки со значением по умолчанию 0.0 с сортировкой по дате.
 */

SELECT customer_id,
       amount,
       lag(amount, 1, 0.0) OVER (
           PARTITION BY customer_id
           ORDER BY payment_date
           ) AS pred_amount
FROM payment;

/*
 Задание 3. С помощью оконной функции определите,
 на сколько каждый следующий платеж покупателя больше или меньше текущего.
 */

SELECT customer_id,
       amount,
       lead(amount) OVER (
           PARTITION BY customer_id
           ORDER BY payment_date) - amount
           AS difference
/* если нет знака - следующий платеж больше
                    или равен, если присутствует -, то следующий платеж меньше текущего */
FROM payment;

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

/*
 Задание 7. Для каждой страны определите и выведите одним SQL-запросом покупателей, которые попадают под условия:
покупатель, арендовавший наибольшее количество фильмов;
покупатель, арендовавший фильмов на самую большую сумму;
покупатель, который последним арендовал фильм.
 */
WITH customers_under_conditions AS (SELECT customer.customer_id,
                                           country.country,
                                           count(rental.rental_id) AS count_rent,
                                           sum(payment.amount)     AS total_payment,
                                           max(rental.return_date) AS last_rent
                                    FROM customer
                                             JOIN address ON customer.address_id = address.address_id
                                             JOIN city ON address.city_id = city.city_id
                                             JOIN country ON city.country_id = country.country_id
                                             JOIN rental ON customer.customer_id = rental.customer_id
                                             JOIN payment ON rental.rental_id = payment.rental_id
                                    GROUP BY customer.customer_id, country.country_id),
     ranks AS (SELECT *,
                      rank() OVER (PARTITION BY country ORDER BY count_rent DESC)    AS rank_count,
                      rank() OVER (PARTITION BY country ORDER BY total_payment DESC) AS rank_amount,
                      rank() OVER (PARTITION BY country ORDER BY last_rent DESC)     AS rank_last_rent
               FROM customers_under_conditions)
SELECT *
FROM ranks
WHERE rank_count = 1
   OR rank_amount = 1
   OR rank_last_rent = 1;
