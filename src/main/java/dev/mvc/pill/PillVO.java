package dev.mvc.pill;

import org.springframework.web.multipart.MultipartFile;

//CREATE TABLE PILL(
//PILL_NO NUMBER(10) NOT NULL,
//DNO NUMBER(10) NOT NULL,
//MANAGER_NO NUMBER(10) NOT NULL,
//PILL_NAME VARCHAR(30),
//VIEWS   NUMBER(7) DEFAULT 0 NOT NULL,
//PASSWD VARCHAR2(15)         NOT NULL,
//SEARCH VARCHAR2(50) NULL ,
//RDATE DATE NOT NULL,
//FILE1 VARCHAR(100) NULL,
//FILE1SAVED VARCHAR(100) NULL,
//THUMB1 VARCHAR2(100) NULL,
//SIZE1 NUMBER(10),
//EFFICACY VARCHAR2(2000),
//SIDE VARCHAR2(2000),
//PRIMARY KEY (PILL_NO),
//FOREIGN KEY(DNO) REFERENCES DISEASE(DNO),
//FOREIGN KEY(MANAGER_NO) REFERENCES MANAGER(MANAGER_NO)
//);

public class PillVO {
  private int pill_no;
  private int dno;
  private int manager_no;
  private String pill_name = "";
  private int views;
  private String passwd = "";
  private String search = "";
  private String rdate = "";
  private String efficacy = "";
  private String side = "";

  
  // 파일 업로드 관련
  private MultipartFile file1MF;
  private String size1_label = "";
  private String file1;
  private String file1saved;
  private String thumb1;
  private long size1;
  
  // 페이징 관련
  /** 시작 rownum */
  private int start_num;    
  /** 종료 rownum */
  private int end_num;    
  /** 현재 페이지 */
  private int now_page = 1;
  public int getPill_no() {
    return pill_no;
  }
  public void setPill_no(int pill_no) {
    this.pill_no = pill_no;
  }
  public int getDno() {
    return dno;
  }
  public void setDno(int dno) {
    this.dno = dno;
  }
  public int getManager_no() {
    return manager_no;
  }
  public void setManager_no(int manager_no) {
    this.manager_no = manager_no;
  }
  public String getPill_name() {
    return pill_name;
  }
  public void setPill_name(String pill_name) {
    this.pill_name = pill_name;
  }
  public int getViews() {
    return views;
  }
  public void setViews(int views) {
    this.views = views;
  }
  public String getEfficacy() {
    return efficacy;
  }
  public void setEfficacy(String efficacy) {
    this.efficacy = efficacy;
  }
  public String getSide() {
    return side;
  }
  public void setSide(String side) {
    this.side = side;
  }
  public MultipartFile getFile1MF() {
    return file1MF;
  }
  public void setFile1MF(MultipartFile file1mf) {
    file1MF = file1mf;
  }
  public String getFile1() {
    return file1;
  }
  public void setFile1(String file1) {
    this.file1 = file1;
  }
  public String getFile1saved() {
    return file1saved;
  }
  public void setFile1saved(String file1saved) {
    this.file1saved = file1saved;
  }
  public String getThumb1() {
    return thumb1;
  }
  public void setThumb1(String thumb1) {
    this.thumb1 = thumb1;
  }
  public long getSize1() {
    return size1;
  }
  public void setSize1(long size1) {
    this.size1 = size1;
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
  public String getSize1_label() {
    return size1_label;
  }
  public void setSize1_label(String size1_label) {
    this.size1_label = size1_label;
  }
  public String getSearch() {
    return search;
  }
  public void setSearch(String search) {
    this.search = search;
  }
  public String getPasswd() {
    return passwd;
  }
  public void setPasswd(String passwd) {
    this.passwd = passwd;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  
  @Override
  public String toString() {
    return "PillVO [pill_no=" + pill_no + ", dno=" + dno + ", manager_no=" + manager_no + ", pill_name=" + pill_name
        + ", views=" + views + ", efficacy=" + efficacy + ", side=" + side + ", file1MF=" + file1MF + ", file1=" + file1
        + ", file1saved=" + file1saved + ", thumb1=" + thumb1 + ", size1=" + size1 + ", start_num=" + start_num
        + ", end_num=" + end_num + ", now_page=" + now_page + "]";
  }
}
