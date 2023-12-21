package dev.mvc.mlogin;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component("dev.mvc.mlogin.MloginProc")
public class MloginProc implements MloginProcInter {
  @Autowired
  private MloginDAOInter mloginDAO;

  @Override
  public int create(MloginVO mloginVO) {
    int cnt = this.mloginDAO.create(mloginVO);
    return cnt;
  }

  @Override
  public ArrayList<MloginVO> list_all_manager() {
    ArrayList<MloginVO> list = this.mloginDAO.list_all_manager();
    return list;
  }

  @Override
  public ArrayList<MloginVO> list_all(int memberno) {
    ArrayList<MloginVO> list = this.mloginDAO.list_all(memberno);
    return list;
  }

}
