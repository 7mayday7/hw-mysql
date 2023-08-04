/*
Написать функцию, которая удаляет всю информацию об указанном пользователе из БД vk. Пользователь задается по id. Удалить нужно все сообщения, лайки, медиа записи, профиль и запись из таблицы users. Функция должна возвращать номер пользователя.
*/

DELIMITER //

CREATE FUNCTION delete_user_info(user_id INT) RETURNS INT
BEGIN
  -- Удаляем сообщения
  DELETE FROM messages WHERE from_user_id = user_id OR to_user_id = user_id;

  -- Удаляем лайки
  DELETE FROM likes WHERE user_id = user_id;

  -- Удаляем медиа записи
  DELETE FROM media WHERE user_id = user_id;

  -- Удаляем записи из таблицы photo_albums
  DELETE FROM photo_albums WHERE user_id = user_id;

  -- Удаляем запись из таблицы users
  DELETE FROM users WHERE id = user_id;

  RETURN user_id;
END //

DELIMITER ;


/*
Предыдущую задачу решить с помощью процедуры и обернуть используемые команды в транзакцию внутри процедуры.
*/

DELIMITER //

CREATE PROCEDURE delete_user_with_transaction(IN user_id INT)
BEGIN
  START TRANSACTION;
    -- Вызываем функцию для удаления информации о пользователе
    CALL delete_user_info(user_id);
  COMMIT;
END //

DELIMITER ;


/*
Написать триггер, который проверяет новое появляющееся сообщество. Длина названия сообщества (поле name) должна быть не менее 5 символов. Если требование не выполнено, то выбрасывать исключение с пояснением.
*/

DELIMITER //

CREATE TRIGGER check_community_name_length
BEFORE INSERT ON communities
FOR EACH ROW
BEGIN
  IF LENGTH(NEW.name) < 5 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Длина названия сообщества должна быть не менее 5 символов';
  END IF;
END //

DELIMITER ;