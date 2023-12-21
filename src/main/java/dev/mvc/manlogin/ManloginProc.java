package dev.mvc.manlogin;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.disease.DiseaseVO;

@Component("dev.mvc.manlogin.ManloginProc")
public class ManloginProc implements ManloginProcInter {
  @Autowired
  private ManloginDAOInter manloginDAO;

  @Override
  public int create(ManloginVO manloginVO) {
    int cnt = this.manloginDAO.create(manloginVO);
    return cnt;
  }

  @Override
  public ArrayList<ManloginVO> list_all() {
    ArrayList<ManloginVO> list = this.manloginDAO.list_all();
    return list;
  }


}
