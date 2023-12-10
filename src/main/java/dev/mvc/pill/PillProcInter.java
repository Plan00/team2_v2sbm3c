package dev.mvc.pill;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * 개발자가 구현
 * @author Administrator
 *
 */
public interface PillProcInter {
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
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param techno          카테고리번호 
   * @param now_page      현재 페이지
   * @param isearch 검색어
   * @param list_file 목록 파일명 
   * @param search_count 검색 레코드 수
   * @return 페이징 생성 문자열
   */ 
  public String pagingBox(int dno, int now_page, String search, String list_file, int search_count);
  
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
