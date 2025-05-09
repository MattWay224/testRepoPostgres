/*
 Задние 5. Выведите следующую информацию по покупателям:
    - Фамилия и имя (В одной клетке через пробел)
    - Электронная почта
    - Длину значения поля email
    - Дату последнего обновления записи о покупателе (без времени)

 Каждой колонке задайте наименование на русском языке
 */

SELECT
    CONCAT(first_name, ' ', last_name) AS "Фамилия и имя",
    email AS "Электронная почта",
    LENGTH(email) AS "Длина электронной почты",
    DATE(last_update) AS "Дата обновления"
FROM customer;
