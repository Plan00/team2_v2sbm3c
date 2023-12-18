package dev.mvc.mypill;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component("dev.mvc.mypill.MypillProc")
public class MypillProc implements MypillProcInter {
  @Autowired
  private MypillDAOInter mypillDAO;

  @Override
  public int create(MypillVO mypillVO) {
    int cnt = this.mypillDAO.create(mypillVO);
    return cnt;
  }

  @Override
  public ArrayList<MypillVO> list_all() {
    ArrayList<MypillVO> list = this.mypillDAO.list_all();
    return list;
  }

  @Override
  public int delete(int mypill_no) {
    int cnt = this.mypillDAO.delete(mypill_no);
    return cnt;
  }

  @Override
  public int check(HashMap<String, Integer> map) {
    int cnt = mypillDAO.check(map);
    return cnt;
  }

}
