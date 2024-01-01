/**********************************/
/* Table Name: ANSWER */
/**********************************/
DROP TABLE ANSWER;

commit;

CREATE TABLE ANSWER(
ANO NUMBER(10) NOT NULL,
QNA_NO NUMBER(10) NOT NULL,
MANAGER_NO NUMBER(10) NOT NULL,
AMAIN VARCHAR(4000) NOT NULL,
ADATE DATE NOT NULL,
PRIMARY KEY (ANO),
FOREIGN KEY(QNA_NO) REFERENCES QNA(QNA_NO),
FOREIGN KEY(MANAGER_NO) REFERENCES MANAGER(MANAGER_NO)
);

COMMENT ON TABLE ANSWER is '답변';
COMMENT ON COLUMN ANSWER.ANO is '답변 번호';
COMMENT ON COLUMN ANSWER.QNA_NO is 'QNA 번호';
COMMENT ON COLUMN ANSWER.MANAGER_NO is '관리자 번호';
COMMENT ON COLUMN ANSWER.AMAIN is '답변 내용';
COMMENT ON COLUMN ANSWER.ADATE is '답변 등록일';

commit;

DROP SEQUENCE ANSWER_SEQ;

CREATE SEQUENCE ANSWER_SEQ
  START WITH 1         -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2              -- 2번은 메모리에서만 계산
  NOCYCLE;             -- 다시 1부터 생성되는 것을 방지