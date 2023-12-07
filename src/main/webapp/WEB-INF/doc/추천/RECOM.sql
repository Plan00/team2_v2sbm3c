/**********************************/
/* Table Name: RECOM */
/**********************************/
DROP TABLE RECOM;

commit;

CREATE TABLE   RECOM(
recommendno number(10) NOT NULL,
memberno NUMBER(10) NOT NULL,
dno NUMBER(10) NOT NULL,
seq NUMBER(2) NOT NULL,
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