<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="dname" value="${diseaseVO.dname }" />
<c:set var="dno" value="${pillVO.dno }" />
<c:set var="pill_no" value="${pillVO.pill_no }" />
<c:set var="thumb1" value="${pillVO.thumb1 }" />
<c:set var="file1saved" value="${pillVO.file1saved }" />
<c:set var="pill_name" value="${pillVO.pill_name }" />
<c:set var="rdate" value="${pillVO.rdate }" />
<c:set var="efficacy" value="${pillVO.efficacy }" />
<c:set var="side" value="${pillVO.side }" />
<c:set var="file1" value="${pillVO.file1 }" />
<c:set var="size1" value="${pillVO.size1 }" />
<c:set var="size1_label" value="${pillVO.size1_label }" />
<c:set var="search" value="${pillVO.search }" />


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

</head> 
 
<body>
<c:import url="/menu/top.do" />
  <DIV class='title_line'><A href="./list_by_dno.do?dno=${diseaseVO.dno }" class='title_link'>${diseaseVO.dname }</A></DIV>

  <ASIDE class="aside_right">
    <%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
    <c:if test="${sessionScope.manager_id != null }">
      <%--
      http://localhost:9092/pill/create.do?dno=1
      http://localhost:9092/pill/create.do?dno=2
      http://localhost:9092/pill/create.do?dno=3
      --%>
      <A href="./create.do?dno=${dno }">등록</A>
      <span class='menu_divide' >│</span>
      <A href="./update_text.do?pill_no=${pill_no}&now_page=${param.now_page}&search=${param.search }">글 수정</A>
      <span class='menu_divide' >│</span>
      <A href="./update_file.do?pill_no=${pill_no}&now_page=${param.now_page}">파일 수정</A>  
      <span class='menu_divide' >│</span>
      <A href="./delete.do?pill_no=${pill_no}&now_page=${param.now_page}&dno=${dno}">삭제</A>  
      <span class='menu_divide' >│</span>
    </c:if>

    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>    
    <A href="./list_by_dno.do?dno=${dno }&now_page=${param.now_page}&search=${param.search }">목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_dno_grid.do?dno=${dno }&now_page=${param.now_page}&search=${param.search }">갤러리형</A>
  </ASIDE> 
  
  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_dno.do'>
      <input type='hidden' name='dno' value='${dno }'>  <%-- 게시판의 구분 --%>
      
      <c:choose>
        <c:when test="${param.search != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='search' id='search' value='${param.search }' class='input_word'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='search' id='search' value='' class='input_word'>
        </c:otherwise>
      </c:choose>
      <button type='submit' class='btn btn-secondary btn-sm' 
                   style="padding: 2px 8px 3px 8px; margin: 0px 0px 2px 0px;">검색</button>
      <c:if test="${param.search.length() > 0 }">
        <button type='button' class='btn btn-secondary btn-sm' 
                    onclick="location.href='./list_by_dno.do?dno=${dno}&search='" 
                    style="padding: 2px 8px 3px 8px; margin: 0px 0px 2px 0px;">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>

  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">
        <DIV style="width: 100%; word-break: break-all;">
          <c:choose>
            <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
              <img src="/pill/storage/${file1saved }" style='width: 50%; float: left; margin-top: 0.5%; margin-right: 1%;'> 
            </c:when>
            <c:otherwise> <!-- 기본 이미지 출력 -->
              <img src="/pill/images/none1.png" style='width: 50%; float: left; margin-top: 0.5%; margin-right: 1%;'> 
            </c:otherwise>
          </c:choose>

          <span style="font-size: 1.5em; font-weight: bold;">${pill_name }</span>
          <span style="font-size: 1em;"> ${rdate }</span><br>
          효과: ${efficacy }
        </DIV>
      </li>
      
      <li class="li_none" style="clear: both;">
        <div style='text-decoration: none;'>
          <br>
          부작용: ${side }
        </div>
      </li>
      
      <li class="li_none" style="clear: both;">
        <div style='text-decoration: none;'>
          <br>
          검색어(키워드): ${search }
        </div>
      </li>
      
      <li class="li_none">
        <div>
          <c:if test="${file1.trim().length() > 0 }">
            첨부 파일: <a href='/download?dir=/pill/storage&filename=${file1saved}&downname=${file1}'>${file1}</a> (${size1_label}) 
            <a href='/download?dir=/pill/storage&filename=${file1saved}&downname=${file1}'><img src="/pill/images/download.png"></a>
          </c:if>
        </div>
      </li> 
      
      <li class="li_none" style="clear: both;">
        <c:if test="${sessionScope.id != null }">
          <form name='frm' method='post' action='#' enctype="multipart/form-data">
            <div class="content_body_bottom">
              <button type="submit" class="btn btn-secondary btn-sm">내 알약 등록</button>
            </div>
          </form>
        </c:if>
      </li>
      
      
    </ul>
  </fieldset>

</div>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>