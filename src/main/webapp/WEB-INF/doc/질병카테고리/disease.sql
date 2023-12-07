/**********************************/
/* Table Name: disease */
/**********************************/
DROP TABLE DISEASE;

commit;

CREATE TABLE DISEASE(
		DNO                        		NUMBER(10)		 NOT NULL PRIMARY KEY,
		DNAME                          		VARCHAR2(30)	 NOT NULL,
        CNT                           		NUMBER(7)		 DEFAULT 0 NOT NULL,
		RDATE                         		DATE		     NOT NULL,
        SEQNO                               NUMBER(5)        DEFAULT 1 NOT NULL,
        VISIBLE                             CHAR(1)          DEFAULT 'N' NOT NULL
);

COMMENT ON TABLE DISEASE is '질병 카테고리';
COMMENT ON COLUMN DISEASE.DNO is '질병 번호';
COMMENT ON COLUMN DISEASE.DNAME is '질병 이름';
COMMENT ON COLUMN DISEASE.CNT is '관련 자료수';
COMMENT ON COLUMN DISEASE.RDATE is '등록일';
COMMENT ON COLUMN DISEASE.SEQNO is '출력 순서';
COMMENT ON COLUMN DISEASE.VISIBLE is '출력 모드';

DROP SEQUENCE DISEASE_SEQ;

CREATE SEQUENCE DISEASE_SEQ
  START WITH 1         -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2              -- 2번은 메모리에서만 계산
  NOCYCLE;             -- 다시 1부터 생성되는 것을 방지
  
-- CREATE
INSERT INTO disease(dno, dname, cnt, rdate) VALUES(disease_seq.nextval, '감기', 0, sysdate);
INSERT INTO disease(dno, dname, cnt, rdate) VALUES(disease_seq.nextval, '두통', 0, sysdate);
INSERT INTO disease(dno, dname, cnt, rdate) VALUES(disease_seq.nextval, '소화불량', 0, sysdate);
INSERT INTO disease(dno, dname, cnt, rdate) VALUES(disease_seq.nextval, '피부질환', 0, sysdate);
INSERT INTO disease(dno, dname, cnt, rdate) VALUES(disease_seq.nextval, '비염', 0, sysdate);
INSERT INTO disease(dno, dname, cnt, rdate) VALUES(disease_seq.nextval, '구강질환', 0, sysdate);
INSERT INTO disease(dno, dname, cnt, rdate) VALUES(disease_seq.nextval, '피로', 0, sysdate);

-- READ: LIST
SELECT * FROM disease;
SELECT dno, dname, cnt, rdate, seqno, visible FROM disease ORDER BY dno ASC;

       DNO DNAME                                 CNT RDATE                    SEQNO V
---------- ------------------------------ ---------- ------------------- ---------- -
         1 감기                                    0 2023-12-07 01:49:19          1 N
         2 두통                                    0 2023-12-07 01:49:19          1 N
         3 소화불량                                0 2023-12-07 01:49:19          1 N
         4 피부질환                                0 2023-12-07 01:49:19          1 N
         5 비염                                    0 2023-12-07 01:49:19          1 N
         6 구강질환                                0 2023-12-07 01:49:19          1 N
         7 피로                                    0 2023-12-07 01:49:19          1 N

-- READ
SELECT dno, dname, cnt, rdate FROM disease WHERE dno=1;

       DNO DNAME                                 CNT RDATE              
---------- ------------------------------ ---------- -------------------
         1 감기                                    0 2023-12-07 01:49:19

-- UPDATE
UPDATE disease SET dname='다른질병', cnt=1 WHERE dno=1;

-- DELETE
DELETE FROM disease WHERE dno=1;

COMMIT;

-- COUNT
SELECT COUNT(*) as cnt FROM disease;

-- 우선 순위 높임, 10 등 -> 1 등
UPDATE disease SET seqno = seqno - 1 WHERE dno=1;
SELECT dno, dname, cnt, rdate, seqno FROM disease ORDER BY dno ASC;

-- 우선 순위 낮춤, 1 등 -> 10 등
UPDATE disease SET seqno = seqno + 1 WHERE dno=1;
SELECT dno, dname, cnt, rdate, seqno FROM disease ORDER BY dno ASC;

-- READ: LIST
SELECT dno, dname, cnt, rdate, seqno FROM disease ORDER BY dno ASC;

COMMIT;

-- 카테고리 공개 설정
UPDATE disease SET visible='Y' WHERE dno=1;
SELECT dno, dname, cnt, rdate, seqno, visible FROM disease ORDER BY dno ASC;

-- 카테고리 비공개 설정
UPDATE disease SET visible='N' WHERE dno=1;
SELECT dno, dname, cnt, rdate, seqno, visible FROM disease ORDER BY dno ASC;

COMMIT;

-- 비회원/회원 SELECT LIST, id: list_all_y
SELECT dno, dname, cnt, rdate, seqno, visible
FROM disease 
WHERE visible='Y'
ORDER BY seqno ASC;
         






