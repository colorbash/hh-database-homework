\c testdb

--функции заполнения
--CREATE OR REPLACE FUNCTION random_string(l INT)RETURNS TEXT AS $$
--DECLARE
--  chars TEXT[] := '{0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z}';
--  res TEXT := '';
--  i INT := 0;
--BEGIN
--  FOR i IN 1..l LOOP
--    res := res || chars[1+random()*(array_length(chars, 1)-1)];
--  END LOOP;
--  RETURN res;
--END;
--$$ LANGUAGE plpgsql;
----________________________________________________________________________________________________________________________________________
--CREATE OR REPLACE FUNCTION random_email(l INT)RETURNS TEXT AS $$
--DECLARE
--  res TEXT;
--BEGIN
--  res := random_string(l);
--  res := res || '@yangex.ru';
--  RETURN res;
--END;
--$$ LANGUAGE plpgsql;
----________________________________________________________________________________________________________________________________________
----USERS
--DO
--$do$
--DECLARE
--  counter INT := 0;
--BEGIN 
--FOR i IN 1..2500 LOOP
--  INSERT INTO users (EMAIL, PSSWD, TIME_REG, LAST_TIME)
--  VALUES (random_email(((random() * 20 + 4):: INT))
--        , random_string(((random() * 20 + 4):: INT)) 
--        ,'2011-09-28 01:00:00'
--        ,'2012-09-28 01:00:00');
--END LOOP;
--SELECT COUNT(*) INTO counter FROM users;
--RAISE NOTICE 'users filleed ok, size: %', counter;
--END;
--$do$;
--
----________________________________________________________________________________________________________________________________________
----VACANCIES
--DO
--$do$
--DECLARE
--  counter INT := 0;
--BEGIN 
--FOR i IN 1..2500000 LOOP
--
--  INSERT INTO vacancies (NAME, 
--                        POSITION, 
--                        DESCRIPTION, 
--                        TIME_REG, 
--                        EXPIRIENCE,
--                        ACTIVE_DAYS,
--                        SALARY_MIN,    
--                        SALARY_MAX) 
--            VALUES (random_string(((random() * 20 + 4):: INT)),
--                    random_string(((random() * 20 + 4):: INT)),
--                    random_string(((random() * 500 + 4):: INT)),
--                    '2001-09-28 01:00:00',
--                    ((random() * 80 + 1):: INT),
--                    ((random() * 20 + 4):: INT),
--                    ((random() * 2000000 + 10000):: INT),
--                    ((random() * 2000000 + 10000):: INT));
--                         
--END LOOP;
--SELECT COUNT(*) INTO counter FROM vacancies;
--RAISE NOTICE 'vacancies filled ok, size: %', counter;
--END;
--$do$;

--________________________________________________________________________________________________________________________________________
--SUMMARIES
--DO
--$do$
--DECLARE
--  usrid INT;
--  usrem TEXT;
--  counter INT := 0;
--BEGIN  
--FOR i IN 1..2500000 LOOP
--usrid := ((random() * 2499 + 1):: INT);
--SELECT EMAIL INTO usrem FROM users WHERE ID=usrid;
--INSERT INTO summaries ( USR_ID,
--                        USR_EMAIL, 
--                        POSITION, 
--                        AGE,      
--                        NAME,
--                        EXPIRIENCE,
--                        SKILLS    ,
--                        SALARY_MIN,
--                        SALARY_MAX
--                        )
--            VALUES (usrid,
--                    usrem,
--                    random_string(((random() * 20 + 4):: INT)),                                         
--                    ((random() * 60 + 10):: INT),                   
--                    random_string(((random() * 20 + 4):: INT)),
--                    ((random() * 20 + 1):: INT),
--                    random_string(((random() * 10 + 4):: INT)),
--                    ((random() * 10000 + 10000):: INT),
--                    ((random() * 200000 + 20000):: INT)
--                    );
--END LOOP;
--SELECT COUNT(*) INTO counter FROM vacancies;
--RAISE NOTICE 'summaries filled ok, size: %', counter;
--END;
--$do$;
--
----________________________________________________________________________________________________________________________________________
----RESPONSES
--DO
--$do$
--DECLARE
--  counter INT := 0;
--BEGIN  
--FOR i IN 1..2500000 LOOP
--INSERT INTO responses ( ID_VACANCY,
--                        ID_SUMMARY
--                        )
--            VALUES (((random() * (2500000-1) + 1):: INT),
--                    ((random() * (2500000-1) + 1):: INT)
--                    );
--END LOOP;
--SELECT COUNT(*) INTO counter FROM responses;
--RAISE NOTICE 'responses filled ok, size: %', counter;
--END;
--$do$;
--
--________________________________________________________________________________________________________________________________________
--MESSAGES
DO
$do$
DECLARE
  counter INT := 0;
BEGIN  
FOR i IN 1..2500000 LOOP

INSERT INTO messages (  ID_RESPONSE,
                        MESSAGE,
                        MSG_TIME
                        )
            VALUES (((random() * (2500000-1) + 1):: INT),
                    random_string(((random() * 40 + 4):: INT)),   
                    '2001-09-28 01:00:00'
                    );
END LOOP;
SELECT COUNT(*) INTO counter FROM messages;
RAISE NOTICE 'messages filled ok, size: %', counter;
END;
$do$;

