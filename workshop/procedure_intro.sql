DELIMITER //

CREATE PROCEDURE GetLanguages()

BEGIN
   SELECT *
    FROM language;

END //

DELIMITER ;

CALL GetLanguages();


DELIMITER //

CREATE PROCEDURE while_loop()
BEGIN

    DECLARE i INT DEFAULT 1;

    WHILE i < 6
        DO
            SELECT POW(i, i);
            SET i = i + 1;

        END WHILE;

END //



DELIMITER ;

CALL    while_loop();