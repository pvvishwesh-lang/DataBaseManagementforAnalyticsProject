DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `verify_password`(input_password VARCHAR(255), stored_hash VARCHAR(255)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
    RETURN SHA2(input_password, 256) = stored_hash;
END$$
DELIMITER ;
