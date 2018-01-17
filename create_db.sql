
CREATE DATABASE testdb;

\c testdb

CREATE TYPE FULL_NAME AS (
    FIRST_NAME   TEXT,
    SECOND_NAME  TEXT,
    PATRON_NAME  TEXT
);
--________________________________________________________________________________________________________________________________________

CREATE TABLE users(
  USR_ID         SERIAL                PRIMARY KEY, 
  EMAIL          TEXT                  NOT NULL,--Мыло
  PSSWD          TEXT                  NOT NULL,--Пароль
  TIME_REG       TIMESTAMP             NOT NULL,--Веремя регистрации
  LAST_TIME      TIMESTAMP             NOT NULL --Последнее время захода
  -- Стоит ли включать личную информацию о юзере в его запись (возраст и имя,...)? если например кейс что организация (биржа труда) размещает резюме людей которые не могут сами найти себе работу... или сын дает резюме для мамы... или другие случаи...
);
CREATE UNIQUE INDEX email_index
    ON users (EMAIL);
--________________________________________________________________________________________________________________________________________

CREATE TABLE vacancies(
  VACANCY_ID     SERIAL                PRIMARY KEY,--ИД
  NAME           TEXT                  NOT NULL,--НАЗВАНИЕ
  POSITION       TEXT                  NOT NULL,--Должность
  DESCRIPTION    TEXT,                          --Описание
  TIME_REG       TIMESTAMP             NOT NULL,--Время регистрации
  TIME_END       TIMESTAMP             NOT NULL,--Время окончания действия вакансии
  EXPIRIENCE     INT                   NOT NULL,--Опыт в мес.
  SALARY_MIN     INT                           ,--Вилка ЗП
  SALARY_MAX     INT
);

CREATE INDEX salary_index
    ON vacancies (SALARY_MIN, SALARY_MAX); --индекс по ЗП 
--________________________________________________________________________________________________________________________________________

CREATE TABLE summaries (--Резюме
  SUMMARY_ID     SERIAL                PRIMARY KEY,--ID
  USR_ID         INT                   REFERENCES users, --ID юзера
  USR_EMAIL      TEXT                  NOT NULL, --Мыло юзера -- денормализоанная запись чтоб не лазить за ним лишний раз
  POSITION       TEXT                  NOT NULL, --Должность
  AGE            INT                   NOT NULL, --Возраст
  NAME           FULL_NAME             NOT NULL, --ФИО
  EXPIRIENCE     INT                   NOT NULL, --Опыт в мес.
  SKILLS         TEXT,                           --Скиллы
  SALARY_MIN     INT                   NOT NULL, --Вилка зп
  SALARY_MAX     INT
);

CREATE INDEX user_expirience_index
    ON summaries (EXPIRIENCE);              -- Индекс по опыту
--________________________________________________________________________________________________________________________________________

CREATE TABLE responses (
  RESPONSE_ID    SERIAL                PRIMARY KEY,
  VACANCY_ID     INT                   REFERENCES vacancies,
  SUMMARY_ID     INT                   REFERENCES summaries
);
--________________________________________________________________________________________________________________________________________

CREATE TABLE messages(
  MESSAGE_ID     SERIAL                PRIMARY KEY,
  RESPONSE_ID    INT                   NOT NULL,
  MESSAGE        TEXT                  NOT NULL,
  MSG_TIME       TIMESTAMP             NOT NULL
);
--________________________________________________________________________________________________________________________________________
