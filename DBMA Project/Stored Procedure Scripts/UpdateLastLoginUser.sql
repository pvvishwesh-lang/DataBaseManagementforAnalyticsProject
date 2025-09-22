DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateLastLoginUser`(IN user_id INT)
BEGIN
    UPDATE Users
    SET last_login = NOW()
    WHERE user_id = user_id;
END$$
DELIMITER ;
