package dev.mvc.answer;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.answer.AnswerProc")
public class AnswerProc implements AnswerProcInter {
  @Autowired
  private AnswerDAOInter answerDAO;

  @Override
  public int create(AnswerVO answerVO) {
    int cnt = this.answerDAO.create(answerVO);
    return cnt;
  }

  @Override
  public ArrayList<AnswerVO> list_all() {
    ArrayList<AnswerVO> list = this.answerDAO.list_all();
    return list;
  }
  
  @Override
  public AnswerVO read_by_qna_no(int qna_no) {
    AnswerVO answerVO = this.answerDAO.read_by_qna_no(qna_no);
    return answerVO;
  }

  @Override
  public AnswerVO read(int ano) {
    AnswerVO answerVO = this.answerDAO.read(ano);
    return answerVO;
  }

  @Override
  public int update_text(AnswerVO answerVO) {
    int cnt = this.answerDAO.update_text(answerVO);
    return cnt;
  }

  @Override
  public int delete(int ano) {
    int cnt = this.answerDAO.delete(ano);
    return cnt;
  }
  
}
