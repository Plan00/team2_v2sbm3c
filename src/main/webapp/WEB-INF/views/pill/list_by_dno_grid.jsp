<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
<title>http://localhost:9093/pill/list_all.do</title>
<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
  
</head>
<body>
<c:import url="/menu/top.do" />
  <div class='title_line'>
    ${diseaseVO.dname }
    <c:if test="${param.search.length() > 0 }">
      > 「${param.search }」 검색 ${search_count } 건
    </c:if> 
  </div>
  
  <aside class="aside_right">
    <%-- 관리자로 로그인해야 등록 가능 --%>
    <c:if test="${sessionScope.manager_id != null }">
      <a href="./create.do?dno=${diseaseVO.dno }">등록</a>
      <span class='menu_divide' >│</span>
    </c:if>
    <a href="javascript:location.reload();">새로고침</a>
        <span class='menu_divide' >│</span>    
    <A href="./list_by_dno.do?dno=${param.dno }&now_page=${param.now_page == null ? 1 : param.now_page }&search=${param.search }">목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_dno_grid.do?dno=${param.dno }&now_page=${param.now_page == null ? 1 : param.now_page }&search=${param.search }">갤러리형</A>
  </aside>
  
  <div style="text-align: right; clear: both;">  
      <form name='frm' id='frm' method='get' action='./list_by_dno.do'>
        <input type='hidden' name='dno' value='${param.dno }'>  <%-- 게시판의 구분 --%>
        
        <c:choose>
          <c:when test="${param.search != '' }"> <%-- 검색하는 경우는 검색어를 출력 --%>
            <input type='text' name='search' id='search' value='${param.search }'>
          </c:when>
          <c:otherwise> <%-- 검색하지 않는 경우 --%>
            <input type='text' name='search' id='search' value=''>
          </c:otherwise>
        </c:choose>
        <button type='submit' class='btn btn-secondary btn-sm' style="padding: 2px 8px 3px 8px; margin: 0px 0px 2px 0px;">검색</button>
        <c:if test="${param.search.length() > 0 }"> <%-- 검색 상태하면 '검색 취소' 버튼을 출력 --%>
          <button type='button' class='btn btn-secondary btn-sm' style="padding: 2px 8px 3px 8px; margin: 0px 0px 2px 0px;"
                      onclick="location.href='./list_by_dno.do?dno=${param.dno}&search='">검색 취소</button>  
        </c:if>    
      </form>
    </div>
      
    <div class="menu_line"></div> 
    
    <div style='width: 100%;'> <%-- 갤러리 Layout 시작 --%>
    <c:forEach var="pillVO" items="${list }" varStatus="status">
      <c:set var="pill_name" value="${pillVO.pill_name }" />
      <c:set var="efficacy" value="${pillVO.efficacy }" />
      <c:set var="dno" value="${pillVO.dno }" />
      <c:set var="pill_no" value="${pillVO.pill_no }" />
      <c:set var="thumb1" value="${pillVO.thumb1 }" />
      <c:set var="size1" value="${pillVO.size1 }" />
        
      <!-- 4기준 하나의 이미지, 24 * 4 = 96% -->
      <!-- 5기준 하나의 이미지, 19.2 * 5 = 96% -->
      <div onclick="location.href='./read.do?pill_no=${pill_no}&search=${param.search }&now_page=${param.now_page == null ? 1 : param.now_page }&dno=${param.dno }'" 
        style='width: 19%; height: 200px; float: left; margin: 0.5%; padding: 0.5%; background-color: #EEEFFF; text-align: left; cursor: pointer;'>
        
        <c:choose> 
          <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> <%-- 이미지인지 검사 --%>
            <%-- registry.addResourceHandler("/pill/storage/**").addResourceLocations("file:///" +  Contents.getUploadDir()); --%>
            <img src="/pill/storage/${thumb1 }" style="width: 100%; height: 120px;">
          </c:when>
          <c:otherwise> <!-- 이미지가 없는 경우 기본 이미지 출력: /static/pill/images/none1.png -->
            <IMG src="/pill/images/none1.png" style="width: 100%; height: 120px;">
          </c:otherwise>
        </c:choose>
        ${pill_name }
        
      </div>
      
      <%-- 하나의 행에 이미지를 5개씩 출력후 행 변경, index는 0부터 시작 --%>
      <c:if test="${status.count % 5 == 0  }"> 
        <HR class='menu_line'> <%-- 줄바꿈 --%>
      </c:if>
      
    </c:forEach>
  </div>
  
  <!-- 페이지 목록 출력 부분 시작 -->
  <div class='bottom_menu'>${paging }</div> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
 
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>