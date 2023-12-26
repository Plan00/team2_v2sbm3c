package dev.mvc.answer;

//CREATE TABLE ANSWER(
//ANO NUMBER(10) NOT NULL,
//QNA_NO NUMBER(10) NOT NULL,
//MANAGER_NO NUMBER(10) NOT NULL,
//AMAIN VARCHAR(4000) NOT NULL,
//ADATE DATE NOT NULL,
//PRIMARY KEY (ANO),
//FOREIGN KEY(QNA_NO) REFERENCES QNA(QNA_NO),
//FOREIGN KEY(MANAGER_NO) REFERENCES MANAGER(MANAGER_NO)
//);

public class AnswerVO {
  private int ano;
  private int qna_no;
  private int manager_no;
  private String amain;
  private String adate;
  public int getAno() {
    return ano;
  }
  public void setAno(int ano) {
    this.ano = ano;
  }
  public int getQna_no() {
    return qna_no;
  }
  public void setQna_no(int qna_no) {
    this.qna_no = qna_no;
  }
  public int getManager_no() {
    return manager_no;
  }
  public void setManager_no(int manager_no) {
    this.manager_no = manager_no;
  }
  public String getAmain() {
    return amain;
  }
  public void setAmain(String amain) {
    this.amain = amain;
  }
  public String getAdate() {
    return adate;
  }
  public void setAdate(String adate) {
    this.adate = adate;
  }
  @Override
  public String toString() {
    return "AnswerVO [ano=" + ano + ", qna_no=" + qna_no + ", manager_no=" + manager_no + ", amain=" + amain
        + ", adate=" + adate + "]";
  }
  
  
}
