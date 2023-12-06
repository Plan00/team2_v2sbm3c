package dev.mvc.disease;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.disease.DiseaseProc")
public class DiseaseProc implements DiseaseProcInter {
  @Autowired // CateDAOInter interface를 구현한 클래스의 객체를 만들어 자동으로 할당해라.
  private DiseaseDAOInter diseaseDAO;
  
  @Override
  public int create(DiseaseVO diseaseVO) {
    int cnt = this.diseaseDAO.create(diseaseVO);
    
    return cnt;
  }

  @Override
  public ArrayList<DiseaseVO> list_all() {
    ArrayList<DiseaseVO> list = this.diseaseDAO.list_all();
    
    return list;
  }

  @Override
  public DiseaseVO read(int dno) {
    DiseaseVO  diseaseVO  = this.diseaseDAO.read(dno);
    
    return diseaseVO;
  }

  @Override
  public int update(DiseaseVO diseaseVO) {
    int cnt = this.diseaseDAO.update(diseaseVO);
    
    return cnt;
  }

  @Override
  public int delete(int dno) {
    int cnt = this.diseaseDAO.delete(dno);
    
    return cnt;
  }

}
