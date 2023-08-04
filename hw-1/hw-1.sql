/* 
Задача 1
Создание таблицы с мобильными телефонами:
*/

CREATE TABLE mobile_phones (
  id INT PRIMARY KEY,
  product_name VARCHAR(100),
  manufacturer VARCHAR(100),
  product_count INT,
  price DECIMAL(10, 2)
);

/* 
Задача 2
Заполнение таблицы данными:
*/

INSERT INTO mobile_phones (id, product_name, manufacturer, product_count, price)
VALUES
  (1, 'Phone A', 'Samsung', 5, 399.99),
  (2, 'Phone B', 'Apple', 3, 799.00),
  (3, 'Phone C', 'Xiaomi', 8, 299.50),
  (4, 'Phone D', 'Samsung', 2, 449.00),
  (5, 'Phone E', 'OnePlus', 4, 699.99),
  (6, 'Phone F', 'Samsung', 1, 499.00);

/* 
Задача 3
Вывод названия, производителя и цены для товаров, количество которых превышает 2:
*/

SELECT product_name, manufacturer, price
FROM mobile_phones
WHERE product_count > 2;

/* 
Задача 4
Вывод всего ассортимента товаров марки “Samsung”:
*/

SELECT *
FROM mobile_phones
WHERE manufacturer = 'Samsung';



