/*
 Задание 6. Выведите одним запросом только активных покупателей,
 имена которых KELLY или WILLIE. Все буквы в фамилии и имени из
 верхнего регистра должны быть переведены в нижний регистр.
 */

SELECT
    concat(lower(first_name), ' ', lower(last_name)) AS "Фамилия и имя"
FROM customer
WHERE activebool = true
          AND lower(first_name) LIKE 'kelly'
   OR  lower(first_name) LIKE 'willie';
