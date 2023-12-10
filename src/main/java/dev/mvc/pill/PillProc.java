package dev.mvc.pill;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.tool.Tool;

@Component("dev.mvc.pill.PillProc")
public class PillProc implements PillProcInter {
  @Autowired  // PillDAOInter interface를 구현한 클래스 객체를 만들어 자동 할당
  private PillDAOInter pillDAO;
  
  @Override
  public int create(PillVO pillVO) {
    int cnt = this.pillDAO.create(pillVO);
    return cnt;
  }

  @Override
  public ArrayList<PillVO> list_all() {
    ArrayList<PillVO> list = this.pillDAO.list_all();
    return list;
  }

  @Override
  public ArrayList<PillVO> list_by_dno(int dno) {
    ArrayList<PillVO> list = this.pillDAO.list_by_dno(dno);
    return list;
  }

  @Override
  public PillVO read(int pill_no) {
    PillVO pillVO =this.pillDAO.read(pill_no);
    return pillVO;
  }

  @Override
  public ArrayList<PillVO> list_by_dno_search(HashMap<String, Object> hashMap) {
    ArrayList<PillVO> list = this.pillDAO.list_by_dno_search(hashMap);
    return list;
  }

  @Override
  public int search_count(HashMap<String, Object> hashMap) {
    int cnt = this.pillDAO.search_count(hashMap);
    return cnt;
  }

  @Override
  public ArrayList<PillVO> list_by_dno_search_paging(PillVO pillVO) {
    int begin_of_page = (pillVO.getNow_page() - 1) * Pill.RECORD_PER_PAGE;
    
    // 시작 rownum 결정
    // 1 페이지 = 0 + 1: 1
    // 2 페이지 = 10 + 1: 11
    // 3 페이지 = 20 + 1: 21 
    int start_num = begin_of_page + 1;
    
    //  종료 rownum
    // 1 페이지 = 0 + 10: 10
    // 2 페이지 = 10 + 10: 20
    // 3 페이지 = 20 + 10: 30
    int end_num = begin_of_page + Pill.RECORD_PER_PAGE;   
    /*
    1 페이지: WHERE r >= 1 AND r <= 10
    2 페이지: WHERE r >= 11 AND r <= 20
    3 페이지: WHERE r >= 21 AND r <= 30
    */
    
    // System.out.println("begin_of_page: "+begin_of_page);
    // System.out.println("WHERE r>= "+start_num+"AND r <= "+end_num);
    
    pillVO.setStart_num(start_num);
    pillVO.setEnd_num(end_num);
    
    ArrayList<PillVO> list = this.pillDAO.list_by_dno_search_paging(pillVO);
    
    return list;
  }
  
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param dno 카테고리번호 
   * @param now_page  현재 페이지
   * @param search 검색어
   * @param list_file 목록 파일명
   * @param search_count 검색 레코드 수
   * @return 페이징 생성 문자열
   */ 
  @Override
  public String pagingBox(int dno, int now_page, String search, String list_file, int search_count){
    // 전체 페이지 수: (double)1/10 = 0.1 -> 1, (double)12/10 = 1.2 -> 2 페이지
    // ceil 은 무조건 반올림
    int total_page = (int)(Math.ceil((double)search_count / Pill.RECORD_PER_PAGE)); 
    // 전체 그룹  수: (double)1/10 -> 0.1 -> 1 그룹
    int total_grp = (int)(Math.ceil((double)total_page / Pill.PAGE_PER_BLOCK)); 
    // 현재 그룹 번호: (double)13/10 -> 1.3 -> 2 그룹 
    int now_grp = (int)(Math.ceil((double)now_page / Pill.PAGE_PER_BLOCK)); 
    
    // 1 group: 1, 2, 3 ... 9, 10
    // 2 group: 11, 12 ... 19, 20
    // 3 group: 21, 22 ... 29, 30
    int start_page = ((now_grp - 1) * Pill.PAGE_PER_BLOCK) + 1; // 특정 그룹의 시작  페이지  
    int end_page = (now_grp * Pill.PAGE_PER_BLOCK);               // 특정 그룹의 마지막 페이지   
     
    StringBuffer str = new StringBuffer(); // String class 보다 문자열 추가등의 편집시 속도가 빠름 
    
    // style이 java 파일에 명시되는 경우는 로직에 따라 css가 영향을 많이 받는 경우에 사용하는 방법
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;");    
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 
 
    // 이전 10개 페이지로 이동
    // now_grp: 1 (1 ~ 10 page)
    // now_grp: 2 (11 ~ 20 page)
    // now_grp: 3 (21 ~ 30 page) 
    // 현재 2그룹일 경우: (2 - 1) * 10 = 1그룹의 마지막 페이지 10
    // 현재 3그룹일 경우: (3 - 1) * 10 = 2그룹의 마지막 페이지 20
    int _now_page = (now_grp - 1) * Pill.PAGE_PER_BLOCK;  
    if (now_grp >= 2){ // 현재 그룹번호가 2이상이면 페이지수가 11페이지 이상임으로 이전 그룹으로 갈수 있는 링크 생성 
      str.append("<span class='span_box_1'><A href='"+list_file+"?&search="+search+"&now_page="+_now_page+"&dno="+dno+"'>이전</A></span>"); 
    } 
 
    // 중앙의 페이지 목록
    for(int i=start_page; i<=end_page; i++){ 
      if (i > total_page){ // 마지막 페이지를 넘어갔다면 페이지 출력 종료
        break; 
      } 
  
      if (now_page == i){ // 목록에 출력하는 페이지가 현재페이지와 같다면 CSS 강조(차별을 둠)
        str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
      }else{
        // 현재 페이지가 아닌 페이지는 이동이 가능하도록 링크를 설정
        str.append("<span class='span_box_1'><A href='"+list_file+"?search="+search+"&now_page="+i+"&dno="+dno+"'>"+i+"</A></span>");   
      } 
    } 
 
    // 10개 다음 페이지로 이동
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // 현재 페이지 5일경우 -> 현재 1그룹: (1 * 10) + 1 = 2그룹의 시작페이지 11
    // 현재 페이지 15일경우 -> 현재 2그룹: (2 * 10) + 1 = 3그룹의 시작페이지 21
    // 현재 페이지 25일경우 -> 현재 3그룹: (3 * 10) + 1 = 4그룹의 시작페이지 31
    _now_page = (now_grp * Pill.PAGE_PER_BLOCK)+1; //  최대 페이지수 + 1 
    if (now_grp < total_grp){ 
      str.append("<span class='span_box_1'><A href='"+list_file+"?&search="+search+"&now_page="+_now_page+"&dno="+dno+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }

  @Override
  public int password_check(HashMap<String, Object> hashMap) {
    int cnt = this.pillDAO.password_check(hashMap);
    return cnt;
  }
  
  @Override
  public int update_text(PillVO pillVO) {
    int cnt = this.pillDAO.update_text(pillVO);
    return cnt;
  }

  @Override
  public int update_file(PillVO pillVO) {
    int cnt = this.pillDAO.update_file(pillVO);
    return cnt;
  }

  @Override
  public int delete(int pill_no) {
    int cnt = this.pillDAO.delete(pill_no);
    return cnt;
  }

  @Override
  public int count_by_dno(int dno) {
    int cnt = this.pillDAO.count_by_dno(dno);
    return cnt;
  }

  @Override
  public int delete_by_dno(int dno) {
    int cnt = this.pillDAO.delete_by_dno(dno);
    return cnt;
  }

}
