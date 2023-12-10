package dev.mvc.manager;

import javax.servlet.http.HttpSession;

public interface ManagerProcInter {
  /**
   * 로그인
   * @param ManagerVO
   * @return
   */
  public int login(ManagerVO managerVO);
  
  /**
   * 관리자 정보
   * @param String
   * @return
   */
  public ManagerVO read_by_manager_id(String manager_id);
  
  /**
   * 관리자 로그인 체크
   * @param session
   * @return
   */
  public boolean isManager(HttpSession session);
  
  /**
   * manager_id를 통한 회원 정보 조회
   * @param manager_id
   * @return
   */
  public ManagerVO read(int manager_id);
}
