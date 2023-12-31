package dev.mvc.answer;

import java.util.ArrayList;

public interface AnswerDAOInter {
  /**
   * 등록, 추상 메소드
   * @param answerVO
   * @return
   */
  public int create(AnswerVO answerVO);
  
  /**
   * 전체 답변 목록
   * @return
   */
  public ArrayList<AnswerVO> list_all();
  
  /**
   * 특정 qna에 등록된 답변
   * @return
   */
  public AnswerVO read_by_qna_no(int qna_no);
  
  /**
   * 일반적인 조회
   * @return
   */
  public AnswerVO read(int ano);
  
  /**
   * 글 정보 수정
   * @param answerVO
   * @return 처리된 레코드 갯수
   */
  public int update_text(AnswerVO answerVO);
  
  /**
   * 삭제
   * @param ano
   * @return 삭제된 레코드 갯수
   */
  public int delete(int ano);
}
