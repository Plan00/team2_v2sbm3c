package dev.mvc.disease;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.disease.DiseaseVO;
import dev.mvc.manager.ManagerProcInter;
import dev.mvc.tool.Tool;

@Controller
public class DiseaseCont {
  public DiseaseCont() {
    System.out.println("-> DiseaseCont created.");
  }
  
  @Autowired
  @Qualifier("dev.mvc.disease.DiseaseProc")
  private DiseaseProcInter diseaseProc;
  
  @Autowired
  @Qualifier("dev.mvc.manager.ManagerProc") 
  private ManagerProcInter managerProc;
  
//  @Autowired    // DiseaseProcInter interface 구현한 객체를 만들어 자동으로 할당하라
//  @Qualifier("dev.mvc.issue.IssueProc")
//  private IssueProcInter issueProc;

  //FORM 출력, http://localhost:9093/disease/create.do
  @RequestMapping(value="/disease/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/disease/create"); // /WEB-INF/views/disease/create.jsp
   
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
 
 /**
  * 전체 목록
  * http://localhost:9093/disease/list_all.do
  * @return
  */
 @RequestMapping(value="/disease/list_all.do", method = RequestMethod.GET)
 public ModelAndView list_all(HttpSession session) {
   ModelAndView mav = new ModelAndView();
   
   if(this.managerProc.isManager(session) == true) {
     mav.setViewName("/disease/list_all"); // /WEB-INF/views/disease/list_all.jsp
     
     ArrayList<DiseaseVO> list = this.diseaseProc.list_all();
     mav.addObject("list", list);
   } else {
     mav.setViewName("/manager/login_need"); // /WEB-INF/views//manager/login_need.jsp
   }
   
   return mav;
 }
 
 /**
  * 조회
  * http://localhost:9093/disease/read.do?dno=1
  * @param dno
  * @return
  */
 @RequestMapping(value="/disease/read.do", method = RequestMethod.GET)
 public ModelAndView read(int dno) {
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/disease/read"); // /WEB-INF/views/disease/read.jsp
   
   DiseaseVO diseaseVO = this.diseaseProc.read(dno);
   mav.addObject("diseaseVO", diseaseVO);
   
   return mav;
 }
 
 /**
  * 수정폼
  * http://localhost:9093/disease/update.do?dno=1
  * @return
  */
 @RequestMapping(value="/disease/update.do", method = RequestMethod.GET)
 public ModelAndView update(HttpSession session, int dno) {
   ModelAndView mav = new ModelAndView();
   
   if(this.managerProc.isManager(session) == true) {
     mav.setViewName("/disease/list_all_update");
     
     DiseaseVO diseaseVO = this.diseaseProc.read(dno);
     mav.addObject("diseaseVO", diseaseVO);
     
     ArrayList<DiseaseVO> list = this.diseaseProc.list_all();
     mav.addObject("list", list);
   } else {
     mav.setViewName("/manager/login_need"); // /WEB-INF/views//manager/login_need.jsp
   }
   
   return mav;
 }
 
 /**
  * 수정 처리, http://localhost:9093/disease/update.do
  * @param diseaseVO 수정할 내용
  * @return
  */
 @RequestMapping(value="/disease/update.do", method = RequestMethod.POST)
 public ModelAndView update(DiseaseVO diseaseVO) {
   ModelAndView mav = new ModelAndView();
   
   int cnt = this.diseaseProc.update(diseaseVO);
   System.out.println("-> cnt: " + cnt);
   
   if (cnt == 1) {
     mav.setViewName("redirect:/disease/list_all.do");
   } else {
     mav.addObject("code", "update_fail");
     mav.setViewName("/disease/msg");
   }
   
   mav.addObject("cnt", cnt);
   return mav;
 }
 
// /**
//  * 삭제폼
//  * http://localhost:9093/disease/delete.do?dno=1
//  * @return
//  */
// @RequestMapping(value="/disease/delete.do", method = RequestMethod.GET)
// public ModelAndView delete(HttpSession session, int dno) { 
//   ModelAndView mav = new ModelAndView();
//   
//   if(this.managerProc.isManager(session) == true) {
//     mav.setViewName("/disease/list_all_delete"); 
//     
//     DiseaseVO diseaseVO = this.diseaseProc.read(dno);
//     mav.addObject("diseaseVO", diseaseVO);
//     
//     ArrayList<DiseaseVO> list = this.diseaseProc.list_all();
//     mav.addObject("list", list);
//     
//     // 특정 카테고리에 속한 레코드 갯수를 리턴
//     int count_by_dno = this.issueProc.count_by_dno(dno);
//     mav.addObject("count_by_dno", count_by_dno);
//     
//   } else {
//     mav.setViewName("/manager/login_need"); // /WEB-INF/views//manager/login_need.jsp
//   }
//   return mav;
// }
 
// /**
//  * 카테고리 삭제
//  * @param session
//  * @param dno 삭제할 카테고리 번호
//  * @return
//  */
// @RequestMapping(value="/disease/delete.do", method=RequestMethod.POST)
// public ModelAndView delete_proc(HttpSession session, int dno) { // <form> 태그의 값이 자동으로 저장됨
////   System.out.println("-> dno: " + techVO.getTechno());
////   System.out.println("-> name: " + techVO.getName());
//   
//   ModelAndView mav = new ModelAndView();
//   
//   if (this.managerProc.isManager(session) == true) {
//     ArrayList<IssueVO> list = this.issueProc.list_by_dno(dno); // 자식 레코드 목록 읽기
//     
//     for(IssueVO issueVO : list) { // 자식 레코드 관련 파일 삭제
//       // -------------------------------------------------------------------
//       // 파일 삭제 시작
//       // -------------------------------------------------------------------
//       String file1saved = issueVO.getIfile1saved();
//       String thumb1 = issueVO.getIthumb1();
//       
//       String uploadDir = Issue.getUploadDir();
//       Tool.deleteFile(uploadDir, file1saved);  // 실제 저장된 파일삭제
//       Tool.deleteFile(uploadDir, thumb1);     // preview 이미지 삭제
//       // -------------------------------------------------------------------
//       // 파일 삭제 종료
//       // -------------------------------------------------------------------
//     }
//     
//     this.issueProc.delete_by_dno(dno); // 자식 레코드 삭제     
//           
//     int cnt = this.techProc.delete(dno); // 카테고리 삭제
//     
//     if (cnt == 1) {
//       mav.setViewName("redirect:/tech/list_all.do");       // 자동 주소 이동, Spring 재호출
//       
//     } else {
//       mav.addObject("code", "delete_fail");
//       mav.setViewName("/tech/msg"); // /WEB-INF/views/tech/msg.jsp
//     }
//     
//     mav.addObject("cnt", cnt);
//     
//   } else {
//     mav.setViewName("/admin/login_need"); // /WEB-INF/views/admin/login_need.jsp
//   }
//   
//   return mav;
// }
 
 /**
  * 우선 순위 높임, 10등 -> 1등   , http://localhost:9093/disease/update_seqno_forward.do?dno=1
  * @param dno 수정될 레코드 PK 번호
  * @return
  */
 @RequestMapping(value="/disease/update_seqno_forward.do", method = RequestMethod.GET)
 public ModelAndView update_seqno_forward(int dno) {
   ModelAndView mav = new ModelAndView();
   
   
   int cnt = this.diseaseProc.update_seqno_forward(dno);
   System.out.println("-> cnt: " + cnt);
   
   if (cnt == 1) {
     mav.setViewName("redirect:/disease/list_all.do");
   } else {
     mav.addObject("code", "update_fail");
     mav.setViewName("/disease/msg");
   }
   
   mav.addObject("cnt", cnt);
   return mav;
 }
 
 /**
  * 우선 순위 낮춤, 1등 -> 10등   , http://localhost:9093/disease/update_seqno_backward.do?dno=1
  * @param dno 수정될 레코드 PK 번호
  * @return
  */
 @RequestMapping(value="/disease/update_seqno_backward.do", method = RequestMethod.GET)
 public ModelAndView update_seqno_backward(int dno) {
   ModelAndView mav = new ModelAndView();
   
   
   int cnt = this.diseaseProc.update_seqno_backward(dno);
   System.out.println("-> cnt: " + cnt);
   
   if (cnt == 1) {
     mav.setViewName("redirect:/disease/list_all.do");
   } else {
     mav.addObject("code", "update_fail");
     mav.setViewName("/disease/msg");
   }
   
   mav.addObject("cnt", cnt);
   return mav;
 }
 
 /**
  * 카테고리 공개 설정   , http://localhost:9093/disease/update_visible_y.do?dno=1
  * @param dno 수정될 레코드 PK 번호
  * @return
  */
 @RequestMapping(value="/disease/update_visible_y.do", method = RequestMethod.GET)
 public ModelAndView update_visible_y(int dno) {
   ModelAndView mav = new ModelAndView();
   
   int cnt = this.diseaseProc.update_visible_y(dno);
   System.out.println("-> cnt: " + cnt);
   
   if (cnt == 1) {
     mav.setViewName("redirect:/disease/list_all.do");
   } else {
     mav.addObject("code", "update_fail");
     mav.setViewName("/disease/msg");
   }
   
   mav.addObject("cnt", cnt);
   return mav;
 }
 
 /**
  * 카테고리 비공개 설정   , http://localhost:9093/disease/update_visible_y.do?dno=1
  * @param dno 수정될 레코드 PK 번호
  * @return
  */
 @RequestMapping(value="/disease/update_visible_n.do", method = RequestMethod.GET)
 public ModelAndView update_visible_n(int dno) {
   ModelAndView mav = new ModelAndView();
   
   int cnt = this.diseaseProc.update_visible_n(dno);
   System.out.println("-> cnt: " + cnt);
   
   if (cnt == 1) {
     mav.setViewName("redirect:/disease/list_all.do");
   } else {
     mav.addObject("code", "update_fail");
     mav.setViewName("/disease/msg");
   }
   
   mav.addObject("cnt", cnt);
   return mav;
 }
}
