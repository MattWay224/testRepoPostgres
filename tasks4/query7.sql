/*
 Задание 7. Используя оконную функцию, выведите для каждого сотрудника сведения о первой его продаже.
 */

WITH sale_info AS (
    SELECT *,
           row_number() over (PARTITION BY staff_id ORDER BY payment_date) AS row_number
    FROM payment
)

SELECT *
FROM sale_info
WHERE row_number = 1;
