\c testdb
DROP TABLE responses;
CREATE TABLE responses (
  ID_RESPONSE SERIAL,
  ID_VACANCY  INT                 NOT NULL,
  ID_SUMMARY  INT                 NOT NULL
);

DO
$do$

BEGIN  
FOR i IN 1..2500000 LOOP

INSERT INTO responses (	ID_VACANCY,
						ID_SUMMARY
						)
			VALUES (((random() * 2500000 + 1):: INT),
					((random() * 2500000 + 1):: INT)
					);
END LOOP;
END;
$do$;
SELECT COUNT(*) FROM responses;

