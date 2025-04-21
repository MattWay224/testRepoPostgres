/*
 Задание 9. Посчитайте количество продаж, выполненных каждым продавцом.
 Добавьте вычисляемую колонку «Премия». Если количество продаж превышает 7 300,
 то значение в колонке будет «Да», иначе должно быть значение «Нет».
 */

SELECT
    staff.staff_id,
    concat(staff.first_name, ' ', staff.last_name) AS "Фамилия и имя",
    count(payment.payment_id) as "Количество продаж",
    CASE
        WHEN count(payment.payment_id) > 7300 THEN 'Да'
        ELSE 'Нет'
    END AS Премия
FROM staff
JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id, concat(staff.first_name, ' ', staff.last_name);
