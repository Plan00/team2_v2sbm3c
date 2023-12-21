package dev.mvc.manlogin;

//CREATE TABLE MANLOGIN(
//    manloginno                    NUMBER(10) NOT NULL PRIMARY KEY,
//    manager_no                  NUMBER(10) NOT NULL,
//    ip                            VARCHAR2(15) NOT NULL,
//    ldate                  DATE NOT NULL,
//    FOREIGN KEY (manager_no) REFERENCES MANAGER(manager_no)
//  );

public class ManloginVO {
  private int manloginno;
  private int manager_no;
  private String ip;
  private String ldate;
  public int getManloginno() {
    return manloginno;
  }
  public void setManloginno(int manloginno) {
    this.manloginno = manloginno;
  }
  public int getManager_no() {
    return manager_no;
  }
  public void setManager_no(int manager_no) {
    this.manager_no = manager_no;
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
    return "ManloginVO [manloginno=" + manloginno + ", manager_no=" + manager_no + ", ip=" + ip + ", ldate=" + ldate
        + "]";
  }
  
  
}
