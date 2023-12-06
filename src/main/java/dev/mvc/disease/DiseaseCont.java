package dev.mvc.disease;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.tool.Tool;

@Controller
public class DiseaseCont {
  @Autowired
  @Qualifier("dev.mvc.disease.DiseaseProc")
  private DiseaseProcInter diseaseProc;
    
  public DiseaseCont() {
    System.out.println("-> DiseaseCont created.");  
  }
  
  //FORM 출력, http://localhost:9093/disease/create.do
  @RequestMapping(value="/disease/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/disease/create"); // /WEB-INF/views/cate/create.jsp
   
    return mav;
  }
  
  //FORM 데이터 처리, http://localhost:9093/disease/create.do
 @RequestMapping(value="/disease/create.do", method = RequestMethod.POST)
  public ModelAndView create(DiseaseVO diseaseVO) { // 자동으로 cateVO 객체가 생성되고 폼의 값이 할당됨
    ModelAndView mav = new ModelAndView();
   
    int cnt = this.diseaseProc.create(diseaseVO);
    System.out.println("-> cnt: " + cnt);
   
    if (cnt == 1) {
      mav.setViewName("redirect:/disease/list_all.do"); // 주소 자동 이동
    } else {
      mav.addObject("code", "create_fail");
      mav.setViewName("/disease/msg"); // /WEB-INF/views/disease/msg.jsp
    }
   
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
   
    return mav;
  }
 
}
