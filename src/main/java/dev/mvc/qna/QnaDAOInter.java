package dev.mvc.qna;

import java.util.ArrayList;
import java.util.HashMap;

public interface QnaDAOInter {
  /**
   * 등록, 추상 메소드
   * @param qnaVO
   * @return
   */
  public int create(QnaVO qnaVO);
  
  /**
   * 모든 카테고리의 등록된 글 목록
   * @return
   */
  public ArrayList<QnaVO> list_all();
  
  /**
   * 일반적인 조회
   * @return
   */
  public QnaVO read(int qna_no);
  
  /**
   * 검색 목록
   * @param map
   * @return
   */
  public ArrayList<QnaVO> list_search(HashMap<String, Object> hashMap);
  
  /**
   * 검색된 레코드 갯수
   * @param map
   * @return
   */
  public int search_count(HashMap<String, Object> hashMap);
  
  /**
   *  검색 + 페이징된 글목록
   *  spring framework이 JDBC 관련 코드를 모두 생성해줌
   * @return
   */
  public ArrayList<QnaVO> list_search_paging(QnaVO qnaVO);
  
  /**
   * 패스워드 검사
   * @param hashMap
   * @return
   */
  public int password_check(HashMap<String, Object> hashMap);
  
  /**
   * 글 정보 수정
   * @param qnaVO
   * @return 처리된 레코드 갯수
   */
  public int update_text(QnaVO qnaVO);
  
  /**
   * 삭제
   * @param qna_no
   * @return 삭제된 레코드 갯수
   */
  public int delete(int qna_no);
  
  /**
   * FK dno 값이 같은 레코드 갯수 산출
   * @return
   */
  public int count();
  
  /**
   * 모든 레코드 삭제
   * @return 삭제된 레코드 갯수
   */
  public int delete_all();
}
