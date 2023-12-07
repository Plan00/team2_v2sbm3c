/**********************************/
/* Table Name: QNA */
/**********************************/
DROP TABLE QNA;

commit;

CREATE TABLE QNA(
qna_no NUMBER(10) NOT NULL,
memberno NUMBER(10) NOT NULL,
qna_title VARCHAR2(100) NOT NULL,
qna_main VARCHAR2(4000) NOT NULL,
qna_passwd VARCHAR2(60) NOT NULL,
qna_date DATE NOT NULL,
PRIMARY KEY (qna_no),
FOREIGN KEY(memberno) REFERENCES Member(memberno)
);

COMMENT ON TABLE QNA is 'QNA';
COMMENT ON COLUMN QNA.qna_no is 'QNA 번호';
COMMENT ON COLUMN QNA.memberno is '회원번호';
COMMENT ON COLUMN QNA.qna_title is 'QNA 제목';
COMMENT ON COLUMN QNA.qna_main is 'QNA 내용';
COMMENT ON COLUMN QNA.qna_passwd is 'QNA 비밀번호';
COMMENT ON COLUMN QNA.qna_date is 'QNA 등록일';

commit;