package dev.mvc.mypill;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.member.MemberProcInter;
import dev.mvc.pill.PillProcInter;
import dev.mvc.mypill.MypillVO;
import dev.mvc.tool.Tool;

@Controller
public class MypillCont {
  @Autowired 
  @Qualifier("dev.mvc.mypill.MypillProc")
  private MypillProcInter mypillProc;
  
  @Qualifier("dev.mvc.mypill.MypillVO")
  private MypillVO mypillVO;
  
  @Autowired 
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc;
  
  @Autowired 
  @Qualifier("dev.mvc.pill.PillProc")
  private PillProcInter pillProc;
  
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
   * 등록 처리 http://localhost:9093/mypill/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/mypill/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, HttpSession session, MypillVO mypillVO) {
    ModelAndView mav = new ModelAndView();
    
    if (memberProc.isMember(session)) { // 회원으로 로그인한경우
      int memberno = (int)session.getAttribute("memberno"); // memberno FK
      mypillVO.setMemberno(memberno);
      
      String pillNoString = request.getParameter("pill_no");
      int pill_no = Integer.parseInt(pillNoString);
      mypillVO.setPill_no(pill_no);
      
      String mypill_name = request.getParameter("pill_name");
      mypillVO.setMypill_name(mypill_name);
      
      HashMap<String, Integer> map = new HashMap<String, Integer>();
      map.put("memberno", memberno);
      map.put("pill_no", pill_no);
      
      int check = this.mypillProc.check(map);
      
      if (check == 0) { // 등록된 알약이 없으면, 등록 진행
        int cnt = this.mypillProc.create(mypillVO);
        
        if (cnt == 1) {
          mav.addObject("code", "create_success");
          mav.addObject("mypill_name", mypillVO.getMypill_name());
          mav.addObject("url", "/mypill/msg");
          mav.setViewName("redirect:/pill/msg.do");
        } else {
          mav.addObject("code", "create_fail");
          mav.setViewName("redirect:/pill/msg.do");
        }
        mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      } else { // 등록된 알약이 있으면, 등록 불가
        mav.addObject("code", "already");
        mav.addObject("url", "/mypill/msg");
        mav.setViewName("redirect:/pill/msg.do");
      }
    
    } else {
      mav.addObject("url", "/member/login_need"); 
      mav.setViewName("redirect:/member/msg.do");
    }
    
    return mav;
  }

  
  /**
   * 삭제 처리 http://localhost:9093/mypill/delete.do
   * 
   * @return
   */
  @RequestMapping(value = "/mypill/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(MypillVO mypillVO) {
    ModelAndView mav = new ModelAndView();
    
    this.mypillProc.delete(mypillVO.getMypill_no()); // DBMS 삭제
    
    mav.setViewName("redirect:/mypill/list_all.do");
    
    return mav;
  }   
  
  /**
   * 내 알약 중복 체크 http://localhost:9093/mypill/check.do
   * 
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/mypill/check.do", method = RequestMethod.GET)
  public int check(HttpServletRequest request, HttpSession session) {
      int memberno = (int) session.getAttribute("memberno"); 
      
      String pillNoString = request.getParameter("pill_no");
      int pill_no = Integer.parseInt(pillNoString);

      HashMap<String, Integer> map = new HashMap<>();
      map.put("memberno", memberno);
      map.put("pill_no", pill_no);

      int cnt = this.mypillProc.check(map);
      
      return cnt;
  }


}
