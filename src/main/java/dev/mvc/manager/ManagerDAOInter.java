package dev.mvc.manager;

public interface ManagerDAOInter {
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
   * manager_no를 통한 관리자 정보 조회
   * @param manager_no
   * @return
   */
  public ManagerVO read(int manager_no);
}
