/**********************************/
/* Table Name: MLOGIN */
/**********************************/
DROP TABLE MLOGIN;

commit;

CREATE TABLE MLOGIN(
mloginno NUMBER(10) NOT NULL,
memberno NUMBER(10) NOT NULL,
ip VARCHAR2(15) NOT NULL,
ldate DATE NOT NULL,
PRIMARY KEY (mloginno),
FOREIGN KEY(memberno) REFERENCES MEMBER(memberno)
);

COMMENT ON TABLE MLOGIN is '회원 로그인 내역';
COMMENT ON COLUMN MLOGIN.mloginno is '로그인 번호';
COMMENT ON COLUMN MLOGIN.memberno is '회원 번호';
COMMENT ON COLUMN MLOGIN.ip is '접속 ip';
COMMENT ON COLUMN MLOGIN.ldate is '로그인 날짜';

commit;


DROP SEQUENCE MLOGIN_SEQ;

CREATE SEQUENCE MLOGIN_SEQ
  START WITH 1         -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2              -- 2번은 메모리에서만 계산
  NOCYCLE;             -- 다시 1부터 생성되는 것을 방지