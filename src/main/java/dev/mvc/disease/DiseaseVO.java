package dev.mvc.disease;

//CREATE TABLE DISEASE(
//    DNO                           NUMBER(10)     NOT NULL PRIMARY KEY,
//    DNAME                             VARCHAR2(30)   NOT NULL,
//        CNT                               NUMBER(7)    DEFAULT 0 NOT NULL,
//    RDATE                             DATE         NOT NULL,
//        SEQNO                               NUMBER(5)        DEFAULT 1 NOT NULL,
//        VISIBLE                             CHAR(1)          DEFAULT 'N' NOT NULL
//);
public class DiseaseVO {
  private int dno;
  private String dname;
  private int cnt;
  private String rdate;
  private int seqno;
  private String visible;
  
  public int getCnt() {
    return cnt;
  }
  public void setCnt(int cnt) {
    this.cnt = cnt;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public String getVisible() {
    return visible;
  }
  public void setVisible(String visible) {
    this.visible = visible;
  }
  public int getDno() {
    return dno;
  }
  public void setDno(int dno) {
    this.dno = dno;
  }
  public String getDname() {
    return dname;
  }
  public void setDname(String dname) {
    this.dname = dname;
  }
  public int getSeqno() {
    return seqno;
  }
  public void setSeqno(int seqno) {
    this.seqno = seqno;
  }
  @Override
  public String toString() {
    return "DiseaseVO [dno=" + dno + ", dname=" + dname + ", cnt=" + cnt + ", rdate=" + rdate + ", seqno="
        + seqno + ", visible=" + visible + "]";
  }
  
  
}

