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

UPDATE ActorGroup
SET first_name = 'Jaro'
WHERE actor_id IN (1, 5, 6, 7);

UPDATE ActorGroup
SET first_name = 'SQL_Ninja'
WHERE actor_id BETWEEN 1 AND 9;


UPDATE ActorGroup
SET first_name = 'SQL_Ninja', last_name ='DOOM'
WHERE actor_id BETWEEN 1 AND 9;

SELECT actor_id
FROM film_actor
WHERE film_id = 1;

UPDATE ActorGroup
SET first_name = 'Andrew'
WHERE actor_id IN (SELECT actor_id
FROM film_actor
WHERE film_id = 1);





DROP TABLE ActorGroup;
