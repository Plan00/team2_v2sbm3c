package dev.mvc.qna;

//CREATE TABLE QNA(
//qna_no NUMBER(10) NOT NULL,
//memberno NUMBER(10) NOT NULL,
//qna_title VARCHAR2(100) NOT NULL,
//qna_main VARCHAR2(4000) NOT NULL,
//qna_passwd VARCHAR2(60) NOT NULL,
//qna_date DATE NOT NULL,
//views NUMBER(7) DEFAULT 0 NOT NULL,
//PRIMARY KEY (qna_no),
//FOREIGN KEY(memberno) REFERENCES Member(memberno)
//);

public class QnaVO {
  private int qna_no;
  private int memberno;
  private String qna_title;
  private String qna_main;
  private String qna_passwd;
  private String qna_date;
  private int views;
  
  //페이징 관련
  /** 시작 rownum */
  private int start_num;    
  /** 종료 rownum */
  private int end_num;    
  /** 현재 페이지 */
  private int now_page = 1;
  public int getQna_no() {
    return qna_no;
  }
  public void setQna_no(int qna_no) {
    this.qna_no = qna_no;
  }
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  public String getQna_title() {
    return qna_title;
  }
  public void setQna_title(String qna_title) {
    this.qna_title = qna_title;
  }
  public String getQna_main() {
    return qna_main;
  }
  public void setQna_main(String qna_main) {
    this.qna_main = qna_main;
  }
  public String getQna_passwd() {
    return qna_passwd;
  }
  public void setQna_passwd(String qna_passwd) {
    this.qna_passwd = qna_passwd;
  }
  public String getQna_date() {
    return qna_date;
  }
  public void setQna_date(String qna_date) {
    this.qna_date = qna_date;
  }
  public int getViews() {
    return views;
  }
  public void setViews(int views) {
    this.views = views;
  }
  public int getStart_num() {
    return start_num;
  }
  public void setStart_num(int start_num) {
    this.start_num = start_num;
  }
  public int getEnd_num() {
    return end_num;
  }
  public void setEnd_num(int end_num) {
    this.end_num = end_num;
  }
  public int getNow_page() {
    return now_page;
  }
  public void setNow_page(int now_page) {
    this.now_page = now_page;
  }
  @Override
  public String toString() {
    return "QnaVO [qna_no=" + qna_no + ", memberno=" + memberno + ", qna_title=" + qna_title + ", qna_main=" + qna_main
        + ", qna_passwd=" + qna_passwd + ", qna_date=" + qna_date + ", views=" + views + ", start_num=" + start_num
        + ", end_num=" + end_num + ", now_page=" + now_page + "]";
  }
  
  
}
