/**************************************/
/* Table Name: 관리자 로그인 내역 */
/**************************************/
DROP TABLE MANLOGIN;

commit;

CREATE TABLE MANLOGIN(
  manloginno                    NUMBER(10) NOT NULL PRIMARY KEY,
  manager_no                  NUMBER(10) NOT NULL,
  ip                            VARCHAR2(15) NOT NULL,
  ldate                  DATE NOT NULL,
  FOREIGN KEY (manager_no) REFERENCES MANAGER(manager_no)
);

COMMENT ON TABLE MANLOGIN is '로그인 내역';
COMMENT ON COLUMN MANLOGIN.manloginno is '로그인 번호';
COMMENT ON COLUMN MANLOGIN.manager_no is '회원 번호';
COMMENT ON COLUMN MANLOGIN.ip is '접속 IP';
COMMENT ON COLUMN MANLOGIN.ldate is '로그인 날짜';

commit;


DROP SEQUENCE MANLOGIN_SEQ;

CREATE SEQUENCE MANLOGIN_SEQ
  START WITH 1         -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2              -- 2번은 메모리에서만 계산
  NOCYCLE;             -- 다시 1부터 생성되는 것을 방지