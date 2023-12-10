/**********************************/
/* Table Name: MANAGER */
/**********************************/
DROP TABLE MANAGER;

commit;

CREATE TABLE   MANAGER(
MANAGER_NO number(10) NOT NULL,
MANAGER_ID VARCHAR2(30) NOT NULL,
MANAGER_PASSWD VARCHAR2(60) NOT NULL,
MANAGER_NAME VARCHAR2(30) NOT NULL,
MANAGER_DATE DATE NOT NULL,
MANAGER_GRADE NUMBER(2)     NOT NULL,
PRIMARY KEY (manager_no)
);

COMMENT ON TABLE MANAGER is '관리자';
COMMENT ON COLUMN MANAGER.MANAGER_NO is '관리자 번호';
COMMENT ON COLUMN MANAGER.MANAGER_ID is '아이디';
COMMENT ON COLUMN MANAGER.MANAGER_PASSWD is '비밀번호';
COMMENT ON COLUMN MANAGER.MANAGER_NAME is '성명';
COMMENT ON COLUMN MANAGER.MANAGER_DATE is '가입일';
COMMENT ON COLUMN MANAGER.MANAGER_GRADE is '등급';

commit;

DROP SEQUENCE MANAGER_SEQ;

CREATE SEQUENCE MANAGER_SEQ
  START WITH 1              -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 99999            -- 최대값: 99999 --> NUMBER(5) 대응
  CACHE 2                   -- 2번은 메모리에서만 계산
  NOCYCLE;                  -- 다시 1부터 생성되는 것을 방지


-- CREATE
INSERT INTO manager(manager_no, manager_id, manager_passwd, manager_name, manager_date, manager_grade)
VALUES(manager_seq.nextval, 'manager1', '1234', '관리자1', sysdate, 1);

INSERT INTO manager(manager_no, manager_id, manager_passwd, manager_name, manager_date, manager_grade)
VALUES(manager_seq.nextval, 'manager2', '1234', '관리자2', sysdate, 1);

INSERT INTO manager(manager_no, manager_id, manager_passwd, manager_name, manager_date, manager_grade)
VALUES(manager_seq.nextval, 'manager3', '1234', '관리자3', sysdate, 1);

commit;

-- READ: List
SELECT manager_no, manager_id, manager_passwd, manager_name, manager_date, manager_grade FROM manager ORDER BY manager_no ASC;


-- READ         
SELECT manager_no, manager_id, manager_passwd, manager_name, manager_date, manager_grade
FROM manager
WHERE manager_no=1;


-- READ by id
SELECT manager_no, manager_id, manager_passwd, manager_name, manager_date, manager_grade
FROM manager
WHERE mid='manager1';


-- UPDATE
UPDATE manager
SET manager_passwd='1234', manager_name='관리자1', manager_date=sysdate, manager_grade=1
WHERE manager_no=1;

COMMIT;


-- DELETE
DELETE FROM manager WHERE manager_no=3;


-- 로그인, 1: 로그인 성공, 0: 로그인 실패
SELECT COUNT(*) as cnt
FROM manager
WHERE manager_id='manager1' AND manager_passwd='1234'; 






















