<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
<title>http://localhost:9093/qna/list_all.do</title>
<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
  
</head>
<body>
<c:import url="/menu/top.do" />
<div class='title_line'>전체 QNA 목록</div>

<aside class="aside_right">
  <a href="javascript:location.reload();">새로고침</a>
</aside>
<div class="menu_line"></div>

<table class="table table-hover">
  <colgroup>
      <col style="width: 80%;"></col>
      <col style="width: 10%;"></col>
  </colgroup>
  <thead>
    <tr>
      <th style='text-align: center;'>제목</th>
      <th style='text-align: center;'>기타</th>
    </tr>
  </thead>
  
  <tbody>
    <c:forEach var="qnaVO" items="${list }" varStatus="info">
      <c:set var="qna_no" value="${qnaVO.qna_no }" />
      
      <tr onclick="location.href='./read.do?qna_no=${qna_no}'" style="cursor: pointer;">
        <td class="td_bs_left">
          <span style="font-weight: bold;">${qnaVO.qna_title }</span><br>
          <c:choose>
            <c:when test="${qnaVO.qna_title.length() > 160 }">
              ${qnaVO.qna_title.substring(0, 160) }...
            </c:when>
            <c:otherwise>
              ${qnaVO.qna_title }
            </c:otherwise>
          </c:choose>
           ${qnaVO.qua_date.substring(0, 16) }
        </td>
        <td class="td_bs">
            <a href="/qna/delete.do?qna_no=${qna_no }&now_page=${param.now_page }" title="삭제"><img src="/cate/images/delete.png" class="icon"></a>
          </td>
      </tr>
    </c:forEach>
  </tbody>
    
</table>
 
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>