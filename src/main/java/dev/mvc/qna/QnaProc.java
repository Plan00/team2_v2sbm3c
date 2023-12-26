package dev.mvc.qna;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component("dev.mvc.qna.QnaProc")
public class QnaProc implements QnaProcInter {
  @Autowired  
  private QnaDAOInter qnaDAO;
  
  @Override
  public int create(QnaVO qnaVO) {
    int cnt = this.qnaDAO.create(qnaVO);
    return cnt;
  }

  @Override
  public ArrayList<QnaVO> list_all() {
    ArrayList<QnaVO> list = this.qnaDAO.list_all();
    return list;
  }

  @Override
  public QnaVO read(int qna_no) {
    QnaVO qnaVO =this.qnaDAO.read(qna_no);
    return qnaVO;
  }

  @Override
  public ArrayList<QnaVO> list_search_paging(QnaVO qnaVO) {
    int begin_of_page = (qnaVO.getNow_page() - 1) * Qna.RECORD_PER_PAGE;
    
    // 시작 rownum 결정
    // 1 페이지 = 0 + 1: 1
    // 2 페이지 = 10 + 1: 11
    // 3 페이지 = 20 + 1: 21 
    int start_num = begin_of_page + 1;
    
    //  종료 rownum
    // 1 페이지 = 0 + 10: 10
    // 2 페이지 = 10 + 10: 20
    // 3 페이지 = 20 + 10: 30
    int end_num = begin_of_page + Qna.RECORD_PER_PAGE;   
    /*
    1 페이지: WHERE r >= 1 AND r <= 10
    2 페이지: WHERE r >= 11 AND r <= 20
    3 페이지: WHERE r >= 21 AND r <= 30
    */
    
    // System.out.println("begin_of_page: "+begin_of_page);
    // System.out.println("WHERE r>= "+start_num+"AND r <= "+end_num);
    
    qnaVO.setStart_num(start_num);
    qnaVO.setEnd_num(end_num);
    
    ArrayList<QnaVO> list = this.qnaDAO.list_paging(qnaVO);
    
    return list;
  }
  
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param now_page  현재 페이지
   * @param search 검색어
   * @param list_file 목록 파일명
   * @param search_count 검색 레코드 수
   * @return 페이징 생성 문자열
   */ 
  @Override
  public String pagingBox(int now_page, String list_file, int search_count){
    // 전체 페이지 수: (double)1/10 = 0.1 -> 1, (double)12/10 = 1.2 -> 2 페이지
    // ceil 은 무조건 반올림
    int total_page = (int)(Math.ceil((double)search_count / Qna.RECORD_PER_PAGE)); 
    // 전체 그룹  수: (double)1/10 -> 0.1 -> 1 그룹
    int total_grp = (int)(Math.ceil((double)total_page / Qna.PAGE_PER_BLOCK)); 
    // 현재 그룹 번호: (double)13/10 -> 1.3 -> 2 그룹 
    int now_grp = (int)(Math.ceil((double)now_page / Qna.PAGE_PER_BLOCK)); 
    
    // 1 group: 1, 2, 3 ... 9, 10
    // 2 group: 11, 12 ... 19, 20
    // 3 group: 21, 22 ... 29, 30
    int start_page = ((now_grp - 1) * Qna.PAGE_PER_BLOCK) + 1; // 특정 그룹의 시작  페이지  
    int end_page = (now_grp * Qna.PAGE_PER_BLOCK);               // 특정 그룹의 마지막 페이지   
     
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
    int _now_page = (now_grp - 1) * Qna.PAGE_PER_BLOCK;  
    if (now_grp >= 2){ // 현재 그룹번호가 2이상이면 페이지수가 11페이지 이상임으로 이전 그룹으로 갈수 있는 링크 생성 
      str.append("<span class='span_box_1'><A href='"+list_file+"?&now_page="+_now_page+">이전</A></span>"); 
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
        str.append("<span class='span_box_1'><A href='"+list_file+"?&now_page="+i+"'>"+i+"</A></span>");   
      } 
    } 
 
    // 10개 다음 페이지로 이동
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // 현재 페이지 5일경우 -> 현재 1그룹: (1 * 10) + 1 = 2그룹의 시작페이지 11
    // 현재 페이지 15일경우 -> 현재 2그룹: (2 * 10) + 1 = 3그룹의 시작페이지 21
    // 현재 페이지 25일경우 -> 현재 3그룹: (3 * 10) + 1 = 4그룹의 시작페이지 31
    _now_page = (now_grp * Qna.PAGE_PER_BLOCK)+1; //  최대 페이지수 + 1 
    if (now_grp < total_grp){ 
      str.append("<span class='span_box_1'><A href='"+list_file+"?&now_page="+_now_page+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }

  @Override
  public int password_check(HashMap<String, Object> hashMap) {
    int cnt = this.qnaDAO.password_check(hashMap);
    return cnt;
  }

  @Override
  public int update_text(QnaVO qnaVO) {
    int cnt = this.qnaDAO.update_text(qnaVO);
    return cnt;
  }

  @Override
  public int delete(int qna_no) {
    int cnt = this.qnaDAO.delete(qna_no);
    return cnt;
  }

  @Override
  public int count() {
    int cnt = this.qnaDAO.count();
    return cnt;
  }

  @Override
  public int delete_all() {
    int cnt = this.qnaDAO.delete_all();
    return cnt;
  }

}
