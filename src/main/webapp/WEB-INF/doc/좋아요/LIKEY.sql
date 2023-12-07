/**********************************/
/* Table Name: LIKEY */
/**********************************/
DROP TABLE LIKEY;

commit;

CREATE TABLE   LIKEY(
likeno number(10) NOT NULL,
memberno NUMBER(10) NOT NULL,
pill_no NUMBER(10) NOT NULL,
rdate DATE NOT NULL,    
PRIMARY KEY (likeno),
FOREIGN KEY(memberno) REFERENCES MEMBER(memberno),
FOREIGN KEY(pill_no) REFERENCES PILL(pill_no)
);

COMMENT ON TABLE LIKEY is '좋아요';
COMMENT ON COLUMN LIKEY.likeno is '좋아요 번호';
COMMENT ON COLUMN LIKEY.memberno is '회원 번호';
COMMENT ON COLUMN LIKEY.pill_no is '알약 번호';
COMMENT ON COLUMN LIKEY.rdate is '좋아요 날짜';

commit;