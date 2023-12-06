/**********************************/
/* Table Name: MYPILL */
/**********************************/
DROP TABLE MYPILL;

CREATE TABLE MYPILL(
MYPILL_NO NUMBER(10) PRIMARY KEY,
MEMBERNO NUMBER(10) NOT NULL,
PILL_NO NUMBER(10) NOT NULL,
MYPILL_NAME VARCHAR2(30) NOT NULL,
FOREIGN KEY(MEMBERNO) REFERENCES MEMBER(MEMBERNO),
FOREIGN KEY(PILL_NO) REFERENCES PILL(PILL_NO)
);