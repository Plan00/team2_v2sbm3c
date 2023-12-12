package dev.mvc.mypill;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.disease.DiseaseProcInter;
import dev.mvc.member.MemberProcInter;
import dev.mvc.pill.Pill;
import dev.mvc.pill.PillProcInter;
import dev.mvc.pill.PillVO;
import dev.mvc.mypill.MypillVO;
import dev.mvc.mypill.MypillVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class MypillCont {
  @Autowired 
  @Qualifier("dev.mvc.disease.DiseaseProc")
  private DiseaseProcInter diseaseProc;
  
  @Autowired 
  @Qualifier("dev.mvc.mypill.MypillProc")
  private MypillProcInter mypillProc;
  
  @Autowired 
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc;
  
  public MypillCont() {
    System.out.println("-> MypillCont Created");
  }
  
  /**
   * 전체 목록
   * http://localhost:9093/mypill/list_all.do
   * @return
   */
  @RequestMapping(value="/mypill/list_all.do", method = RequestMethod.GET)
  public ModelAndView list_all(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    if(this.memberProc.isMember(session) == true) {
      mav.setViewName("/mypill/list_all"); // /WEB-INF/views/mypill/list_all.jsp
      
      ArrayList<MypillVO> list = this.mypillProc.list_all();
      mav.addObject("list", list);
      
      // for문을 사용하여 객체를 추출, Call By Reference 기반의 원본 객체 값 변경
      for (MypillVO mypillVO : list) {
        String mypill_name = mypillVO.getMypill_name();
        String mypill_date = mypillVO.getMypill_date();
        
        mypill_name = Tool.convertChar(mypill_name); // 특수 문자 처리
        mypill_date = Tool.convertChar(mypill_date);
        
        mypillVO.setMypill_name(mypill_name);
        mypillVO.setMypill_date(mypill_date);
      }
    
    } else {
      mav.setViewName("/member/login_need");
    }
    
    return mav;
  }
  
  /**
   * 삭제 처리 http://localhost:9093/mypill/delete.do
   * 
   * @return
   */
  @RequestMapping(value = "/mypill/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(MypillVO mypillVO) {
    ModelAndView mav = new ModelAndView();
        
    this.mypillProc.delete(mypillVO.getMypill_no()); // DBMS 삭제

 
    mav.setViewName("redirect:/mypill/list_all.do"); 
    
    return mav;
  }   
  
}
