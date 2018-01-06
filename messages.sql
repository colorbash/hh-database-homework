\c testdb
DROP TABLE messages;
CREATE TABLE messages(
  ID_RESPONSE INT                 NOT NULL,
  MESSAGE     TEXT                NOT NULL,
  MSG_TIME    TIMESTAMP           NOT NULL
);

DO
$do$

BEGIN  
FOR i IN 1..2500000 LOOP

INSERT INTO messages (	ID_RESPONSE,
						MESSAGE,
						MSG_TIME
						)
			VALUES (((random() * 2500000 + 1):: INT),
					random_string(((random() * 40 + 4):: INT)),   
					'2001-09-28 01:00:00'
					);
END LOOP;
END;
$do$;
SELECT COUNT(*) FROM messages;