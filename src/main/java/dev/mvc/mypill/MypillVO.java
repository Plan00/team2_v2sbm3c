package dev.mvc.mypill;

//CREATE TABLE MYPILL(
//mypill_no NUMBER(10) NOT NULL,
//memberno NUMBER(10) NOT NULL,
//pill_no NUMBER(10) NOT NULL,
//mypill_name VARCHAR2(30) NOT NULL,
//mypill_date DATE NOT NULL,
//PRIMARY KEY (mypill_no),
//FOREIGN KEY(memberno) REFERENCES MEMBER(memberno),
//FOREIGN KEY(pill_no) REFERENCES PILL(pill_no)
//);

// mypill_no, memberno, pill_no, mypill_name, mypill_date

public class MypillVO {
  private int mypill_no;
  private int memberno;
  private int pill_no;
  private String mypill_name = "";
  private String mypill_date = "";
  
  public int getMypill_no() {
    return mypill_no;
  }
  public void setMypill_no(int mypill_no) {
    this.mypill_no = mypill_no;
  }
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  public int getPill_no() {
    return pill_no;
  }
  public void setPill_no(int pill_no) {
    this.pill_no = pill_no;
  }
  public String getMypill_name() {
    return mypill_name;
  }
  public void setMypill_name(String mypill_name) {
    this.mypill_name = mypill_name;
  }
  public String getMypill_date() {
    return mypill_date;
  }
  public void setMypill_date(String mypill_date) {
    this.mypill_date = mypill_date;
  }
  @Override
  public String toString() {
    return "MypillVO [mypill_no=" + mypill_no + ", memberno=" + memberno + ", pill_no=" + pill_no + ", mypill_name="
        + mypill_name + ", mypill_date=" + mypill_date + "]";
  }
  
  
}
