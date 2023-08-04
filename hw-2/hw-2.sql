/*
Задача 1
Написать крипт, добавляющий в БД vk, которую создали на занятии, 2-3 новые таблицы (с перечнем полей, указанием индексов и внешних ключей) (CREATE TABLE)
*/

DROP TABLE IF EXISTS `photo_albums`;

CREATE TABLE `photo_albums` (
	`id` SERIAL,
	`name` varchar(255),
    `user_id` BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
);


DROP TABLE IF EXISTS `pictures`;

CREATE TABLE `pictures` (
  `id` SERIAL,
  `album_id` BIGINT UNSIGNED,
  `media_id` BIGINT UNSIGNED NOT NULL,
  `title` VARCHAR(255),
  `uploaded_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (album_id) REFERENCES photo_albums(id),
  FOREIGN KEY (media_id) REFERENCES media(id)
);

DROP TABLE IF EXISTS cities;

CREATE TABLE `cities` (
  `id` SERIAL,
  `name` VARCHAR(255) NOT NULL,
  `country` VARCHAR(100),
  PRIMARY KEY (id)
);

ALTER TABLE profiles ADD COLUMN city_id BIGINT UNSIGNED NOT NULL ;

ALTER TABLE `profiles` ADD CONSTRAINT fk_profiles_city_id
    FOREIGN KEY (city_id) REFERENCES cities(id)

/*
Задача 2
Заполнить 2 таблицы БД vk данными (до 10 записей в каждой таблице)
*/

use vk;

INSERT INTO `photo_albums` (`name`, `description`, `user_id`) VALUES
	('Album 1', 'Description for Album 1', 1),
	('Album 2', 'Description for Album 2', 1),
	('Album 3', 'Description for Album 3', 2),
	('Album 4', 'Description for Album 4', 3),
	('Album 5', 'Description for Album 5', 4),
	('Album 6', 'Description for Album 6', 5),
	('Album 7', 'Description for Album 7', 6),
	('Album 8', 'Description for Album 8', 7),
	('Album 9', 'Description for Album 9', 8),
	('Album 10', 'Description for Album 10', 9);


INSERT INTO `cities` (`name`, `country`, `population`) VALUES
  ('Moscow', 'Russia', 12615882),
  ('Saint Petersburg', 'Russia', 5383890),
  ('Novosibirsk', 'Russia', 1612833),
  ('Yekaterinburg', 'Russia', 1493749),
  ('Kazan', 'Russia', 1257391),
  ('Nizhny Novgorod', 'Russia', 1256722),
  ('Chelyabinsk', 'Russia', 1202371),
  ('Samara', 'Russia', 1171060),
  ('Omsk', 'Russia', 1154509),
  ('Rostov-on-Don', 'Russia', 1112204);
; 

/*
Задача 3.
Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). При необходимости предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)
*/
ALTER TABLE vk.profiles 
ADD COLUMN is_active BIT DEFAULT 1;

UPDATE profiles
SET is_active = 0
WHERE (birthday + INTERVAL 18 YEAR) > NOW();

select *
from profiles
where is_active = 0
order by birthday;

select *
from profiles
where is_active = 1
order by birthday;