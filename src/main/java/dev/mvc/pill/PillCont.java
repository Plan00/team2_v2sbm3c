package dev.mvc.pill;

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

import dev.mvc.pill.Pill;
import dev.mvc.pill.PillVO;
import dev.mvc.manager.ManagerProcInter;
import dev.mvc.disease.DiseaseProcInter;
import dev.mvc.disease.DiseaseVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class PillCont {
  @Autowired
  @Qualifier("dev.mvc.manager.ManagerProc") 
  private ManagerProcInter managerProc;
  
  @Autowired 
  @Qualifier("dev.mvc.disease.DiseaseProc")
  private DiseaseProcInter diseaseProc;
  
  @Autowired 
  @Qualifier("dev.mvc.pill.PillProc")
  private PillProcInter pillProc;
  
  public PillCont() {
    System.out.println("-> PillCont Created");
  }
  
  /**
   * POST 요청시 JSP 페이지에서 JSTL 호출 기능 지원, 새로고침 방지, EL에서 param으로 접근
   * POST → url → GET → 데이터 전송
   * @return
   */
  @RequestMapping(value="/pill/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();

    mav.setViewName(url); // forward
    
    return mav; // forward
  }
  
  // 등록 폼, pill 테이블은 FK로 dno를 사용함.
  // http://localhost:9093/pill/create.do  X
  // http://localhost:9093/pill/create.do?dno=1  // dno 변수값을 보내는 목적
  // http://localhost:9093/pill/create.do?dno=2
  // http://localhost:9093/pill/create.do?dno=3
  @RequestMapping(value="/pill/create.do", method = RequestMethod.GET)
  public ModelAndView create(int dno) {
    // public ModelAndView create(HttpServletRequest request,  int dno) {
    ModelAndView mav = new ModelAndView();
  
    DiseaseVO diseaseVO = this.diseaseProc.read(dno); // create.jsp에 카테고리 정보를 출력하기위한 목적
    mav.addObject("diseaseVO", diseaseVO);
    //   request.setAttribute(("diseaseVO", diseaseVO);
   
    mav.setViewName("/pill/create"); // /webapp/WEB-INF/views/pill/create.jsp
     
    return mav;
   }
  
  /**
   * 등록 처리 http://localhost:9093/pill/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/pill/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, HttpSession session, PillVO pillVO) {
    ModelAndView mav = new ModelAndView();
    
    if (managerProc.isManager(session)) { // 관리자로 로그인한경우
      // ------------------------------------------------------------------------------
      // 파일 전송 코드 시작
      // ------------------------------------------------------------------------------
      String file1 = "";          // 원본 파일명 image
      String file1saved = "";   // 저장된 파일명, image
      String thumb1 = "";     // preview image

      String upDir =  Pill.getUploadDir(); // 파일을 업로드할 폴더 준비
      System.out.println("-> upDir: " + upDir);
      
      // 전송 파일이 없어도 file1MF 객체가 생성됨.
      // <input type='file' class="form-control" name='file1MF' id='file1MF' 
      //           value='' placeholder="파일 선택">
      MultipartFile mf = pillVO.getFile1MF();
      
      file1 = mf.getOriginalFilename(); // 원본 파일명 산출
      System.out.println("-> 원본 파일명 산출 file1: " + file1);
      
      if(Tool.checkUploadFile(file1)) {  // 업로드 가능한 파일인지 검사, 확장자
        long size1 = mf.getSize();  // 파일 크기
        
        if (size1 > 0) { // 파일 크기 체크
          // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
          file1saved = Upload.saveFileSpring(mf, upDir); 
          
          if (Tool.isImage(file1saved)) { // 이미지인지 검사, 확장자를 통해 검사하는 것
            // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
            thumb1 = Tool.preview(upDir, file1saved, 200, 150); 
          }
          
        }    
        
        pillVO.setFile1(file1);   // 순수 원본 파일명
        pillVO.setFile1saved(file1saved); // 저장된 파일명(파일명 중복 처리)
        pillVO.setThumb1(thumb1);      // 원본이미지 축소판
        pillVO.setSize1(size1);  // 파일 크기
        // ------------------------------------------------------------------------------
        // 파일 전송 코드 종료
        // ------------------------------------------------------------------------------
        
        // Call By Reference: 메모리 공유, Hashcode 전달
        int manager_no = (int)session.getAttribute("manager_no"); // manager_no FK
        pillVO.setManager_no(manager_no);
        int cnt = this.pillProc.create(pillVO); 
        
        // ------------------------------------------------------------------------------
        // PK의 return
        // ------------------------------------------------------------------------------
        // System.out.println("--> pill_no: " + pillVO.getPill_no());
        // mav.addObject("pill_no", pillVO.getPill_no()); // redirect parameter 적용
        // ------------------------------------------------------------------------------
        
        if (cnt == 1) {
            mav.addObject("code", "create_success");
            // diseaseProc.increaseCnt(pillVO.getDno()); // 글수 증가
        } else {
            mav.addObject("code", "create_fail");
        }
        mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
        
        // System.out.println("--> dno: " + pillVO.getDno());
        // redirect시에 hidden tag로 보낸것들이 전달이 안됨으로 request에 다시 저장
        mav.addObject("dno", pillVO.getDno()); // redirect parameter 적용
        
        mav.addObject("url", "/pill/msg"); // msg.jsp, redirect parameter 적용
        mav.setViewName("redirect:/pill/msg.do"); // Post -> Get - param...
      } else {
        mav.addObject("cnt", "0");  // 업로드 할 수 없는 파일
        mav.addObject("code", "check_upload_file_fail");  // 업로드 할 수 없는 파일
        mav.addObject("url", "/pill/msg"); // msg.jsp, redirect parameter 적용
        mav.setViewName("redirect:/pill/msg.do"); // Post -> Get - param...
      }
    } else {
      mav.addObject("url", "/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
      mav.setViewName("redirect:/pill/msg.do"); 
    }
    
    return mav; // forward
  }
  
  /**
   * 전체 목록, 관리자만 사용 가능
   * http://localhost:9093/pill/list_all.do
   * @return
   */
  @RequestMapping(value="/pill/list_all.do", method = RequestMethod.GET)
  public ModelAndView list_all(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    if(this.managerProc.isManager(session) == true) {
      mav.setViewName("/pill/list_all"); // /WEB-INF/views/pill/list_all.jsp
      
      ArrayList<PillVO> list = this.pillProc.list_all();
      mav.addObject("list", list);
      
      // for문을 사용하여 객체를 추출, Call By Reference 기반의 원본 객체 값 변경
      for (PillVO pillVO : list) {
        String pill_name = pillVO.getPill_name();
        String efficacy = pillVO.getEfficacy();
        
        pill_name = Tool.convertChar(pill_name); // 특수 문자 처리
        efficacy = Tool.convertChar(efficacy);
        
        pillVO.setPill_name(pill_name);
        pillVO.setEfficacy(efficacy);
      }
    
    } else {
      mav.setViewName("/manager/login_need"); // /WEB-INF/views//manager/login_need.jsp
    }
    
    return mav;
  }
  
  /**
   * 조회
   * http://localhost:9093/pill/read.do?pill_no=4
   * @return
   */
  @RequestMapping(value="/pill/read.do", method = RequestMethod.GET)
  public ModelAndView read(int pill_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/pill/read"); // /WEB-INF/views/pill/read.jsp
    
    PillVO pillVO = this.pillProc.read(pill_no);
    
    String pill_name = pillVO.getPill_name();
    String efficacy = pillVO.getEfficacy();
    
    pill_name = Tool.convertChar(pill_name); // 특수 문자 처리
    efficacy = Tool.convertChar(efficacy);
    
    pillVO.setPill_name(pill_name);
    pillVO.setEfficacy(efficacy);
    
    long size1 = pillVO.getSize1();
    pillVO.setSize1_label(Tool.unit(size1));
    
    mav.addObject("pillVO", pillVO);
    
    DiseaseVO diseaseVO = this.diseaseProc.read(pillVO.getDno());
    mav.addObject("diseaseVO", diseaseVO);
    
    return mav;
  }
  
  /**
   * 목록 + 검색 + 페이징 지원
   * 검색하지 않는 경우
   * http://localhost:9093/pill/list_by_dno.do?dno=1&now_page=1
   * 검색하는 경우
   * http://localhost:9093/pill/list_by_dno.do?dno=1&search=TTS&now_page=1
   * 
   * @param dno
   * @param search
   * @param now_page
   * @return
   */
  @RequestMapping(value = "/pill/list_by_dno.do", method = RequestMethod.GET)
  public ModelAndView list_by_dno(PillVO pillVO) {
    ModelAndView mav = new ModelAndView();

    // 검색 목록
    ArrayList<PillVO> list = pillProc.list_by_dno_search_paging(pillVO);
    
    // for문을 사용하여 객체를 추출, Call By Reference 기반의 원본 객체 값 변경
    for (PillVO vo : list) {
      String pill_name = vo.getPill_name();
      String efficacy = vo.getEfficacy();
      
      pill_name = Tool.convertChar(pill_name);  // 특수 문자 처리
      efficacy = Tool.convertChar(efficacy); 
      
      vo.setPill_name(pill_name);
      vo.setEfficacy(efficacy);  
    }
    
    mav.addObject("list", list);

    DiseaseVO diseaseVO = diseaseProc.read(pillVO.getDno());
    mav.addObject("diseaseVO", diseaseVO);
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("dno", pillVO.getDno());
    hashMap.put("search", pillVO.getSearch());
    
    int search_count = this.pillProc.search_count(hashMap); // 검색된 레코드 개수 -> 전체 페이지 규모 파악
    mav.addObject("search_count", search_count);

    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
     * 18 19 20 [다음]
     * @param dno 카테고리번호
     * @param now_page 현재 페이지
     * @param search 검색어
     * @param list_file 목록 파일명
     * @return 페이징용으로 생성된 HTML/CSS tag 문자열
     */
    String paging = pillProc.pagingBox(pillVO.getDno(), pillVO.getNow_page(), pillVO.getSearch(), "list_by_dno.do", search_count);
    mav.addObject("paging", paging);

    // mav.addObject("now_page", now_page);
    
    mav.setViewName("/pill/list_by_dno");  // /pill/list_by_dno.jsp

    return mav;
  }
  
  /**
   * 목록 + 검색 + 페이징 지원 + Grid
   * 검색하지 않는 경우
   * http://localhost:9093/pill/list_by_dno.do?dno=1&now_page=1
   * 검색하는 경우
   * http://localhost:9093/pill/list_by_dno.do?dno=1&search=TTS&now_page=1
   * 
   * @param dno
   * @param search
   * @param now_page
   * @return
   */
  @RequestMapping(value = "/pill/list_by_dno_grid.do", method = RequestMethod.GET)
  public ModelAndView list_by_dno_grid(PillVO pillVO) {
    ModelAndView mav = new ModelAndView();

    // 검색 목록
    ArrayList<PillVO> list = pillProc.list_by_dno_search_paging(pillVO);
    
    // for문을 사용하여 객체를 추출, Call By Reference 기반의 원본 객체 값 변경
    for (PillVO vo : list) {
      String pill_name = vo.getPill_name();
      String efficacy = vo.getEfficacy();
      
      pill_name = Tool.convertChar(pill_name);  // 특수 문자 처리
      efficacy = Tool.convertChar(efficacy); 
      
      vo.setPill_name(pill_name);
      vo.setEfficacy(efficacy);  
    }
    
    mav.addObject("list", list);

    DiseaseVO diseaseVO = diseaseProc.read(pillVO.getDno());
    mav.addObject("diseaseVO", diseaseVO);
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("dno", pillVO.getDno());
    hashMap.put("search", pillVO.getSearch());
    
    int search_count = this.pillProc.search_count(hashMap); // 검색된 레코드 개수 -> 전체 페이지 규모 파악
    mav.addObject("search_count", search_count);

    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
     * 18 19 20 [다음]
     * @param dno 카테고리번호
     * @param now_page 현재 페이지
     * @param search 검색어
     * @param list_file 목록 파일명
     * @return 페이징용으로 생성된 HTML/CSS tag 문자열
     */
    String paging = pillProc.pagingBox(pillVO.getDno(), pillVO.getNow_page(), pillVO.getSearch(), "list_by_dno_grid.do", search_count);
    mav.addObject("paging", paging);

    // mav.addObject("now_page", now_page);
    
    mav.setViewName("/pill/list_by_dno_grid");  // /pill/list_by_dno.jsp

    return mav;
  }
  
  /* 수정 폼
  * http://localhost:9093/pill/update_text.do?pill_no=1
  * 
  * @return
  */
 @RequestMapping(value = "/pill/update_text.do", method = RequestMethod.GET)
 public ModelAndView update_text(HttpSession session, int pill_no) {
   ModelAndView mav = new ModelAndView();
   
   if (managerProc.isManager(session)) { // 관리자로 로그인한경우
     PillVO pillVO = this.pillProc.read(pill_no);
     mav.addObject("pillVO", pillVO);
     
     DiseaseVO diseaseVO = this.diseaseProc.read(pillVO.getDno());
     mav.addObject("diseaseVO", diseaseVO);
     
     mav.setViewName("/pill/update_text"); // /WEB-INF/views/pill/update_text.jsp

   } else {
     mav.addObject("url", "/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
     mav.setViewName("redirect:/pill/msg.do"); 
   }

   return mav; // forward
 }
 
 /**
  * 수정 처리
  * http://localhost:9093/pill/update_text.do?pill_no=1
  * 
  * @return
  */
 @RequestMapping(value = "/pill/update_text.do", method = RequestMethod.POST)
 public ModelAndView update_text(HttpSession session, PillVO pillVO) {
   ModelAndView mav = new ModelAndView();
   
   // System.out.println("-> word: " + pillVO.getWord());
   
   if (this.managerProc.isManager(session)) { // 관리자 로그인 확인
     HashMap<String, Object> hashMap = new HashMap<String, Object>();
     hashMap.put("pill_no", pillVO.getPill_no());
     hashMap.put("passwd", pillVO.getPasswd());
     
     if (this.pillProc.password_check(hashMap) == 1) { // 패스워드 일치
       this.pillProc.update_text(pillVO); // 글수정  
        
       // mav 객체 이용
       mav.addObject("pill_no", pillVO.getPill_no());
       mav.addObject("dno", pillVO.getDno());
       mav.setViewName("redirect:/pill/read.do"); // 페이지 자동 이동
       
     } else { // 패스워드 불일치
       mav.addObject("code", "passwd_fail");
       mav.addObject("cnt", 0);
       mav.addObject("url", "/pill/msg"); // msg.jsp, redirect parameter 적용
       mav.setViewName("redirect:/pill/msg.do");  // POST -> GET -> JSP 출력
     }
   } else { // 정상적인 로그인이 아닌 경우 로그인 유도
     mav.addObject("url", "/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
     mav.setViewName("redirect:/pill/msg.do"); 
   }
   
   mav.addObject("now_page", pillVO.getNow_page()); // POST -> GET: 데이터 분실이 발생함으로 다시하번 데이터 저장 ★
   
   // URL에 파라미터의 전송
   // mav.setViewName("redirect:/pill/read.do?pill_no=" + pillVO.getPill_no() + "&dno=" + pillVO.getDno());             
   
   return mav; // forward
 }
 
 /**
  * 파일 수정 폼
  * http://localhost:9093/pill/update_file.do?pill_no=1
  * 
  * @return
  */
 @RequestMapping(value = "/pill/update_file.do", method = RequestMethod.GET)
 public ModelAndView update_file(HttpSession session, int pill_no) {
   ModelAndView mav = new ModelAndView();
   
   if(managerProc.isManager(session)) { // 관리자로 로그인 한 경우
     PillVO pillVO = this.pillProc.read(pill_no);
     mav.addObject("pillVO", pillVO);
     
     DiseaseVO diseaseVO = this.diseaseProc.read(pillVO.getDno());
     mav.addObject("diseaseVO", diseaseVO);
     
     mav.setViewName("/pill/update_file"); // /WEB-INF/views/pill/update_file.jsp
   } else {
     mav.addObject("url", "/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
     mav.setViewName("redirect:/pill/msg.do"); 
   }
  
   return mav; // forward
 }
 
 /**
  * 파일 수정 처리 http://localhost:9093/pill/update_file.do
  * 
  * @return
  */
 @RequestMapping(value = "/pill/update_file.do", method = RequestMethod.POST)
 public ModelAndView update_file(HttpSession session, PillVO pillVO) {
   ModelAndView mav = new ModelAndView();
   
   if (this.managerProc.isManager(session)) {
     // 삭제할 파일 정보를 읽어옴, 기존에 등록된 레코드 저장용
     PillVO pillVO_old = pillProc.read(pillVO.getPill_no());
     
     // -------------------------------------------------------------------
     // 파일 삭제 시작
     // -------------------------------------------------------------------
     String file1saved = pillVO_old.getFile1saved();  // 실제 저장된 파일명
     String thumb1 = pillVO_old.getThumb1();       // 실제 저장된 preview 이미지 파일명
     long size1 = 0;
        
     String upDir =  Pill.getUploadDir(); // C:/kd/deploy/resort_v3sbm3c/pill/storage/
     
     Tool.deleteFile(upDir, file1saved);  // 실제 저장된 파일삭제
     Tool.deleteFile(upDir, thumb1);     // preview 이미지 삭제
     // -------------------------------------------------------------------
     // 파일 삭제 종료
     // -------------------------------------------------------------------
         
     // -------------------------------------------------------------------
     // 파일 전송 시작
     // -------------------------------------------------------------------
     String file1 = "";          // 원본 파일명 image

     // 전송 파일이 없어도 file1MF 객체가 생성됨.
     // <input type='file' class="form-control" name='file1MF' id='file1MF' 
     //           value='' placeholder="파일 선택">
     MultipartFile mf = pillVO.getFile1MF();
         
     file1 = mf.getOriginalFilename(); // 원본 파일명
     size1 = mf.getSize();  // 파일 크기
         
     if (size1 > 0) { // 폼에서 새롭게 올리는 파일이 있는지 파일 크기로 체크 ★
       // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
       file1saved = Upload.saveFileSpring(mf, upDir); 
       
       if (Tool.isImage(file1saved)) { // 이미지인지 검사
         // thumb 이미지 생성후 파일명 리턴됨, width: 250, height: 200
         thumb1 = Tool.preview(upDir, file1saved, 250, 200); 
       }
       
     } else { // 파일이 삭제만 되고 새로 올리지 않는 경우
       file1="";
       file1saved="";
       thumb1="";
       size1=0;
     }
         
     pillVO.setFile1(file1);
     pillVO.setFile1saved(file1saved);
     pillVO.setThumb1(thumb1);
     pillVO.setSize1(size1);
     // -------------------------------------------------------------------
     // 파일 전송 코드 종료
     // -------------------------------------------------------------------
         
     this.pillProc.update_file(pillVO); // Oracle 처리

     mav.addObject("pill_no", pillVO.getPill_no());
     mav.addObject("dno", pillVO.getDno());
     mav.setViewName("redirect:/pill/read.do"); // request -> param으로 접근 전환
               
   } else {
     mav.addObject("url", "/manager/login_need"); // login_need.jsp, redirect parameter 적용
     mav.setViewName("redirect:/pill/msg.do"); // GET
   }

   // redirect하게되면 전부 데이터가 삭제됨으로 mav 객체에 다시 저장
   mav.addObject("now_page", pillVO.getNow_page());
   
   return mav; // forward
 } 
 
 /**
  * 파일 삭제 폼
  * http://localhost:9093/pill/delete.do?pill_no=1
  * 
  * @return
  */
 @RequestMapping(value = "/pill/delete.do", method = RequestMethod.GET)
 public ModelAndView delete(HttpSession session, int pill_no) {
   ModelAndView mav = new ModelAndView();
   
   if (managerProc.isManager(session)) { // 관리자로 로그인한경우
     PillVO pillVO = this.pillProc.read(pill_no);
     mav.addObject("pillVO", pillVO);
     
     DiseaseVO diseaseVO = this.diseaseProc.read(pillVO.getDno());
     mav.addObject("diseaseVO", diseaseVO);
     
     mav.setViewName("/pill/delete"); // /WEB-INF/views/pill/delete.jsp
     
   } else {
     mav.addObject("url", "/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
     mav.setViewName("redirect:/pill/msg.do"); 
   }


   return mav; // forward
 }
 
 /**
  * 삭제 처리 http://localhost:9093/pill/delete.do
  * 
  * @return
  */
 @RequestMapping(value = "/pill/delete.do", method = RequestMethod.POST)
 public ModelAndView delete(PillVO pillVO) {
   ModelAndView mav = new ModelAndView();
   
   // -------------------------------------------------------------------
   // 파일 삭제 시작
   // -------------------------------------------------------------------
   // 삭제할 파일 정보를 읽어옴.
   PillVO pillVO_read = pillProc.read(pillVO.getPill_no());
       
   String file1saved = pillVO_read.getFile1saved();
   String thumb1 = pillVO_read.getThumb1();
   
   System.out.println("-> file1saved: " + file1saved);
   System.out.println("-> thumb1: " + thumb1);
   
   String uploadDir = Pill.getUploadDir();
   Tool.deleteFile(uploadDir, file1saved);  // 실제 저장된 파일삭제
   Tool.deleteFile(uploadDir, thumb1);     // preview 이미지 삭제
   // -------------------------------------------------------------------
   // 파일 삭제 종료
   // -------------------------------------------------------------------
       
   this.pillProc.delete(pillVO.getPill_no()); // DBMS 삭제
       
   // -------------------------------------------------------------------------------------
   // 마지막 페이지의 마지막 레코드 삭제시의 페이지 번호 -1 처리
   // -------------------------------------------------------------------------------------    
   // 마지막 페이지의 마지막 10번째 레코드를 삭제후
   // 하나의 페이지가 3개의 레코드로 구성되는 경우 현재 9개의 레코드가 남아 있으면
   // 페이지수를 4 -> 3으로 감소 시켜야함, 마지막 페이지의 마지막 레코드 삭제시 나머지는 0 발생
   int now_page = pillVO.getNow_page();
   
   HashMap<String, Object> hashMap = new HashMap<String, Object>();
   hashMap.put("dno", pillVO.getDno());
   hashMap.put("search", pillVO.getSearch());
   
   if (pillProc.search_count(hashMap) % Pill.RECORD_PER_PAGE == 0) {
     now_page = now_page - 1; // 삭제시 DBMS는 바로 적용되나 크롬은 새로고침등의 필요로 단계가 작동 해야함.
     if (now_page < 1) {
       now_page = 1; // 시작 페이지
     }
   }
   // -------------------------------------------------------------------------------------

   mav.addObject("dno", pillVO.getDno());
   mav.addObject("now_page", now_page);
   mav.setViewName("redirect:/pill/list_by_dno.do"); 
   
   return mav;
 }   
  
  // http://localhost:9093/pill/delete_by_dno.do?dno=1
  // 파일 삭제 -> 레코드 삭제
  @RequestMapping(value = "/pill/delete_by_dno.do", method = RequestMethod.GET)
  public String delete_by_dno(int dno) {
    ArrayList<PillVO> list = this.pillProc.list_by_dno(dno);
    
    for(PillVO pillVO : list) {
      // -------------------------------------------------------------------
      // 파일 삭제 시작
      // -------------------------------------------------------------------
      String file1saved = pillVO.getFile1saved();
      String thumb1 = pillVO.getThumb1();
      
      String uploadDir = Pill.getUploadDir();
      Tool.deleteFile(uploadDir, file1saved);  // 실제 저장된 파일삭제
      Tool.deleteFile(uploadDir, thumb1);     // preview 이미지 삭제
      // -------------------------------------------------------------------
      // 파일 삭제 종료
      // -------------------------------------------------------------------
    }
    
    int cnt = this.pillProc.delete_by_dno(dno);
    System.out.println("-> count: " + cnt);
    
    return "";
  
  }
  
  /**
   * Gallery 전체 이미지 출력
   * http://localhost:9093/pill/list_all_gallery.do
   * @return
   */
  @RequestMapping(value="/pill/list_all_gallery.do", method = RequestMethod.GET)
  public ModelAndView list_all_gallery(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    if(this.managerProc.isManager(session) == true) {
      mav.setViewName("/pill/list_all_gallery"); // /WEB-INF/views/pill/list_all.jsp
      
      ArrayList<PillVO> list = this.pillProc.list_all();
      mav.addObject("list", list);
    
    } else {
      mav.setViewName("/manager/login_need"); // /WEB-INF/views//manager/login_need.jsp
    }
    
    return mav;
  }
}
