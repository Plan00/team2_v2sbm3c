package dev.mvc.disease;

import java.util.ArrayList;

public interface DiseaseProcInter {
  /**
   * 등록, 추상 메소드 -> Spring Boot이 구현함.
   * @param diseaseVO 객체
   * @return 등록된 레코드 갯수
   */
  public int create(DiseaseVO diseaseVO);
  
  /**
   * 전체 목록
   * @return
   */
  public ArrayList<DiseaseVO> list_all();
  
  /**
   * 조회
   * @param dno
   * @return
   */
  public DiseaseVO read(int dno);
  
  /**
   * 수정   
   * @param diseaseVO
   * @return 수정된 레코드 갯수
   */
  public int update(DiseaseVO diseaseVO);

  /**
   * 삭제
   * @param dno 삭제할 레코드 PK 번호
   * @return 삭제된 레코드 갯수
   */
  public int delete(int dno);
}
