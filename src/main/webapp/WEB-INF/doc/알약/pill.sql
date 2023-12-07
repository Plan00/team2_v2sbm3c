/**********************************/
/* Table Name: PILL */
/**********************************/
DROP TABLE PILL;

commit;

CREATE TABLE PILL(
PILL_NO NUMBER(10) NOT NULL,
DNO NUMBER(10) NOT NULL,
PILL_NAME VARCHAR(30),
FILE1 VARCHAR(50),
FILE1SAVED VARCHAR(50),
THUMB1 VARCHAR2(50),
SIZE1 NUMBER(10),
EFFICACY VARCHAR2(2000),
SIDE VARCHAR2(2000),
PRIMARY KEY (pill_no),
FOREIGN KEY(DNO) REFERENCES DISEASE(DNO)
);

COMMENT ON TABLE PILL is '알약';
COMMENT ON COLUMN PILL.PILL_NO is '알약 번호';
COMMENT ON COLUMN PILL.DNO is '질병 번호';
COMMENT ON COLUMN PILL.PILL_NAME is '품목명';
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

-- 이 밑으로는 아직 수정 못함

-- 등록 화면 유형 1: 커뮤니티(공지사항, 게시판, 자료실, 갤러리,  Q/A...)글 등록
INSERT INTO issue(pill_no, dno, pill_name, file1, file1saved, thumb1, size1, efficacy, side)
VALUES(issue_seq.nextval, 1, 1, '타이레놀', '구글, 오픈AI 각각 연내 멀티모달 AI 공개 목표', 0, 0, 0, '123',
       '멀티모달', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);