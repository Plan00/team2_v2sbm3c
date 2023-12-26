<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="qna_no" value="${qnaVO.qna_no }" />
<c:set var="qna_title" value="${qnaVO.qna_title }" />
<c:set var="qna_main" value="${qnaVO.qna_main }" />
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>http://localhost:9093/qna/update.do</title>
<link rel="shortcut icon" href="/images/shortcut.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
  
</head>
 
<body>
<c:import url="/menu/top.do" />
 
  <div class='title_line'> ${qna_title } > 수정</div>
  
  <aside class="aside_right">
    <a href="./create.do">등록</a>
    <span class='menu_divide' >│</span>
    <a href="javascript:location.reload();">새로고침</a>
  </aside>
  
  <div style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_search_paging.do'>
      
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='word' id='word' value='${param.word }' class='input_word'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='word' id='word' value='' class='input_word'>
        </c:otherwise>
      </c:choose>
      <button type='submit' class='btn btn-secondary btn-sm' style="padding: 2px 8px 3px 8px; margin: 0px 0px 2px 0px;">검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' class='btn btn-secondary btn-sm' 
                    onclick="location.href='./list_search.do?word='" style="padding: 2px 8px 3px 8px; margin: 0px 0px 2px 0px;">검색 취소</button>  
      </c:if>    
    </form>
  </div>
  
  <div class='menu_line'></div>
  
  <form name='frm' method='post' action='./update_text.do'>
    <input type="hidden" name="dno" value="${dno }">
    <input type="hidden" name="qna_no" value="${qna_no }">
    <input type="hidden" name="now_page" value="${param.now_page }">
    
    <div>
       <label>제목</label>
       <input type='text' name='qna_title' value='${qna_title }' required="required" 
                 autofocus="autofocus" class="form-control" style='width: 100%;'>
    </div>
    <div>
       <label>내용</label>
       <textarea name='qna_main' required="required" class="form-control" rows="12" style='width: 100%;'>${qna_main }</textarea>
    </div>
    <div>
      <label>패스워드</label>
      <input type='password' name='qna_passwd' value='' required="required" 
                class="form-control" style='width: 50%;'>
    </div>
       
    <div class="content_body_bottom">
      <button type="submit" class="btn btn-secondary btn-sm">저장</button>
      <button type="button" onclick="location.href='./read.do?qna_no=${qna_no }'" class="btn btn-secondary btn-sm">취소</button>
    </div>
  
  </form>

 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>