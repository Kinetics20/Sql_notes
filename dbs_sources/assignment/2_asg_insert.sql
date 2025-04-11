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

INSERT INTO ActorGroup (first_name, last_name, last_update)
VALUES ('John', 'Smith', '2025-11-04');

INSERT INTO ActorGroup (first_name, last_name, last_update)
VALUES ('Anthony', 'Joshua', DEFAULT);

INSERT INTO ActorGroup
VALUES (DEFAULT,'Sarah', 'James', DEFAULT);

INSERT INTO ActorGroup (first_name)
VALUES ('Kris');

INSERT INTO ActorGroup (first_name, last_name, last_update)
VALUES ('Tedy', NULL, DEFAULT);

INSERT INTO ActorGroup (first_name, last_name)
VALUES ('Mike', 'Kazinski'),
       ('Jozef', 'Parker'),
       ('Affe', 'Ajagba');

INSERT INTO ActorGroup(first_name, last_name)
SELECT first_name, last_name
FROM actor
WHERE first_name = 'KENNETH';

DROP TABLE ActorGroup;
