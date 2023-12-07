/**********************************/
/* Table Name: EFFICACY */
/**********************************/
DROP TABLE EFFICACY;

commit;

CREATE TABLE EFFICACY(
EFFICACY_No number(10) PRIMARY KEY,
efficacy_main varchar2(2000) NOT NULL
);

COMMENT ON TABLE EFFICACY is '효과';
COMMENT ON COLUMN EFFICACY.EFFICACY_No is '효과 번호';
COMMENT ON COLUMN EFFICACY.efficacy_main is '효과 설명';

DROP SEQUENCE EFFICACY_SEQ;

CREATE SEQUENCE EFFICACY_SEQ
  START WITH 1         -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2              -- 2번은 메모리에서만 계산
  NOCYCLE;             -- 다시 1부터 생성되는 것을 방지

-- CREATE
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '통증완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '해열');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '관절증 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '감염증 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '알레르기 예방');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '코막힘 증상 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '비염 증상 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '두통 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '생리통 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '위장 점막 손상 방지');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '위산  분비 억제');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '치은염 보조 치료');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '잇몸의 발적(충열되어 붉어짐)완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '잇몸 부어오름 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '잇몸의 구취 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '근육통 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '가래 증상 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '오한 증상 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '인후통 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '기침 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '알레르기성 비염 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '결막염 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '피부염 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '만성두드러기 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '어깨 걸림 증상 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '수족 냉증 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '습진 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '피부소양증 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '양진 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '벌레 물린곳 치료');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '습진 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '땀띠 완화');
INSERT INTO EFFICACY (EFFICACY_NO, EFFICACY_MAIN) VALUES (efficacy_seq.nextval, '육체 피로 완화');

COMMIT;