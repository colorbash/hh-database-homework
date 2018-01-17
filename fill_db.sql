\c testdb

--функции заполнения
CREATE OR REPLACE FUNCTION random_string(l INT)RETURNS TEXT AS $$
DECLARE
  chars TEXT[] := '{0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z}';
  res TEXT := '';
  i INT := 0;
BEGIN
  FOR i IN 1..l LOOP
    res := res || chars[1+random()*(array_length(chars, 1)-1)];
  END LOOP;
  RETURN res;
END;
$$ LANGUAGE plpgsql;
--________________________________________________________________________________________________________________________________________
CREATE OR REPLACE FUNCTION random_email(l INT)RETURNS TEXT AS $$
DECLARE
  res TEXT;
BEGIN
  res := random_string(l);
  res := res || '@yangex.ru';
  RETURN res;
END;
$$ LANGUAGE plpgsql;
--________________________________________________________________________________________________________________________________________
--USERS

INSERT INTO users (EMAIL, 
                   PSSWD, 
                   TIME_REG,
                   LAST_TIME)
   SELECT
       random_email(((random() * 20 + 4) :: INT)),
       random_string(((random() * 20 + 4):: INT)),
       '2011-09-28 01:00:00' :: TIMESTAMP + random() * '365 days' :: INTERVAL,
       '2012-09-28 01:00:00' :: TIMESTAMP + random() * '365 days' :: INTERVAL
   FROM generate_series(1, 2500) AS t(num);
SELECT COUNT(*) FROM users;
--________________________________________________________________________________________________________________________________________
--VACANCIES

INSERT INTO vacancies (NAME       ,
                       POSITION   ,
                       DESCRIPTION,
                       TIME_REG   ,
                       TIME_END   ,
                       EXPIRIENCE ,
                       SALARY_MIN ,
                       SALARY_MAX )
   SELECT
       random_string(((random() * 20 + 4)  :: INT)),
       random_string(((random() * 20 + 4)  :: INT)),
       random_string(((random() * 100 + 10):: INT)),
       '2011-01-01 01:00:00' :: TIMESTAMP + random() * '365 days' :: INTERVAL,
       '2012-01-01 01:00:00' :: TIMESTAMP + random() * '365 days' :: INTERVAL,
       ((random() * 80 + 1)                :: INT),
       ((random() * 20000   + 10000)       :: INT),
       ((random() * 2000000 + 10000)       :: INT)
   FROM generate_series(1, 2500000) AS t(num);
SELECT COUNT(*) FROM vacancies;
--_______________________________________________________________________________________________________________________________________
--SUMMARIES

INSERT INTO summaries (USR_ID    ,
                       USR_EMAIL ,
                       POSITION  ,
                       AGE       ,
                       NAME      ,
                       EXPIRIENCE,
                       SKILLS    ,
                       SALARY_MIN,
                       SALARY_MAX)
    SELECT
        u.USR_ID,
        u.EMAIL,
        random_string((random() * 20 + 4)  :: INT),
        ((random() * 40 + 18)              :: INT),
        (random_string(((random() * 20 + 4):: INT)), random_string(((random() * 20 + 4):: INT)), random_string(((random() * 20 + 4):: INT))) :: FULL_NAME,
        ((random() * 40 + 1)               :: INT),
        random_string((random() * 20 + 4)  :: INT),
        ((random() * 20000   + 10000)      :: INT),
        ((random() * 2000000 + 10000)      :: INT)
    FROM users u
        LEFT JOIN generate_series(1, 10000) AS t(num) ON (1 = round(random() * 10));
SELECT COUNT(*) FROM summaries;
--________________________________________________________________________________________________________________________________________
--RESPONCIES
INSERT INTO responses (VACANCY_ID, SUMMARY_ID)
    SELECT
        v.VACANCY_ID,
        s.SUMMARY_ID
    FROM (SELECT VACANCY_ID
          FROM vacancies
          ORDER BY random()
          LIMIT 5000) AS v
        JOIN (SELECT SUMMARY_ID
              FROM summaries
              ORDER BY random()
              LIMIT 5000) AS s ON 1 = round(random() * 10);
SELECT COUNT(*) FROM responses;
--________________________________________________________________________________________________________________________________________
--MESSAGES
INSERT INTO messages (RESPONSE_ID,
                      MESSAGE,    
                      MSG_TIME)
    SELECT
        r.RESPONSE_ID,
        random_string((random() * 50 + 4):: INT),
        '2012-01-01 01:00:00' :: TIMESTAMP + random() * '365 days' :: INTERVAL
    FROM (SELECT RESPONSE_ID
          FROM responses) AS r LEFT JOIN generate_series(1, 20) AS t(num) ON 1 = round(random() * 5);
SELECT COUNT(*) FROM messages;
--________________________________________________________________________________________________________________________________________


