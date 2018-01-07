CREATE DATABASE testdb;
\c testdb

CREATE TABLE users(
  ID        SERIAL                PRIMARY KEY, 
  EMAIL     TEXT                  NOT NULL,--����
  PSSWD     TEXT                  NOT NULL,--������
  TIME_REG  TIMESTAMP             NOT NULL,--������ �����������
  LAST_TIME TIMESTAMP             NOT NULL --��������� ����� ������
);
--________________________________________________________________________________________________________________________________________

CREATE TABLE vacancies(
  ID             SERIAL           PRIMARY KEY,--��
  NAME           TEXT             NOT NULL,--��������
  POSITION       TEXT             NOT NULL,--���������
  DESCRIPTION    TEXT,                     --��������
  TIME_REG       TIMESTAMP        NOT NULL,--����� �����������
  EXPIRIENCE     INT              NOT NULL,-- ���� � ���.
  ACTIVE_DAYS    INT              NOT NULL,--������� ����� ��������
  SALARY_MIN     INT              NOT NULL,--����� ��
  SALARY_MAX     INT
);
--________________________________________________________________________________________________________________________________________

CREATE TABLE summaries (--������
  ID         SERIAL               PRIMARY KEY,--ID
  USR_ID     INT                  REFERENCES users, --ID �����
  USR_EMAIL  TEXT                 NOT NULL, --���� ����� -- ���������������� ������ ���� �� ������ �� ��� ������ ���
  POSITION   TEXT                 NOT NULL, --���������
  AGE        INT                  NOT NULL, --�������
  NAME       TEXT                 NOT NULL, --���
  EXPIRIENCE INT                  NOT NULL, --���� � ���.
  SKILLS     TEXT,                          --������
  SALARY_MIN INT                  NOT NULL, --����� ��
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
