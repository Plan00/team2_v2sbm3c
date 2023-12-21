package dev.mvc.mlogin;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.mlogin.MloginVO;
import dev.mvc.manager.ManagerProcInter;
import dev.mvc.manlogin.ManloginVO;
import dev.mvc.member.MemberProcInter;


@Controller
public class MloginCont {
  public MloginCont() {
    System.out.println("-> MloginCont created.");
  }
  
  @Autowired
  @Qualifier("dev.mvc.mlogin.MloginProc")
  private MloginProcInter mloginProc;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc") 
  private MemberProcInter memberProc;
  
  @Autowired
  @Qualifier("dev.mvc.manager.ManagerProc") 
  private ManagerProcInter managerProc;
  
  /**
   * 전체 목록
   * http://localhost:9093/mlogin/list_all_manager.do
   * @return
   */
  @RequestMapping(value="/mlogin/list_all_manager.do", method = RequestMethod.GET)
  public ModelAndView list_all_manager(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    if(this.managerProc.isManager(session) == true) {
      mav.setViewName("/mlogin/list_all_manager");
      
      ArrayList<MloginVO> list = this.mloginProc.list_all_manager();
      mav.addObject("list", list);
    } else {
      mav.setViewName("/manager/login_need");
    }
    
    return mav;
  }
  
  /**
   * 특정 회원 전체 목록
   * http://localhost:9093/mlogin/list_all.do
   * @return
   */
  @RequestMapping(value="/mlogin/list_all.do", method = RequestMethod.GET)
  public ModelAndView list_all(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    if(this.memberProc.isMember(session) == true) {
      mav.setViewName("/mlogin/list_all");
      int memberno = (int) session.getAttribute("memberno");
      
      ArrayList<MloginVO> list = this.mloginProc.list_all(memberno);
      mav.addObject("list", list);
    } else {
      mav.setViewName("/member/login_need");
    }
    
    return mav;
  }
}
