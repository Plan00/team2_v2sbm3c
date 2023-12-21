/**********************************/
/* Table Name: MYPILL */
/**********************************/
DROP TABLE MYPILL;

commit;

CREATE TABLE MYPILL(
mypill_no NUMBER(10) NOT NULL,
memberno NUMBER(10) NOT NULL,
pill_no NUMBER(10) NOT NULL,
mypill_name VARCHAR2(30) NOT NULL,
mypill_date DATE NOT NULL,
PRIMARY KEY (mypill_no),
FOREIGN KEY(memberno) REFERENCES MEMBER(memberno),
FOREIGN KEY(pill_no) REFERENCES PILL(pill_no)
);

COMMENT ON TABLE MYPILL is '내 알약';
COMMENT ON COLUMN MYPILL.mypill_no is '내 알약 번호';
COMMENT ON COLUMN MYPILL.memberno is '회원 번호';
COMMENT ON COLUMN MYPILL.pill_no is '알약 번호';
COMMENT ON COLUMN MYPILL.mypill_name is '품목명';
COMMENT ON COLUMN MYPILL.mypill_date is '내 알약 등록일';

commit;


DROP SEQUENCE MYPILL_SEQ;

CREATE SEQUENCE MYPILL_SEQ
  START WITH 1         -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2              -- 2번은 메모리에서만 계산
  NOCYCLE;             -- 다시 1부터 생성되는 것을 방지