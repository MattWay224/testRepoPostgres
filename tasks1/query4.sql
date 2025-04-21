/*
 Выведите информацию о 10-ти последних платежах за прокат фильмов.
 */
SELECT *
FROM payment
ORDER BY payment_date DESC
LIMIT 10;
