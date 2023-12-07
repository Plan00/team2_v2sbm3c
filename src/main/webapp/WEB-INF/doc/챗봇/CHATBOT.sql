/**********************************/
/* Table Name: CHATBOT */
/**********************************/
DROP TABLE CHATBOT;

commit;

CREATE TABLE   CHATBOT(
chatbot_no number(10) NOT NULL,
memberno NUMBER(10) NOT NULL,
PRIMARY KEY (chatbot_no),
FOREIGN KEY(memberno) REFERENCES MEMBER(memberno)
);

COMMENT ON TABLE CHATBOT is '챗봇';
COMMENT ON COLUMN CHATBOT.chatbot_no is '챗봇 번호';
COMMENT ON COLUMN CHATBOT.memberno is '회원 번호';

commit;