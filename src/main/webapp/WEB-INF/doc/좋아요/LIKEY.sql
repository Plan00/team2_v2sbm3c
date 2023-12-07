/**********************************/
/* Table Name: LIKEY */
/**********************************/
DROP TABLE LIKEY;

commit;

CREATE TABLE   LIKEY(
LIKENO number(10) PRIMARY KEY,
PILL_NO NUMBER(10) NOT NULL,
RDATE DATE NOT NULL,
MEMBERNO NUMBER(10) NOT NULL,
FOREIGN KEY(PILL_NO) REFERENCES PILL(PILL_NO)
);

commit;
