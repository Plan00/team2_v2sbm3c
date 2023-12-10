package dev.mvc.manager;

//CREATE TABLE   MANAGER(
//MANAGER_NO number(10) NOT NULL,
//MANAGER_ID VARCHAR2(30) NOT NULL,
//MANAGER_PASSWD VARCHAR2(60) NOT NULL,
//MANAGER_NAME VARCHAR2(30) NOT NULL,
//MANAGER_DATE DATE NOT NULL,
//MANAGER_GRADE NUMBER(2)     NOT NULL,
//PRIMARY KEY (manager_no)
//);

public class ManagerVO {
  private int manager_no;
  private String manager_id;
  private String manager_passwd;
  private String manager_name;
  private String manager_date;
  private int manager_grade;
  public int getManager_no() {
    return manager_no;
  }
  public void setManager_no(int manager_no) {
    this.manager_no = manager_no;
  }
  public String getManager_id() {
    return manager_id;
  }
  public void setManager_id(String manager_id) {
    this.manager_id = manager_id;
  }
  public String getManager_passwd() {
    return manager_passwd;
  }
  public void setManager_passwd(String manager_passwd) {
    this.manager_passwd = manager_passwd;
  }
  public String getManager_name() {
    return manager_name;
  }
  public void setManager_name(String manager_name) {
    this.manager_name = manager_name;
  }
  public String getManager_date() {
    return manager_date;
  }
  public void setManager_date(String manager_date) {
    this.manager_date = manager_date;
  }
  public int getManager_grade() {
    return manager_grade;
  }
  public void setManager_grade(int manager_grade) {
    this.manager_grade = manager_grade;
  }
  @Override
  public String toString() {
    return "ManagerVO [manager_no=" + manager_no + ", manager_id=" + manager_id + ", manager_passwd=" + manager_passwd
        + ", manager_name=" + manager_name + ", manager_date=" + manager_date + ", manager_grade=" + manager_grade
        + "]";
  }
  
  
}
