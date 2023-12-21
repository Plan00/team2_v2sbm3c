package dev.mvc.manlogin;

import java.util.ArrayList;

public interface ManloginDAOInter {
  /**
   * 등록
   * @param manloginVO 객체
   * @return 등록된 레코드 갯수
   */
  public int create(ManloginVO manloginVO);
  
  /**
   * 전체 목록
   * @return
   */
  public ArrayList<ManloginVO> list_all();
  
}
