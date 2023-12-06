/**********************************/
/* Table Name: QNA */
/**********************************/
DROP TABLE QNA;

CREATE TABLE QNA(
QNA_NO NUMBER(10) PRIMARY KEY,
MemberNo NUMBER(10) NOT NULL,
Qna_Title VARCHAR2(100),
Qna_Main VARCHAR2(4000),
Qna_Passwd VARCHAR2(60),
FOREIGN KEY(MemberNo) REFERENCES Member(MemberNo)
);