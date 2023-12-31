package dev.mvc.mypill;

import java.util.ArrayList;
import java.util.HashMap;

public interface MypillDAOInter {
  /**
   * 등록, 추상 메소드
   * @param mypillVO
   * @return
   */
  public int create(MypillVO mypillVO);
  
  /**
   * 모든 카테고리의 등록된 알약 목록
   * @return
   */
  public ArrayList<MypillVO> list_all();
  
  /**
   * 삭제
   * @param mypill_no
   * @return 삭제된 레코드 갯수
   */
  public int delete(int mypill_no);
  
  /**
   * 내 알약 컬럼 체크
   * @param map (memberno, pill_no를 포함하는 HashMap)
   * @return cnt
   */
  public int check(HashMap<String, Integer> map);
}
