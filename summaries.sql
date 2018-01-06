\c testdb
DROP TABLE summaries;
CREATE TABLE summaries (--Резюме
  ID         SERIAL, 						--ID
  USR_ID	 INT				  NOT NULL, --ID юзера
  USR_EMAIL  TEXT                 NOT NULL, --Мыло юзера -- денормализоанная запись чтоб не лазить за ним лишний раз
  POSITION   TEXT                 NOT NULL, --Должность
  AGE        INT                  NOT NULL, --Возраст
  NAME       TEXT                 NOT NULL, --ФИО
  EXPIRIENCE INT                  NOT NULL, --Опыт в мес.
  SKILLS     TEXT,                          --Скиллы
  SALARY_MIN INT                  NOT NULL, --Вилка зп
  SALARY_MAX INT
);

DO
$do$
DECLARE
	usrid INT;
	usrem TEXT;
BEGIN  
FOR i IN 1..2500000 LOOP
usrid := ((random() * 2499 + 1):: INT);
--raise notice 'Id: %', usrid;
SELECT EMAIL INTO usrem FROM users WHERE ID=usrid;
--raise notice 'em: %', usrem;
INSERT INTO summaries (	USR_ID,
						USR_EMAIL, 
						POSITION, 
						AGE,      
                        NAME,
                        EXPIRIENCE,
						SKILLS    ,
						SALARY_MIN,
						SALARY_MAX
						)
			VALUES (usrid,
					usrem,
					random_string(((random() * 20 + 4):: INT)),                                         
					((random() * 60 + 10):: INT),                   
					random_string(((random() * 20 + 4):: INT)),
					((random() * 20 + 1):: INT),
					random_string(((random() * 10 + 4):: INT)),
					((random() * 10000 + 10000):: INT),
					((random() * 200000 + 20000):: INT)
					);
END LOOP;
END;
$do$;
SELECT COUNT(*) FROM summaries;
