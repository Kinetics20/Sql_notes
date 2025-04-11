CREATE TABLE ActorGroup (
    actor_id SMALLINT unsigned NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(25) NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (actor_id)
);

SELECT *
FROM ActorGroup
LIMIT 500;

INSERT INTO ActorGroup (actor_id, first_name, last_name, last_update)
SELECT actor_id, first_name, last_name, last_update
FROM actor;

DELETE
FROM ActorGroup
WHERE actor_id = 1 ;

DELETE
FROM ActorGroup
WHERE 1=1;

DELETE
FROM ActorGroup
WHERE 42;

TRUNCATE TABLE ActorGroup;




DROP TABLE ActorGroup;
