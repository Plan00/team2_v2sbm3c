/**********************************/
/* Table Name: RECOM */
/**********************************/
DROP TABLE RECOM;

CREATE TABLE   RECOM(
RECOMMENDNO number(10) PRIMARY KEY,
MEMBERNO NUMBER(10) NOT NULL,
DNO NUMBER(10) NOT NULL,
SEQ NUMBER(2) NOT NULL,
RDATE DATE NOT NULL,
FOREIGN KEY(MEMBERNO) REFERENCES MEMBER(MEMBERNO),
FOREIGN KEY(DNO) REFERENCES DISEASE(DNO)
);