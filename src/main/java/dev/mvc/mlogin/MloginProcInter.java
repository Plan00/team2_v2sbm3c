package dev.mvc.mlogin;

import java.util.ArrayList;

public interface MloginProcInter {
  /**
   * 등록
   * @param mloginVO 객체
   * @return 등록된 레코드 갯수
   */
  public int create(MloginVO mloginVO);
  
  /**
   * 전체 목록
   * @return
   */
  public ArrayList<MloginVO> list_all_manager();
  
  /**
   * 접속 사용자 로그인 전체 목록
   * @param memberno
   * @return
   */
  public ArrayList<MloginVO> list_all(int memberno);
}
