/**********************************/
/* Table Name: disease */
/**********************************/
DROP TABLE DISEASE;

CREATE TABLE DISEASE(
		DNO                        		NUMBER(10)		 NOT NULL PRIMARY KEY,
		DNAME                          		VARCHAR2(30)	 NOT NULL
);

COMMENT ON TABLE DISEASE is '질병 카테고리';
COMMENT ON COLUMN DISEASE.DNO is '질병 번호';
COMMENT ON COLUMN DISEASE.DNAME is '질병 이름';

DROP SEQUENCE DISEASE_SEQ;

CREATE SEQUENCE DISEASE_SEQ
  START WITH 1         -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2              -- 2번은 메모리에서만 계산
  NOCYCLE;             -- 다시 1부터 생성되는 것을 방지
  
-- CREATE
INSERT INTO disease(dno, dname) VALUES(disease_seq.nextval, '감기');
INSERT INTO disease(dno, dname) VALUES(disease_seq.nextval, '두통');
INSERT INTO disease(dno, dname) VALUES(disease_seq.nextval, '소화불량');
INSERT INTO disease(dno, dname) VALUES(disease_seq.nextval, '피부질환');
INSERT INTO disease(dno, dname) VALUES(disease_seq.nextval, '비염');
INSERT INTO disease(dno, dname) VALUES(disease_seq.nextval, '구강질환');
INSERT INTO disease(dno, dname) VALUES(disease_seq.nextval, '피로');

-- READ: LIST
SELECT * FROM disease;
SELECT dno, dname FROM disease ORDER BY dno ASC;

-- READ
SELECT dno, dname FROM disease WHERE dno=1;

-- UPDATE
UPDATE disease SET dname='다른질병' WHERE dno=1;

-- DELETE
DELETE FROM disease WHERE dno=1;

COMMIT;

-- COUNT
SELECT COUNT(*) as cnt FROM disease;

-- READ: LIST
SELECT dno, dname FROM disease ORDER BY dno ASC;

COMMIT;

-- 비회원/회원 SELECT LIST, id: list_all_y
SELECT dno, dname
FROM disease 
ORDER BY dno ASC;




         






