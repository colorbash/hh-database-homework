\c testdb
DROP TABLE vacancies;
CREATE TABLE vacancies(
  ID             SERIAL,				   --��
  NAME           TEXT             NOT NULL,--��������
  POSITION       TEXT             NOT NULL,--���������
  DESCRIPTION    TEXT,                     --��������
  TIME_REG       TIMESTAMP        NOT NULL,--����� �����������
  EXPIRIENCE     INT              NOT NULL,-- ���� � ���.
  ACTIVE_DAYS    INT              NOT NULL,--������� ����� ��������
  SALARY_MIN     INT              NOT NULL,--����� ��
  SALARY_MAX     INT
);

DO
$do$
BEGIN 
 
FOR i IN 1..2500000 LOOP

  INSERT INTO vacancies (	NAME, 
						POSITION, 
						DESCRIPTION, 
						TIME_REG, 
						EXPIRIENCE,
						ACTIVE_DAYS,
						SALARY_MIN,    
                        SALARY_MAX) 
			VALUES (random_string(((random() * 20 + 4):: INT)),
					random_string(((random() * 20 + 4):: INT)),
					random_string(((random() * 500 + 4):: INT)),
					'2001-09-28 01:00:00',
					((random() * 80 + 1):: INT),
					((random() * 20 + 4):: INT),
					((random() * 2000000 + 10000):: INT),
					((random() * 2000000 + 10000):: INT));
                         
END LOOP;
END;
$do$;
SELECT COUNT(*) FROM vacancies;



                      