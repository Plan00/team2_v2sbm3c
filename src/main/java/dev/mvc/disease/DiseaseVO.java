package dev.mvc.disease;

//CREATE TABLE DISEASE(
//    DNO                           NUMBER(10)     NOT NULL PRIMARY KEY,
//    DNAME                             VARCHAR2(30)   NOT NULL
//);
public class DiseaseVO {
  private int dno;
  private String dname;
  
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
  @Override
  public String toString() {
    return "DiseaseVO [dno=" + dno + ", dname=" + dname + "]";
  }
  
}

