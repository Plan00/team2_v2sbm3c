/**********************************/
/* Table Name: PILL */
/**********************************/
DROP TABLE PILL;

commit;

CREATE TABLE PILL(
PILL_NO NUMBER(10) NOT NULL,
DNO NUMBER(10) NOT NULL,
MANAGER_NO NUMBER(10) NOT NULL,
PILL_NAME VARCHAR(30),
VIEWS   NUMBER(7) DEFAULT 0 NOT NULL,
PASSWD VARCHAR2(15)         NOT NULL,
SEARCH VARCHAR2(50) NULL ,
RDATE DATE NOT NULL,
FILE1 VARCHAR(100) NULL,
FILE1SAVED VARCHAR(100) NULL,
THUMB1 VARCHAR2(100) NULL,
SIZE1 NUMBER(10),
EFFICACY VARCHAR2(2000),
SIDE VARCHAR2(2000),
PRIMARY KEY (PILL_NO),
FOREIGN KEY(DNO) REFERENCES DISEASE(DNO),
FOREIGN KEY(MANAGER_NO) REFERENCES MANAGER(MANAGER_NO)
);

COMMENT ON TABLE PILL is '알약';
COMMENT ON COLUMN PILL.PILL_NO is '알약 번호';
COMMENT ON COLUMN PILL.DNO is '질병 번호';
COMMENT ON COLUMN PILL.MANAGER_NO is '관리자 번호';
COMMENT ON COLUMN PILL.PILL_NAME is '품목명';
COMMENT ON COLUMN PILL.VIEWS is '조회수';
COMMENT ON COLUMN PILL.PASSWD is '비밀번호';
COMMENT ON COLUMN PILL.SEARCH is '검색어';
COMMENT ON COLUMN PILL.RDATE is '등록일';
COMMENT ON COLUMN PILL.FILE1 is '메인 이미지';
COMMENT ON COLUMN PILL.FILE1SAVED is '실제 저장된 메인 이미지';
COMMENT ON COLUMN PILL.THUMB1 is '메인 이미지 Preview';
COMMENT ON COLUMN PILL.SIZE1 is '메인 이미지 크기';
COMMENT ON COLUMN PILL.EFFICACY is '효과';
COMMENT ON COLUMN PILL.SIDE is '부작용';

commit;

DROP SEQUENCE PILL_SEQ;

CREATE SEQUENCE PILL_SEQ
  START WITH 1         -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2              -- 2번은 메모리에서만 계산
  NOCYCLE;             -- 다시 1부터 생성되는 것을 방지


-- 등록 화면 유형 1: 글 등록
INSERT INTO pill(pill_no, MANAGER_NO, dno, pill_name, views, file1, file1saved, thumb1, size1, efficacy, side)
VALUES(pill_seq.nextval, 1, 1, '판피린', '판피린.jpg', '판피린_1.jpg', '판피린_t.jpg', 1000,
       '감기 완화', '두드러기');

-- 유형 1 전체 목록
SELECT pill_no, MANAGER_NO, dno, pill_name, views, file1, file1saved, thumb1, size1, efficacy, side
FROM pill
ORDER BY  DESC;

-- 유형 2 카테고리별 목록
INSERT INTO pill(pill_no, MANAGER_NO, dno, pill_name, views, file1, file1saved, thumb1, size1, efficacy, side)
VALUES(pill_seq.nextval, 1, 2, '타이레놀', '타이레놀.jpg', '타이레놀_1.jpg', '타이레놀_t.jpg', 1000,
       '두통 완화', '복통');

-- 1번 dno 만 출력
SELECT pill_no, MANAGER_NO, dno, pill_name, views, file1, file1saved, thumb1, size1, efficacy, side
FROM pill
WHERE dno=1
ORDER BY  DESC;

-- 모든 레코드 삭제
DELETE FROM pill;
commit;

-- 삭제
DELETE FROM pill
WHERE  = 25;
commit;

DELETE FROM pill
WHERE dno=12 AND  <= 41;

commit;


-- ----------------------------------------------------------------------------------------------------
-- 검색, dno별 검색 목록
-- ----------------------------------------------------------------------------------------------------
-- 모든글
SELECT pill_no, MANAGER_NO, dno, pill_name, views, file1, file1saved, thumb1, size1, efficacy, side
FROM pill
ORDER BY pill_no ASC;

-- 카테고리별 목록
SELECT pill_no, MANAGER_NO, dno, pill_name, views, file1, file1saved, thumb1, size1, efficacy, side
FROM pill
WHERE dno=2
ORDER BY pill_no ASC;

-- 1) 검색
-- ① dno별 검색 목록
SELECT pill_no, MANAGER_NO, dno, pill_name, views, file1, file1saved, thumb1, size1, efficacy, side
FROM pill
WHERE dno=1 AND (pill_name LIKE '%타이레놀%' OR efficacy LIKE '%타이레놀%' OR side LIKE '%타이레놀%')
ORDER BY pill_no DESC;

-- ② 검색 레코드 갯수
-- 전체 레코드 갯수, 집계 함수
SELECT COUNT(*)
FROM pill
WHERE dno=1;
         
SELECT COUNT(*) as views -- 함수 사용시는 컬럼 별명을 선언하는 것을 권장
FROM pill
WHERE dno=1;

-- dno 별 검색된 레코드 갯수
SELECT COUNT(*) as views
FROM pill
WHERE dno=8 AND side LIKE '%타이레놀%';

SELECT COUNT(*) as views
FROM pill
WHERE dno=8 AND (pill_name LIKE '%타이레놀%' OR efficacy LIKE '%타이레놀%' OR side LIKE '%타이레놀%');

-- SUBSTR(컬럼명, 시작 index(1부터 시작), 길이), 부분 문자열 추출
SELECT pill_no, SUBSTR(pill_name, 1, 4) as pill_name
FROM pill
WHERE dno=1 AND (efficacy LIKE '%인공%');

   ISSUENO ITIT
---------- ----
         3 타이레놀
         4 [202

-- SQL은 대소문자를 구분하지 않으나 WHERE문에 명시하는 값은 대소문자를 구분하여 검색
SELECT pill_no, pill_name, side
FROM pill
WHERE dno=2 AND (side LIKE '%CLOUD COMPUTING%');

   ISSUENO ITITLE                                                                                               ISEARCH                                           
---------- ---------------------------------------------------------------------------------------------------- --------------------------------------------------
         6 CLOUD COMPUTING

SELECT pill_no, pill_name, side
FROM pill
WHERE dno=2 AND (side LIKE '%cloud computing%'); 

   ISSUENO ITITLE                                                                                               ISEARCH                                           
---------- ---------------------------------------------------------------------------------------------------- --------------------------------------------------
         7 cloud computing

SELECT pill_no, pill_name, side
FROM pill
WHERE dno=2 AND (LOWER(side) LIKE '%cloud computing%'); -- 대소문자를 일치 시켜서 검색

-- ||: 문자열 연결
-- LIKE '%' || UPPER('cloud computing') || LIKE '%' -> %cloud computing%
SELECT pill_no, pill_name, side
FROM pill
WHERE dno=2 AND (UPPER(side) LIKE '%' || UPPER('cloud computing') || '%'); -- 대소문자를 일치 시켜서 검색 ★

SELECT pill_no, pill_name, side
FROM pill
WHERE dno=2 AND (LOWER(side) LIKE '%' || LOWER('cloud computing') || '%'); -- 대소문자를 일치 시켜서 검색

SELECT pill_no || '. ' || pill_name || ' 태그: ' || side as pill_name -- 컬럼의 결합, ||
FROM pill
WHERE dno=2 AND (LOWER(side) LIKE '%' || LOWER('cloud computing') || '%'); -- 대소문자를 일치 시켜서 검색


SELECT UPPER('한글') FROM dual; -- dual: 오라클에서 SQL 형식을 맞추기위한 시스템 테이블

-- ----------------------------------------------------------------------------------------------------
-- 검색 + 페이징 + 메인 이미지
-- ----------------------------------------------------------------------------------------------------
-- step 1
SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
           ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube
FROM pill
WHERE dno=1 AND (pill_name LIKE '%TTS%' OR efficacy LIKE '%TTS%' OR side LIKE '%TTS%')
ORDER BY pill_no DESC;

-- step 2
SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
           ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube, rownum as r
FROM (
          SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
                     ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube
          FROM pill
          WHERE dno=1 AND (pill_name LIKE '%TTS%' OR efficacy LIKE '%TTS%' OR side LIKE '%TTS%')
          ORDER BY pill_no DESC
);

-- step 3, 1 page
SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
           ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube, r
FROM (
           SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
                      ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube, rownum as r
           FROM (
                     SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
                                ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube
                     FROM pill
                     WHERE dno=1 AND (pill_name LIKE '%TTS%' OR efficacy LIKE '%TTS%' OR side LIKE '%TTS%')
                     ORDER BY pill_no DESC
           )          
)
WHERE r >= 1 AND r <= 3;

-- step 3, 2 page
SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
           ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube, r
FROM (
           SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
                      ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube, rownum as r
           FROM (
                     SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
                                ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube
                     FROM pill
                     WHERE dno=1 AND (pill_name LIKE '%TTS%' OR efficacy LIKE '%TTS%' OR side LIKE '%TTS%')
                     ORDER BY pill_no DESC
           )          
)
WHERE r >= 4 AND r <= 6;

-- 대소문자를 처리하는 페이징 쿼리
SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
           ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube, r
FROM (
           SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
                      ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube, rownum as r
           FROM (
                     SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
                                ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube
                     FROM pill
                     WHERE dno=1 AND (UPPER(pill_name) LIKE '%' || UPPER('단풍') || '%' 
                                         OR UPPER(efficacy) LIKE '%' || UPPER('단풍') || '%' 
                                         OR UPPER(side) LIKE '%' || UPPER('단풍') || '%')
                     ORDER BY pill_no DESC
           )          
)
WHERE r >= 1 AND r <= 3;

-- ----------------------------------------------------------------------------
-- 조회
-- ----------------------------------------------------------------------------
SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, ipasswd, side, irdate,
           ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube
FROM pill
WHERE pill_no = 1;

-- ----------------------------------------------------------------------------
-- 다음 지도, MAP, 먼저 레코드가 등록되어 있어야함.
-- imap                                   VARCHAR2(1000)         NULL ,
-- ----------------------------------------------------------------------------
-- MAP 등록/수정
UPDATE pill SET imap='카페산 지도 스크립트' WHERE pill_no=1;

-- MAP 삭제
UPDATE pill SET imap='' WHERE pill_no=1;

commit;

-- ----------------------------------------------------------------------------
-- Youtube, 먼저 레코드가 등록되어 있어야함.
-- iyoutube                                   VARCHAR2(1000)         NULL ,
-- ----------------------------------------------------------------------------
-- iyoutube 등록/수정
UPDATE pill SET iyoutube='Youtube 스크립트' WHERE pill_no=1;

-- iyoutube 삭제
UPDATE pill SET iyoutube='' WHERE pill_no=1;

commit;

-- 패스워드 검사, id="passside_check"
SELECT COUNT(*) as views 
FROM pill
WHERE pill_no=1 AND ipasswd='123';

-- ----------------------------------------------------------------------------
-- 글 수정
-- ----------------------------------------------------------------------------

-- 텍스트 수정: 예외 컬럼: 추천수, 조회수, 댓글 수
UPDATE pill
SET pill_name='타이레놀', efficacy='타이레놀 시대',  side='타이레놀,ai'
WHERE pill_no = 2;

-- ERROR, " 사용 에러
UPDATE pill
SET pill_name='타이레놀', efficacy="타이레놀 '시대'",  side='나,기차,생각'
WHERE pill_no = 1;

-- ERROR, \' 에러
UPDATE pill
SET pill_name='기차를 타고', efficacy='계획없이 \'여행\' 출발',  side='나,기차,생각'
WHERE pill_no = 1;

-- SUCCESS, '' 한번 ' 출력됨.
UPDATE pill
SET pill_name='기차를 타고', efficacy='계획없이 ''여행'' 출발',  side='나,기차,생각'
WHERE pill_no = 1;

-- SUCCESS
UPDATE pill
SET pill_name='기차를 타고', efficacy='계획없이 "여행" 출발',  side='나,기차,생각'
WHERE pill_no = 1;

commit;

-- ----------------------------------------------------------------------------
-- 파일 수정
-- ----------------------------------------------------------------------------
-- ifile1 메인 이미지, 원본 파일명
-- ifile1saved 실제 저장된 메인 이미지 또는 파일명
-- ithumb1 메인 이미지 preview
-- isize1 메인 이미지 크기, 파일 크기
UPDATE pill
SET ifile1='train.jpg', ifile1saved='train.jpg', ithumb1='train_t.jpg', isize1=5000
WHERE pill_no = 1;

-- 삭제
DELETE FROM pill
WHERE pill_no = 42;

commit;

DELETE FROM pill
WHERE pill_no >= 7;

commit;

-- 추천
UPDATE pill
SET irecom = irecom + 1
WHERE pill_no = 1;

-- dno FK 특정 그룹에 속한 레코드 갯수 산출
SELECT COUNT(*) as views 
FROM pill 
WHERE dno=1;

-- mno FK 특정 관리자에 속한 레코드 갯수 산출
SELECT COUNT(*) as views 
FROM pill 
WHERE mno=1;

-- dno FK 특정 그룹에 속한 레코드 모두 삭제
DELETE FROM pill
WHERE dno=1;

-- mno FK 특정 관리자에 속한 레코드 모두 삭제
DELETE FROM pill
WHERE mno=1;

commit;

-- 다수의 카테고리에 속한 레코드 갯수 산출: IN
SELECT COUNT(*) as views
FROM pill
WHERE dno IN(1,2,3);

-- 다수의 카테고리에 속한 레코드 모두 삭제: IN
SELECT pill_no, mno, dno, pill_name
FROM pill
WHERE dno IN(1,2,3);

CONTENTSNO    ADMINNO     CATENO TITLE                                                                                                                                                                                                                                                                                                       
---------- ---------- ---------- ------------------------
         3             1                   1           인터스텔라                                                                                                                                                                                                                                                                                                  
         4             1                   2           드라마                                                                                                                                                                                                                                                                                                      
         5             1                   3           컨저링                                                                                                                                                                                                                                                                                                      
         6             1                   1           마션       
         
SELECT pill_no, mno, dno, pill_name
FROM pill
WHERE dno IN('1','2','3');

CONTENTSNO    ADMINNO     CATENO TITLE                                                                                                                                                                                                                                                                                                       
---------- ---------- ---------- ------------------------
         3             1                   1           인터스텔라                                                                                                                                                                                                                                                                                                  
         4             1                   2           드라마                                                                                                                                                                                                                                                                                                      
         5             1                   3           컨저링                                                                                                                                                                                                                                                                                                      
         6             1                   1           마션       
         
-- FK 컬럼별 삭제: 1번 카테고리 모두 삭제
DELETE FROM pill
WHERE dno=1;

-- 1번 관리자가 작성한 글 모두 삭제
DELETE FROM pill
WHERE mno=1;

-- ----------------------------------------------------------------------------------------------------
-- tech + pill INNER JOIN
-- ----------------------------------------------------------------------------------------------------
-- 모든글
SELECT c.name,
       t.pill_no, t.mno, t.dno, t.pill_name, t.efficacy, t.irecom, t.views, t.ireplycnt, t.side, t.irdate,
       t.ifile1, t.ifile1saved, t.ithumb1, t.isize1, t.imap, t.iyoutube
FROM tech c, pill t
WHERE c.dno = t.dno
ORDER BY t.pill_no DESC;

-- pill, manager INNER JOIN
SELECT t.pill_no, t.mno, t.dno, t.pill_name, t.efficacy, t.irecom, t.views, t.ireplycnt, t.side, t.irdate,
       t.ifile1, t.ifile1saved, t.ithumb1, t.isize1, t.imap, t.iyoutube,
       a.mname
FROM manager a, pill t
WHERE a.mno = t.mno
ORDER BY t.pill_no DESC;

SELECT t.pill_no, t.mno, t.dno, t.pill_name, t.efficacy, t.irecom, t.views, t.ireplycnt, t.side, t.irdate,
       t.ifile1, t.ifile1saved, t.ithumb1, t.isize1, t.imap, t.iyoutube,
       a.mname
FROM manager a INNER JOIN pill t ON a.mno = t.mno
ORDER BY t.pill_no DESC;

-- ----------------------------------------------------------------------------------------------------
-- View + paging
-- ----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW vissue
AS
SELECT pill_no, MANAGER_NO, dno, pill_name, views, file1, file1saved, thumb1, size1, efficacy, side
        ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube
FROM pill
ORDER BY pill_no DESC;
                     
-- 1 page
SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
       ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube, r
FROM (
     SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
            ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube, rownum as r
     FROM vissue -- View
     WHERE dno=14 AND (pill_name LIKE '%야경%' OR efficacy LIKE '%야경%' OR side LIKE '%야경%')
)
WHERE r >= 1 AND r <= 3;

-- 2 page
SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
       ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube, r
FROM (
     SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
            ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube, rownum as r
     FROM vissue -- View
     WHERE dno=14 AND (pill_name LIKE '%야경%' OR efficacy LIKE '%야경%' OR side LIKE '%야경%')
)
WHERE r >= 4 AND r <= 6;


-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 좋아요(irecom) 기준, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT pill_no, mno, dno, pill_name, ithumb1, r
FROM (
           SELECT pill_no, mno, dno, pill_name, ithumb1, rownum as r
           FROM (
                     SELECT pill_no, mno, dno, pill_name, ithumb1
                     FROM pill
                     WHERE dno=1
                     ORDER BY irecom DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 평점(score) 기준, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
           ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube, r
FROM (
           SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
                      ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube, rownum as r
           FROM (
                     SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
                                ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube
                     FROM pill
                     WHERE dno=1
                     ORDER BY score DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 최신 상품 기준, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
           ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube, r
FROM (
           SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
                      ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube, rownum as r
           FROM (
                     SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
                                ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube
                     FROM pill
                     WHERE dno=1
                     ORDER BY irdate DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 조회수 높은 상품기준, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
           ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube, r
FROM (
           SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
                      ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube, rownum as r
           FROM (
                     SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
                                ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube
                     FROM pill
                     WHERE dno=1
                     ORDER BY views DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 낮은 가격 상품 추천, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
           ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube, r
FROM (
           SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
                      ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube, rownum as r
           FROM (
                     SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
                                ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube
                     FROM pill
                     WHERE dno=1
                     ORDER BY iprice ASC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 높은 가격 상품 추천, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
           ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube, r
FROM (
           SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
                      ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube, rownum as r
           FROM (
                     SELECT pill_no, mno, dno, pill_name, efficacy, irecom, views, ireplycnt, irdate,
                                ifile1, ifile1saved, ithumb1, isize1, imap, iyoutube
                     FROM pill
                     WHERE dno=1
                     ORDER BY iprice DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- 컬럼의 속성 변경
ALTER TABLE pill
MODIFY(pill_name VARCHAR(100));



















































