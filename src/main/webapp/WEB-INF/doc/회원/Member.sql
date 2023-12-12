/**********************************/
/* Table Name: Member */
/**********************************/
DROP TABLE Member;

-- 제약 조건과 함께 삭제(제약 조건이 있어도 삭제됨, 권장하지 않음.)
DROP TABLE Member CASCADE CONSTRAINTS;

CREATE TABLE Member(
memberno NUMBER(10) NOT NULL,
id VARCHAR2(30) NOT NULL UNIQUE,
passwd VARCHAR2(30) NOT NULL,
mname VARCHAR2(30) NOT NULL,
tel VARCHAR(14) NOT NULL,
mdate DATE NOT NULL,
grade NUMBER(2)     NOT NULL,
PRIMARY KEY (memberno)
);

COMMENT ON TABLE Member is '회원';
COMMENT ON COLUMN Member.memberno is '회원 번호';
COMMENT ON COLUMN Member.id is '아이디';
COMMENT ON COLUMN Member.passwd is '패스워드';
COMMENT ON COLUMN Member.mname is '성명';
COMMENT ON COLUMN Member.tel is '전화번호';
COMMENT ON COLUMN Member.mdate is '가입일';
COMMENT ON COLUMN Member.grade is '등급';

commit;

DROP SEQUENCE member_seq;
CREATE SEQUENCE member_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  

1. 등록
 
1) id 중복 확인(null 값을 가지고 있으면 count에서 제외됨)
SELECT COUNT(id)
FROM member
WHERE id='user1';

SELECT COUNT(id) as cnt
FROM member
WHERE id='user1@gmail.com';

2) 등록
-- 개인 회원 테스트 계정
INSERT INTO member(memberno, id, passwd, mname, mdate, grade)
VALUES (mem_seq.nextval, 'user1@gmail.com', '1234', '왕눈이', sysdate, 1);

COMMIT;


2. 목록
- 검색을 하지 않는 경우, 전체 목록 출력

SELECT memberno, id, passwd, mname, mdate, grade
FROM member
ORDER BY memno ASC;

3. 조회
1) user1@gmail.com 회원 정보 보기
SELECT memberno, id, passwd, mname, mdate, grade
FROM member
WHERE memno = 1;

SELECT memberno, id, passwd, mname, mdate, grade
FROM member
WHERE memid = 'user1@gmail.com';


4. 수정
UPDATE member 
SET mname='아로미', grade=14
WHERE memberno=1;

COMMIT;


5. 삭제
1) 모두 삭제
DELETE FROM member;
 
2) 특정 회원 삭제
DELETE FROM member
WHERE memberno=15;

COMMIT;


6. 패스워드 변경
1) 패스워드 검사
SELECT COUNT(memberno) as cnt
FROM member
WHERE memberno=1 AND passwd='1234';
 
2) 패스워드 수정
UPDATE member
SET passwd='0000'
WHERE memberno=1;

COMMIT;
 
 
7. 로그인
SELECT COUNT(memberno) as cnt
FROM member
WHERE id='user1@gmail.com' AND passwd='1234';