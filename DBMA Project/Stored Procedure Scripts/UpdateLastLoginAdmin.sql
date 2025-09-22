DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateLastLoginAdmin`(IN admin_id INT)
BEGIN
    UPDATE Admin_Records
    SET last_login = NOW()
    WHERE admin_id = admin_id;
END$$
DELIMITER ;
