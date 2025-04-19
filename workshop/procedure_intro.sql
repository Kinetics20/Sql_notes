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


DROP PROCEDURE while_loop;


DELIMITER //

    CREATE PROCEDURE concat_name(first_name VARCHAR(100), last_name VARCHAR(100))
    BEGIN
        DECLARE full_name VARCHAR(201);
        SET full_name = CONCAT(first_name, ' ', last_name);
        SELECT full_name;
    END //

DELIMITER ;


DROP PROCEDURE concat_name;

CALL concat_name('Mike', 'T');


DELIMITER //

    CREATE PROCEDURE add_language(lang VARCHAR(100))
    BEGIN
        INSERT INTO language (name)
        VALUES (lang);

        SELECT LAST_INSERT_ID();

    END //

DELIMITER ;


DROP PROCEDURE add_language;


CALL add_language('Korean');
CALL add_language('Dutch');

SELECT *
FROM language
LIMIT 500;

DELIMITER //

    CREATE PROCEDURE add_language(IN lang VARCHAR(100), OUT lang_id INT)
    BEGIN
        INSERT INTO language (name)
        VALUES (lang);

        SET lang_id = LAST_INSERT_ID();

    END //

DELIMITER ;


CALL    add_language('Python', @lang_id);

SELECT CONCAT('Last language id is: ', @lang_id);

