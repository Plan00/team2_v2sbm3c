package dev.mvc.manlogin;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.manager.ManagerProcInter;

@Controller
public class ManloginCont {
  public ManloginCont() {
    System.out.println("-> ManloginCont created.");
  }
  
  @Autowired
  @Qualifier("dev.mvc.manlogin.ManloginProc")
  private ManloginProcInter manloginProc;
  
  @Autowired
  @Qualifier("dev.mvc.manager.ManagerProc") 
  private ManagerProcInter managerProc;
  
  /**
   * 전체 목록
   * http://localhost:9093/manlogin/list_all.do
   * @return
   */
  @RequestMapping(value="/manlogin/list_all.do", method = RequestMethod.GET)
  public ModelAndView list_all(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    if(this.managerProc.isManager(session) == true) {
      mav.setViewName("/manlogin/list_all");
      
      ArrayList<ManloginVO> list = this.manloginProc.list_all();
      mav.addObject("list", list);
    } else {
      mav.setViewName("/manager/login_need");
    }
    
    return mav;
  }

}
