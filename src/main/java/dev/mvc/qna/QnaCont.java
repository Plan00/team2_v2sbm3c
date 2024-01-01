package dev.mvc.qna;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.manager.ManagerProcInter;
import dev.mvc.member.MemberProcInter;
import dev.mvc.tool.Tool;


@Controller
public class QnaCont {
  @Autowired
  @Qualifier("dev.mvc.manager.ManagerProc") 
  private ManagerProcInter managerProc;
  
  @Autowired 
  @Qualifier("dev.mvc.qna.QnaProc")
  private QnaProcInter qnaProc;
  
  @Autowired 
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc;
  
  @Qualifier("dev.mvc.qna.QnaVO")
  private QnaVO qnaVO;
  
  public QnaCont() {
    System.out.println("-> QnaCont Created");
  }
  
  /**
   * POST 요청시 JSP 페이지에서 JSTL 호출 기능 지원, 새로고침 방지, EL에서 param으로 접근
   * POST → url → GET → 데이터 전송
   * @return
   */
  @RequestMapping(value="/qna/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();

    mav.setViewName(url); // forward
    
    return mav; // forward
  }
  
  /**
   * 등록 폼
   * http://localhost:9093/qna/create.do
   * @return
   */
   @RequestMapping(value="/qna/create.do", method = RequestMethod.GET)
   public ModelAndView create() {
     ModelAndView mav = new ModelAndView();
    
     mav.setViewName("/qna/create"); // /webapp/WEB-INF/views/qna/create.jsp
      
     return mav;
    }
   
   /**
    * 등록 처리 http://localhost:9093/qna/create.do
    * 
    * @return
    */
   @RequestMapping(value = "/qna/create.do", method = RequestMethod.POST)
   public ModelAndView create(HttpServletRequest request, HttpSession session, QnaVO qnaVO) {
     ModelAndView mav = new ModelAndView();
     
     if (memberProc.isMember(session)) { // 사용자로 로그인한경우
         // Call By Reference: 메모리 공유, Hashcode 전달
         int memberno = (int)session.getAttribute("memberno"); // manager_no FK
         qnaVO.setMemberno(memberno);
         int cnt = this.qnaProc.create(qnaVO); 
         
         if (cnt == 1) {
             mav.addObject("code", "create_success");

         } else {
             mav.addObject("code", "create_fail");
         }
         mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
         mav.addObject("url", "/qna/msg"); // msg.jsp, redirect parameter 적용
         mav.setViewName("redirect:/qna/msg.do"); // Post -> Get - param...
       
     } else {
       mav.addObject("url", "/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
       mav.setViewName("redirect:/qna/msg.do"); 
     }
     return mav; // forward
   }
   
   /**
    * 전체 목록
    * http://localhost:9093/qna/list_all.do
    * @return
    */
   @RequestMapping(value="/qna/list_all.do", method = RequestMethod.GET)
   public ModelAndView list_all(HttpSession session) {
     ModelAndView mav = new ModelAndView();
     
     if((this.managerProc.isManager(session) == true) || this.memberProc.isMember(session) ) {
       mav.setViewName("/qna/list_all"); // /WEB-INF/views/qna/list_all.jsp
       
       ArrayList<QnaVO> list = this.qnaProc.list_all();
       mav.addObject("list", list);
       
       // for문을 사용하여 객체를 추출, Call By Reference 기반의 원본 객체 값 변경
       for (QnaVO qnaVO : list) {
         String qna_title = qnaVO.getQna_title();
         String qna_main = qnaVO.getQna_main();
         
         qna_title = Tool.convertChar(qna_title); // 특수 문자 처리
         qna_main = Tool.convertChar(qna_main);
         
         qnaVO.setQna_title(qna_title);
         qnaVO.setQna_main(qna_main);
       }
     
     } else {
       mav.setViewName("/member/login_need"); // /WEB-INF/views//manager/login_need.jsp
     }
     
     return mav;
   }
   
   /**
    * 조회
    * http://localhost:9093/qna/read.do?qna_no=4
    * @return
    */
   @RequestMapping(value="/qna/read.do", method = RequestMethod.GET)
   public ModelAndView read(int qna_no) {
     ModelAndView mav = new ModelAndView();
     mav.setViewName("/qna/read"); // /WEB-INF/views/qna/read.jsp
     
     QnaVO qnaVO = this.qnaProc.read(qna_no);
     
     String qna_title = qnaVO.getQna_title();
     String qna_main = qnaVO.getQna_main();
     
     qna_title = Tool.convertChar(qna_title); // 특수 문자 처리
     qna_main = Tool.convertChar(qna_main);
     
     qnaVO.setQna_title(qna_title);
     qnaVO.setQna_main(qna_main);
     
     mav.addObject("qnaVO", qnaVO);
     
     return mav;
   }
   
   /**
    * 목록 + 페이징 지원
    * @param search
    * @param now_page
    * @return
    */
   @RequestMapping(value = "/qna/list_paging.do", method = RequestMethod.GET)
   public ModelAndView list_paging(QnaVO qnaVO) {
     ModelAndView mav = new ModelAndView();

     // 검색 목록
     ArrayList<QnaVO> list = qnaProc.list_search_paging(qnaVO);
     
     // for문을 사용하여 객체를 추출, Call By Reference 기반의 원본 객체 값 변경
     for (QnaVO vo : list) {
       String qna_title = vo.getQna_title();
       String qna_main = vo.getQna_main();
       
       qna_title = Tool.convertChar(qna_title);  // 특수 문자 처리
       qna_main = Tool.convertChar(qna_main); 
       
       vo.setQna_title(qna_title);
       vo.setQna_main(qna_main);  
     }
     
     mav.addObject("list", list);
     
     int search_count = this.qnaProc.count(); // 검색된 레코드 개수 -> 전체 페이지 규모 파악
     mav.addObject("search_count", search_count);

     /*
      * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
      * 18 19 20 [다음]
      * @param now_page 현재 페이지
      * @param list_file 목록 파일명
      * @return 페이징용으로 생성된 HTML/CSS tag 문자열
      */
     String paging = qnaProc.pagingBox(qnaVO.getNow_page(), "list_paging.do", search_count);
     mav.addObject("paging", paging);

     // mav.addObject("now_page", now_page);
     
     mav.setViewName("/qna/list_paging");  // /qna/list_by_dno.jsp

     return mav;
   }
   
   /* 수정 폼
    * http://localhost:9093/qna/update_text.do?qna_no=1
    * 
    * @return
    */
   @RequestMapping(value = "/qna/update_text.do", method = RequestMethod.GET)
   public ModelAndView update_text(HttpSession session, int qna_no) {
     ModelAndView mav = new ModelAndView();
     
     if (managerProc.isManager(session)) { // 관리자로 로그인한경우
       QnaVO qnaVO = this.qnaProc.read(qna_no);
       mav.addObject("qnaVO", qnaVO);
       
       mav.setViewName("/qna/update_text"); // /WEB-INF/views/qna/update_text.jsp
       
     } else {
       mav.addObject("url", "/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
       mav.setViewName("redirect:/qna/msg.do"); 
     }

     return mav; // forward
   }
   
   /**
    * 수정 처리
    * http://localhost:9093/qna/update_text.do?qna_no=1
    * 
    * @return
    */
   @RequestMapping(value = "/qna/update_text.do", method = RequestMethod.POST)
   public ModelAndView update_text(HttpSession session, QnaVO qnaVO) {
     ModelAndView mav = new ModelAndView();
     
     if (this.managerProc.isManager(session)) { // 관리자 로그인 확인
       HashMap<String, Object> hashMap = new HashMap<String, Object>();
       hashMap.put("qna_no", qnaVO.getQna_no());
       hashMap.put("qna_passwd", qnaVO.getQna_passwd());
       
       if (this.qnaProc.password_check(hashMap) == 1) { // 패스워드 일치
         this.qnaProc.update_text(qnaVO); // 글수정  
          
         // mav 객체 이용
         mav.addObject("qna_no", qnaVO.getQna_no());
         mav.setViewName("redirect:/qna/read.do"); // 페이지 자동 이동
         
       } else { // 패스워드 불일치
         mav.addObject("code", "passwd_fail");
         mav.addObject("cnt", 0);
         mav.addObject("url", "/qna/msg"); // msg.jsp, redirect parameter 적용
         mav.setViewName("redirect:/qna/msg.do");  // POST -> GET -> JSP 출력
       }
     } else { // 정상적인 로그인이 아닌 경우 로그인 유도
       mav.addObject("url", "/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
       mav.setViewName("redirect:/qna/msg.do"); 
     }
     
     mav.addObject("now_page", qnaVO.getNow_page()); // POST -> GET: 데이터 분실이 발생함으로 다시하번 데이터 저장 ★           
     
     return mav; // forward
   }
   
   /**
    * 삭제 폼
    * http://localhost:9093/qna/delete.do?qna_no=1
    * 
    * @return
    */
   @RequestMapping(value = "/qna/delete.do", method = RequestMethod.GET)
   public ModelAndView delete(HttpSession session, int qna_no) {
     ModelAndView mav = new ModelAndView();
     
     if (managerProc.isManager(session)) { // 관리자로 로그인한경우
       QnaVO qnaVO = this.qnaProc.read(qna_no);
       mav.addObject("qnaVO", qnaVO);
       
       mav.setViewName("/qna/delete"); // /WEB-INF/views/qna/delete.jsp
       
     } else {
       mav.addObject("url", "/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
       mav.setViewName("redirect:/qna/msg.do"); 
     }
     
     return mav; // forward
   }
   
   /**
    * 삭제 처리 http://localhost:9093/qna/delete.do
    * 
    * @return
    */
   @RequestMapping(value = "/qna/delete.do", method = RequestMethod.POST)
   public ModelAndView delete(QnaVO qnaVO) {
     ModelAndView mav = new ModelAndView();
         
     this.qnaProc.delete(qnaVO.getQna_no()); // DBMS 삭제
         
     // -------------------------------------------------------------------------------------
     // 마지막 페이지의 마지막 레코드 삭제시의 페이지 번호 -1 처리
     // -------------------------------------------------------------------------------------    
     // 마지막 페이지의 마지막 10번째 레코드를 삭제후
     // 하나의 페이지가 3개의 레코드로 구성되는 경우 현재 9개의 레코드가 남아 있으면
     // 페이지수를 4 -> 3으로 감소 시켜야함, 마지막 페이지의 마지막 레코드 삭제시 나머지는 0 발생
     int now_page = qnaVO.getNow_page();
     
     
     if (qnaProc.count() % Qna.RECORD_PER_PAGE == 0) {
       now_page = now_page - 1; // 삭제시 DBMS는 바로 적용되나 크롬은 새로고침등의 필요로 단계가 작동 해야함.
       if (now_page < 1) {
         now_page = 1; // 시작 페이지
       }
     }
     // -------------------------------------------------------------------------------------

     mav.addObject("now_page", now_page);
     mav.setViewName("redirect:/qna/list_paging.do"); 
     
     return mav;
   }   
    
}
