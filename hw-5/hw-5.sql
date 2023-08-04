/*
Создайте представление с произвольным SELECT-запросом из прошлых уроков [CREATE VIEW]
Количество друзей у каждого пользователя
*/

USE vk;

CREATE VIEW friend_counts AS
SELECT u.id AS user_id, u.firstname, u.lastname, COUNT(f.friend_id) AS friend_count
FROM users u
LEFT JOIN friends f ON u.id = f.user_id
GROUP BY u.id, u.firstname, u.lastname;

/*
Выведите данные, используя написанное представление [SELECT]
*/

SELECT * FROM friend_counts;

/*
Удалите представление [DROP VIEW]
*/

DROP VIEW friend_counts;

/*
Сколько новостей (записей в таблице media) у каждого пользователя? Вывести поля: news_count (количество новостей), user_id (номер пользователя), user_email (email пользователя). Попробовать решить с помощью CTE или с помощью обычного JOIN.
*/

SELECT 
	COUNT(*),
	user_id,
	email
FROM media as m
JOIN users as u on u.id = m.user_id 
GROUP BY user_id;