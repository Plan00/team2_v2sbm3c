package dev.mvc.pill;

import java.util.ArrayList;
import java.util.HashMap;

public interface PillDAOInter {
  /**
   * 등록, 추상 메소드
   * @param pillVO
   * @return
   */
  public int create(PillVO pillVO);
  
  /**
   * 모든 카테고리의 등록된 글 목록
   * @return
   */
  public ArrayList<PillVO> list_all();
  
  /**
   * 특정 카테고리의 등록된 글 목록
   * @return
   */
  public ArrayList<PillVO> list_by_dno(int dno);
  
  /**
   * 일반적인 조회
   * @return
   */
  public PillVO read(int pill_no);
  
  /**
   * 카테고리별 검색 목록
   * @param map
   * @return
   */
  public ArrayList<PillVO> list_by_dno_search(HashMap<String, Object> hashMap);
  
  /**
   * 카테고리별 검색된 레코드 갯수
   * @param map
   * @return
   */
  public int search_count(HashMap<String, Object> hashMap);
  
  /**
   *  특정 카테고리의 검색 + 페이징된 글목록
   *  spring framework이 JDBC 관련 코드를 모두 생성해줌
   * @return
   */
  public ArrayList<PillVO> list_by_dno_search_paging(PillVO pillVO);
  
  /**
   * 패스워드 검사
   * @param hashMap
   * @return
   */
  public int password_check(HashMap<String, Object> hashMap);
  
  /**
   * 글 정보 수정
   * @param pillVO
   * @return 처리된 레코드 갯수
   */
  public int update_text(PillVO pillVO);
  
  /**
   * 파일 정보 수정
   * @param contentsVO
   * @return 처리된 레코드 갯수
   */
  public int update_file(PillVO pillVO);
  
  /**
   * 삭제
   * @param pill_no
   * @return 삭제된 레코드 갯수
   */
  public int delete(int pill_no);
  
  /**
   * FK dno 값이 같은 레코드 갯수 산출
   * @param dno
   * @return
   */
  public int count_by_dno(int dno);
  
  /**
   * 특정 카테고리에 속한 모든 레코드 삭제
   * @param dno
   * @return 삭제된 레코드 갯수
   */
  public int delete_by_dno(int dno);
}
