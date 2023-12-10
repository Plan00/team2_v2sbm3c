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
<div class='title_line'>전체 글 목록</div>

<aside class="aside_right">
  <a href="javascript:location.reload();">새로고침</a>
</aside>
<div class="menu_line"></div> 

<table class="table table-hover">
  <colgroup>
      <col style="width: 10%;"></col>
      <col style="width: 80%;"></col>
      <col style="width: 10%;"></col>
  </colgroup>
  <thead>
    <tr>
      <th style='text-align: center;'>파일</th>
      <th style='text-align: center;'>제목</th>
      <th style='text-align: center;'>기타</th>
    </tr>
  </thead>
  
  <tbody>
    <c:forEach var="pillVO" items="${list }" varStatus="info">
      <c:set var="pill_no" value="${pillVO.pill_no }" />
      <c:set var="thumb1" value="${pillVO.thumb1 }" />
      
      <tr onclick="location.href='./read.do?pill_no=${pill_no}'" style="cursor: pointer;">
        <td>
          <c:choose>
            <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
              <img src="/pill/storage/${thumb1 }" style="width: 120px; height: 90px;">
            </c:when>
            <c:otherwise>
              <img src="/pill/images/none1.png" style="width: 120px; height: 90px;">
            </c:otherwise>
          </c:choose>
        </td>
        <td class="td_bs_left">
          <span style="font-weight: bold;">${pillVO.pill_name }</span><br>
          <c:choose>
            <c:when test="${pillVO.pill_name.length() > 160 }">
              ${pillVO.pill_name.substring(0, 160) }...
            </c:when>
            <c:otherwise>
              ${pillVO.pill_name }
            </c:otherwise>
          </c:choose>
           ${pillVO.rdate.substring(0, 16) }
        </td>
        <td class="td_bs">
            <a href="/pill/delete.do?pill_no=${pill_no }&now_page=${param.now_page }&dno=${dno }" title="삭제"><img src="/pill/images/delete.png" class="icon"></a>
          </td>
      </tr>
    </c:forEach>
  </tbody>
    
</table>
 
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>