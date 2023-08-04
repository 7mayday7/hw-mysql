/*
Задача 1
Подсчитать количество групп, в которые вступил каждый пользователь
*/

SELECT 
CONCAT(firstname, ' ', lastname) 
AS owner,
count(*)
from users u
join users_communities uc on u.id = uc.user_id
group by u.id
order by count(*) desc


/* 
Задача 2
Подсчитать количество пользователей в каждом сообществе
*/
select
count(*), communities.name
from users_communities 
join communities 
on users_communities.community_id = communities.id
group by communities.id


/* Задача 3.
Пусть задан некоторый пользователь
Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем
*/

USE vk;

SELECT
  u.from_user_id,
  CONCAT(u.firstname, ' ', u.lastname) AS name,
  COUNT(*) AS 'messages count'
FROM messages u
JOIN (
  SELECT from_user_id, COUNT(*) AS message_count
  FROM messages
  WHERE to_user_id = 1
  GROUP BY from_user_id
) m ON u.from_user_id = m.from_user_id
WHERE to_user_id = 1
GROUP BY u.from_user_id
HAVING COUNT(*) = MAX(m.message_count);


-- ---------------------------------------------------------------
/*Задача 4
 Общее количество лайков, которые получили пользователи младше 18 лет
 */
 
select count(*)
from likes l
join media m on l.media_id = m.id
join profiles p on p.user_id = m.user_id
where  YEAR(CURDATE()) - YEAR(birthday) < 18;
