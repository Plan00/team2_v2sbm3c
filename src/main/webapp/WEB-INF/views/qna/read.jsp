<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="qna_no" value="${qnaVO.qna_no }" />
<c:set var="qna_title" value="${qnaVO.qna_title }" />
<c:set var="qna_date" value="${qnaVO.qna_date }" />
<c:set var="qna_main" value="${qnaVO.qna_main }" />

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>알약 정보 사이트</title>
 
<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head> 
 
<body>
<c:import url="/menu/top.do" />
  <DIV class='title_line'><A href="./list_all.do" class='title_link'>QNA > 세부사항</A></DIV>

  <ASIDE class="aside_right">
    <%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
    <c:if test="${sessionScope.manager_id != null }">
      <A href="./create.do">등록</A>
      <span class='menu_divide' >│</span>
      <A href="./update_text.do?qna_no=${qna_no}&now_page=${param.now_page}">QNA 수정</A>
      <span class='menu_divide' >│</span>
      <A href="./delete.do?qna_no=${qna_no}&now_page=${param.now_page}">삭제</A>  
      <span class='menu_divide' >│</span>
    </c:if>
    
    <c:if test="${sessionScope.manager_id != null }">
    
    </c:if>
    
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>    
    <A href="./list_search.do?dno=${dno }&now_page=${param.now_page}&search=${param.search }">목록형</A>    
  </ASIDE> 
  
  <DIV class='menu_line'></DIV>

  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">
        <DIV style="width: 100%; word-break: break-all;">
          <span style="font-size: 1.5em; font-weight: bold;">${qna_title }</span>
          <span style="font-size: 1em;"> ${qna_date }</span><br>
          내용: ${qna_main }
        </DIV>
      </li>

    </ul>
  </fieldset>

</div>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>