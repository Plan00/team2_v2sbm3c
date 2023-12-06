/**********************************/
/* Table Name: Member */
/**********************************/
DROP TABLE Member;

CREATE TABLE Member(
MemberNo NUMBER(10) PRIMARY KEY,
ID VARCHAR2(30) NOT NULL,
Passwd VARCHAR2(30) NOT NULL,
MName VARCHAR2(60),
Age VARCHAR2(30),
Mdate DATE
);