
--________________________________________________________________________________________________________________________________________

DROP FUNCTION random_string(length DOUBLE PRECISION);
DROP FUNCTION random_string(length integer);
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
DROP FUNCTION random_email(length DOUBLE PRECISION);
DROP FUNCTION random_email(length integer);
CREATE OR REPLACE FUNCTION random_email(l INT)RETURNS TEXT AS $$
DECLARE
  chars TEXT[] := '{0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z}';
  res TEXT := '';
  i INT := 0;
BEGIN
  FOR i IN 1..l LOOP
    res := res || chars[1+random()*(array_length(chars, 1)-1)];
  END LOOP;
  res := res || '@yangex.ru';
  RETURN res;
END;
$$ LANGUAGE plpgsql;
--________________________________________________________________________________________________________________________________________

\c testdb

DROP TABLE users;
CREATE TABLE users(
  ID		SERIAL, 
  EMAIL     TEXT       			  NOT NULL,--Мыло
  PSSWD     TEXT                  NOT NULL,--Пароль
  TIME_REG  TIMESTAMP             NOT NULL,--Веремя регистрации
  LAST_TIME TIMESTAMP             NOT NULL --Последнее время захода
);
--________________________________________________________________________________________________________________________________________

DO
$do$
BEGIN 
 
FOR i IN 1..2500 LOOP

  INSERT INTO users (EMAIL, PSSWD, TIME_REG, LAST_TIME)
  VALUES (random_email(((random() * 20 + 4):: INT))
        , random_string(((random() * 20 + 4):: INT)) 
        ,'2011-09-28 01:00:00'
		,'2012-09-28 01:00:00');
END LOOP;
END;
$do$;
SELECT COUNT(*) FROM users;
