CREATE DATABASE testdb;
\c testdb

CREATE TABLE users(
  ID        SERIAL                PRIMARY KEY, 
  EMAIL     TEXT                  NOT NULL,--Мыло
  PSSWD     TEXT                  NOT NULL,--Пароль
  TIME_REG  TIMESTAMP             NOT NULL,--Веремя регистрации
  LAST_TIME TIMESTAMP             NOT NULL --Последнее время захода
);
--________________________________________________________________________________________________________________________________________

CREATE TABLE vacancies(
  ID             SERIAL           PRIMARY KEY,--ИД
  NAME           TEXT             NOT NULL,--НАЗВАНИЕ
  POSITION       TEXT             NOT NULL,--Должность
  DESCRIPTION    TEXT,                     --Описание
  TIME_REG       TIMESTAMP        NOT NULL,--Время регистрации
  EXPIRIENCE     INT              NOT NULL,-- Опыт в мес.
  ACTIVE_DAYS    INT              NOT NULL,--Активно после создания
  SALARY_MIN     INT              NOT NULL,--Вилка ЗП
  SALARY_MAX     INT
);
--________________________________________________________________________________________________________________________________________

CREATE TABLE summaries (--Резюме
  ID         SERIAL               PRIMARY KEY,--ID
  USR_ID     INT                  REFERENCES users, --ID юзера
  USR_EMAIL  TEXT                 NOT NULL, --Мыло юзера -- денормализоанная запись чтоб не лазить за ним лишний раз
  POSITION   TEXT                 NOT NULL, --Должность
  AGE        INT                  NOT NULL, --Возраст
  NAME       TEXT                 NOT NULL, --ФИО
  EXPIRIENCE INT                  NOT NULL, --Опыт в мес.
  SKILLS     TEXT,                          --Скиллы
  SALARY_MIN INT                  NOT NULL, --Вилка зп
  SALARY_MAX INT
);
--________________________________________________________________________________________________________________________________________

CREATE TABLE responses (
  ID_RESPONSE SERIAL              PRIMARY KEY,
  ID_VACANCY  INT                 REFERENCES vacancies,
  ID_SUMMARY  INT                 REFERENCES summaries
);
--________________________________________________________________________________________________________________________________________

CREATE TABLE messages(
  ID_RESPONSE INT                 NOT NULL,
  MESSAGE     TEXT                NOT NULL,
  MSG_TIME    TIMESTAMP           NOT NULL
);
--________________________________________________________________________________________________________________________________________
