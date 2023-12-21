/**********************************/
/* Table Name: RECOM */
/**********************************/
DROP TABLE RECOM;

commit;

CREATE TABLE   RECOM(
recommendno number(10) NOT NULL,
memberno NUMBER(10) NOT NULL,
dno NUMBER(10) NOT NULL,
seq NUMBER(2) DEFAULT 1 NOT NULL,
rdate DATE NOT NULL,
PRIMARY KEY (recommendno),
FOREIGN KEY(memberno) REFERENCES MEMBER(memberno),
FOREIGN KEY(dno) REFERENCES DISEASE(dno)
);

COMMENT ON TABLE RECOM is '추천';
COMMENT ON COLUMN RECOM.recommendno is '추천 번호';
COMMENT ON COLUMN RECOM.memberno is '회원 번호';
COMMENT ON COLUMN RECOM.dno is '질병 번호';
COMMENT ON COLUMN RECOM.seq is '추천우선순위';
COMMENT ON COLUMN RECOM.rdate is '추천 날짜';

commit;

DROP SEQUENCE RECOM_SEQ;

CREATE SEQUENCE RECOM_SEQ
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지


-- 존재하는 memberno, cateno 등록
INSERT INTO recom(recommendno, memberno, dno, seq, rdate)
VALUES(RECOM_SEQ.nextval, 1, 1, 1, sysdate);

SELECT recommendno, memberno, cateno, seq, rdate 
FROM recom 
ORDER BY recommendno ASC;
-- 1번회원은 1번 카테고리를 추천필요.
RECOMMENDNO   MEMBERNO     dno        SEQ RDATE              
----------- ---------- ---------- ---------- -------------------
          6          1          1          1 2023-06-15 02:53:32

DELETE FROM recom;
DELETE FROM recom WHERE memberno=1;
COMMIT;