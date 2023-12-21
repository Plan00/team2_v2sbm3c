package dev.mvc.mlogin;

//CREATE TABLE MLOGIN(
//mloginno NUMBER(10) NOT NULL,
//memberno NUMBER(10) NOT NULL,
//ip VARCHAR2(15) NOT NULL,
//ldate DATE NOT NULL,
//PRIMARY KEY (mloginno),
//FOREIGN KEY(memberno) REFERENCES MEMBER(memberno)
//);

public class MloginVO {
  private int mloginno;
  private int memberno;
  private String ip;
  private String ldate;
  public int getMloginno() {
    return mloginno;
  }
  public void setMloginno(int mloginno) {
    this.mloginno = mloginno;
  }
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  public String getIp() {
    return ip;
  }
  public void setIp(String ip) {
    this.ip = ip;
  }
  public String getLdate() {
    return ldate;
  }
  public void setLdate(String ldate) {
    this.ldate = ldate;
  }
  @Override
  public String toString() {
    return "MloginVO [mloginno=" + mloginno + ", memberno=" + memberno + ", ip=" + ip + ", ldate=" + ldate + "]";
  }
  
  
}
