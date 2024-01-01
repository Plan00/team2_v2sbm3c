package dev.mvc.answer;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.manager.ManagerProcInter;
import dev.mvc.qna.Qna;
import dev.mvc.qna.QnaVO;
import dev.mvc.tool.Tool;
import dev.mvc.answer.AnswerVO;

@Controller
public class AnswerCont {
  @Autowired
  @Qualifier("dev.mvc.answer.AnswerProc")
  private AnswerProcInter answerProc;
  
  @Autowired
  @Qualifier("dev.mvc.manager.ManagerProc") 
  private ManagerProcInter managerProc;
  
  @Qualifier("dev.mvc.answer.AnswerVO")
  private AnswerVO answerVO;
  
  public AnswerCont() {
    System.out.println("-> AnswerCont Created");
  }
  
  /**
   * POST 요청시 JSP 페이지에서 JSTL 호출 기능 지원, 새로고침 방지, EL에서 param으로 접근
   * POST → url → GET → 데이터 전송
   * @return
   */
  @RequestMapping(value="/answer/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();

    mav.setViewName(url); // forward
    
    return mav; // forward
  }
  
  /**
   * 등록 폼
   * http://localhost:9093/answer/create.do
   * @return
   */
   @RequestMapping(value="/answer/create.do", method = RequestMethod.GET)
   public ModelAndView create() {
     ModelAndView mav = new ModelAndView();
    
     mav.setViewName("/answer/create"); // /webapp/WEB-INF/views/answer/create.jsp
      
     return mav;
    }
   
   /**
    * 등록 처리 http://localhost:9093/answer/create.do
    * 
    * @return
    */
   @RequestMapping(value = "/answer/create.do", method = RequestMethod.POST)
   public ModelAndView create(HttpServletRequest request, HttpSession session, AnswerVO answerVO) {
     ModelAndView mav = new ModelAndView();
     
     if (managerProc.isManager(session)) { // 사용자로 로그인한경우
         // Call By Reference: 메모리 공유, Hashcode 전달
         int manager_no = (int)session.getAttribute("manager_no"); // manager_no FK
         answerVO.setManager_no(manager_no);
         int cnt = this.answerProc.create(answerVO); 
         
         if (cnt == 1) {
             mav.addObject("code", "create_success");

         } else {
             mav.addObject("code", "create_fail");
         }
         mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
         mav.addObject("url", "/answer/msg"); // msg.jsp, redirect parameter 적용
         mav.setViewName("redirect:/answer/msg.do"); // Post -> Get - param...
       
     } else {
       mav.addObject("url", "/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
       mav.setViewName("redirect:/answer/msg.do"); 
     }
     return mav; // forward
   }
   
   /**
    * 특정 qna에 등록된 답변
    * @param session
    * @return
    */
   @RequestMapping(value = "/answer/read_by_qna_no.do", method = RequestMethod.GET)
   @ResponseBody
   public ResponseEntity<Map<String, Object>> read_by_qna_no(int qna_no) {
       Map<String, Object> resultMap = new HashMap<>();

       AnswerVO answerVO = this.answerProc.read_by_qna_no(qna_no);

       if (answerVO != null) {
           resultMap.put("answerVO", answerVO);
           resultMap.put("ano", answerVO.getAno()); // 추가
       }

       return new ResponseEntity<>(resultMap, HttpStatus.OK);
   }

   
   /**
    * 조회
    * http://localhost:9093/answer/read.do?ano=4
    * @return
    */
   @RequestMapping(value="/answer/read.do", method = RequestMethod.GET)
   public ModelAndView read(int ano) {
     ModelAndView mav = new ModelAndView();
     mav.setViewName("/answer/read"); // /WEB-INF/views/answer/read.jsp
     
     AnswerVO answerVO = this.answerProc.read(ano);
     
     String amain = answerVO.getAmain();
     
     amain = Tool.convertChar(amain); // 특수 문자 처리
     
     answerVO.setAmain(amain);
     
     mav.addObject("answerVO", answerVO);
     
     return mav;
   }
   
   /* 수정 폼
    * http://localhost:9093/answer/update_text.do?ano=1
    * 
    * @return
    */
   @RequestMapping(value = "/answer/update_text.do", method = RequestMethod.GET)
   public ModelAndView update_text(HttpSession session, int ano) {
     ModelAndView mav = new ModelAndView();
     
     if (managerProc.isManager(session)) { // 관리자로 로그인한경우
       AnswerVO answerVO = this.answerProc.read(ano);
       mav.addObject("answerVO", answerVO);
       
       mav.setViewName("/answer/update_text"); // /WEB-INF/views/answer/update_text.jsp
       
     } else {
       mav.addObject("url", "/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
       mav.setViewName("redirect:/answer/msg.do"); 
     }

     return mav; // forward
   }
   
   /**
    * 수정 처리
    * http://localhost:9093/answer/update_text.do?ano=1
    * 
    * @return
    */
   @RequestMapping(value = "/answer/update_text.do", method = RequestMethod.POST)
   public ModelAndView update_text(HttpSession session, AnswerVO answerVO) {
     ModelAndView mav = new ModelAndView();
     
     if (this.managerProc.isManager(session)) { // 관리자 로그인 확인
       this.answerProc.update_text(answerVO); // 글수정  
        
       // mav 객체 이용
       mav.addObject("ano", answerVO.getAno());
       mav.addObject("main", answerVO.getAmain());
       mav.addObject("qna_no", answerVO.getQna_no());
       mav.setViewName("redirect:/qna/read.do"); // 페이지 자동 이동
         
     } else { // 정상적인 로그인이 아닌 경우 로그인 유도
       mav.addObject("url", "/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
       mav.setViewName("redirect:/answer/msg.do"); 
     }        
     
     return mav; // forward
   }
   
   /**
    * 삭제 폼
    * http://localhost:9093/answer/delete.do?ano=1
    * 
    * @return
    */
   @RequestMapping(value = "/answer/delete.do", method = RequestMethod.GET)
   public ModelAndView delete(HttpSession session, int ano) {
     ModelAndView mav = new ModelAndView();
     
     if (managerProc.isManager(session)) { // 관리자로 로그인한경우
       AnswerVO answerVO = this.answerProc.read(ano);
       mav.addObject("answerVO", answerVO);
       
       mav.setViewName("/answer/delete"); // /WEB-INF/views/answer/delete.jsp
       
     } else {
       mav.addObject("url", "/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
       mav.setViewName("redirect:/answer/msg.do"); 
     }
     
     return mav; // forward
   }
   
   /**
    * 삭제 처리 http://localhost:9093/answer/delete.do
    * 
    * @return
    */
   @RequestMapping(value = "/answer/delete.do", method = RequestMethod.POST)
   public ModelAndView delete(AnswerVO answerVO) {
     ModelAndView mav = new ModelAndView();
         
     this.answerProc.delete(answerVO.getAno()); // DBMS 삭제
     
     mav.addObject("now_page", 1);
     mav.setViewName("redirect:/qna/list_paging.do"); 
     
     return mav;
   }   
}
