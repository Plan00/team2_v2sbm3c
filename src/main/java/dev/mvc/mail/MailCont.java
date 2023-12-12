package dev.mvc.mail;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.member.MemberProcInter;
import dev.mvc.member.MemberVO;
import dev.mvc.tool.MailTool;

@Controller
public class MailCont {
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc = null;
  
    public MailCont() {
        System.out.println("-> MailCont created.");
      }
    
    // http://localhost:9093/mail/form.do
    /**
     * 사용자의 정보 입력 화면, 아이디 찾기
     * @return
     */
    @RequestMapping(value = {"/mail/form.do"}, method=RequestMethod.GET)
    public ModelAndView form() {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/mail/form");  // /WEB-INF/views/mail/form.jsp

      return mav;
    }
    
    // http://localhost:9093/mail/send.do
    /**
     * 메일 전송, 아이디
     * @return
     */
    @RequestMapping(value = {"/mail/send.do"}, method=RequestMethod.POST)
    public ModelAndView send(String mname, String tel) {
      ModelAndView mav = new ModelAndView();
      HashMap<String, String> map = new HashMap<String, String>();
      map.put("mname", mname);
      map.put("tel", tel);
      MemberVO memberVO = memberProc.readByNameTel(map);

      if (memberVO != null) {
        String receiver = memberVO.getId();
        String from = "planarian4538@gmail.com";
        String title = "아이디 찾기";
        String content = memberVO.getId();
        
        mav.setViewName("/mail/sended");  // /WEB-INF/views/mail/sended.jsp

        MailTool mailTool = new MailTool();
        mailTool.send(receiver, from, title, content); // 메일 전송
        return mav;
      }
      else {
        mav.addObject("code", "no_data");
        mav.addObject("url", "/mail/msg");
        mav.setViewName("redirect:/mail/msg.do");
        return mav;
      }
    }
    
    // http://localhost:9093/mail/form_passwd.do
    /**
     * 사용자의 정보 입력 화면, 비밀번호 찾기
     * @return
     */
    @RequestMapping(value = {"/mail/form_passwd.do"}, method=RequestMethod.GET)
    public ModelAndView form_passwd() {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/mail/form_passwd");  // /WEB-INF/views/mail/form.jsp

      return mav;
    }
    
    // http://localhost:9093/mail/send_passwd.do
    /**
     * 메일 전송, 비밀번호
     * @return
     */
    @RequestMapping(value = {"/mail/send_passwd.do"}, method=RequestMethod.POST)
    public ModelAndView send_passwd(String id, String mname, String tel) {
      ModelAndView mav = new ModelAndView();
      HashMap<String, String> map = new HashMap<String, String>();
      map.put("mname", mname);
      map.put("tel", tel);
      MemberVO memberVO = memberProc.readByNameTel(map);
      if (memberVO != null) {
          memberVO = memberProc.readById(id);
          if (memberVO != null) {
              String receiver = memberVO.getId();
              String from = "planarian4538@gmail.com";
              String title = "비밀번호 찾기";
              String content = memberVO.getPasswd();

              mav.setViewName("/mail/sended");  // /WEB-INF/views/mail/sended.jsp

              MailTool mailTool = new MailTool();
              mailTool.send(receiver, from, title, content); // 메일 전송
              return mav;
          }
      }
       
      mav.addObject("code", "no_data"); 
      mav.addObject("url", "/mail/msg");
      mav.setViewName("redirect:/mail/msg.do");
      return mav;
    }
    
    /**
     * 새로고침 방지, EL에서 param으로 접근, POST -> GET -> /mail/msg.jsp
     * @return
     */
    @RequestMapping(value="/mail/msg.do", method=RequestMethod.GET)
    public ModelAndView msg(String url){
      ModelAndView mav = new ModelAndView();

      mav.setViewName(url); // forward
      
      return mav; // forward
    }

}