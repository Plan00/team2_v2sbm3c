package dev.mvc.member;

//CREATE TABLE Member(
//memberno NUMBER(10) NOT NULL,
//id VARCHAR2(30) NOT NULL UNIQUE,
//passwd VARCHAR2(30) NOT NULL,
//mname VARCHAR2(30)NOT NULL,
//tel VARCHAR(14) NOT NULL,
//mdate DATE NOT NULL,
//grade NUMBER(2)     NOT NULL,
//PRIMARY KEY (memberno)
//);

public class MemberVO {
  private int memberno;
  private String id = "";
  private String passwd = "";
  private String mname = "";
  private String tel = "";
  private String mdate = "";
  private int grade = 0;
  
  /** 등록된 패스워드 */
  private String old_passwd = "";
  /** id 저장 여부 */
  private String id_save = "";
  /** passwd 저장 여부 */
  private String passwd_save = "";
  /** 이동할 주소 저장 */
  private String url_address = "";
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getPasswd() {
    return passwd;
  }
  public void setPasswd(String passwd) {
    this.passwd = passwd;
  }
  public String getMname() {
    return mname;
  }
  public void setMname(String mname) {
    this.mname = mname;
  }
  public String getMdate() {
    return mdate;
  }
  public void setMdate(String mdate) {
    this.mdate = mdate;
  }
  public int getGrade() {
    return grade;
  }
  public void setGrade(int grade) {
    this.grade = grade;
  }
  public String getOld_passwd() {
    return old_passwd;
  }
  public void setOld_passwd(String old_passwd) {
    this.old_passwd = old_passwd;
  }
  public String getId_save() {
    return id_save;
  }
  public void setId_save(String id_save) {
    this.id_save = id_save;
  }
  public String getPasswd_save() {
    return passwd_save;
  }
  public void setPasswd_save(String passwd_save) {
    this.passwd_save = passwd_save;
  }
  public String getUrl_address() {
    return url_address;
  }
  public void setUrl_address(String url_address) {
    this.url_address = url_address;
  }
  @Override
  public String toString() {
    return "MemberVO [memberno=" + memberno + ", id=" + id + ", passwd=" + passwd + ", mname=" + mname + ", mdate="
        + mdate + ", grade=" + grade + ", old_passwd=" + old_passwd + ", id_save=" + id_save + ", passwd_save="
        + passwd_save + ", url_address=" + url_address + "]";
  }
  public String getTel() {
    return tel;
  }
  public void setTel(String tel) {
    this.tel = tel;
  }
}
