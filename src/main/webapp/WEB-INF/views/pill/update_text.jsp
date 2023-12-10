<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<c:set var="dno" value="${diseaseVO.dno }" />

<c:set var="pill_no" value="${pillVO.pill_no }" />
<c:set var="pill_name" value="${pillVO.pill_name }" />
<c:set var="efficacy" value="${pillVO.efficacy }" />
<c:set var="search" value="${pillVO.search }" />
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>http://localhost:9093/pill/create.do</title>
<link rel="shortcut icon" href="/images/shortcut.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
  
</head>
 
<body>
<c:import url="/menu/top.do" />
 
  <div class='title_line'> ${diseaseVO.dname } > ${pill_name } > 수정</div>
  
  <aside class="aside_right">
    <a href="./create.do?dno=${dno }">등록</a>
    <span class='menu_divide' >│</span>
    <a href="javascript:location.reload();">새로고침</a>
    <span class='menu_divide' >│</span>    
    <A href="./list_by_dno.do?dno=${dno }&now_page=${param.now_page}&search=${param.search }">목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_dno_grid.do?dno=${dno }&now_page=${param.now_page}&search=${param.search }">갤러리형</A>
  </aside>
  
  <div style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_dno_search_paging.do'>
      <input type='hidden' name='dno' value='${diseaseVO.dno }'>  <%-- 게시판의 구분 --%>
      
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
                    onclick="location.href='./list_by_dno.do?dno=${diseaseVO.dno}&word='" style="padding: 2px 8px 3px 8px; margin: 0px 0px 2px 0px;">검색 취소</button>  
      </c:if>    
    </form>
  </div>
  
  <div class='menu_line'></div>
  
  <form name='frm' method='post' action='./update_text.do'>
    <input type="hidden" name="dno" value="${dno }">
    <input type="hidden" name="pill_no" value="${pill_no }">
    <input type="hidden" name="now_page" value="${param.now_page }">
    
    <div>
       <label>제목</label>
       <input type='text' name='pill_name' value='${pill_name }' required="required" 
                 autofocus="autofocus" class="form-control" style='width: 100%;'>
    </div>
    <div>
       <label>내용</label>
       <textarea name='efficacy' required="required" class="form-control" rows="12" style='width: 100%;'>${efficacy }</textarea>
    </div>
    <div>
       <label>검색어</label>
       <input type='text' name='search' value="${search }" required="required" 
                 class="form-control" style='width: 100%;'>
    </div>   
    
    <div>
      <label>패스워드</label>
      <input type='password' name='passwd' value='' required="required" 
                class="form-control" style='width: 50%;'>
    </div>
       
    <div class="content_body_bottom">
      <button type="submit" class="btn btn-secondary btn-sm">저장</button>
      <button type="button" onclick="location.href='./read.do?dno=${param.dno}&pill_no=${pill_no }'" class="btn btn-secondary btn-sm">취소</button>
    </div>
  
  </form>

 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>