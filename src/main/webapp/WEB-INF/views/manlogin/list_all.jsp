<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
<title>http://localhost:9093/manlogin/list_all.do</title>
<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
  
</head>
<body>
<c:import url="/menu/top.do" />
  <%int manager_no = (int)session.getAttribute("manager_no"); %>
  <div class='title_line'>전체 관리자 로그인 내역</div><br>
  현재 관리자 번호: <%=manager_no %>
  
  <aside class="aside_right">
    <a href="javascript:location.reload();">새로고침</a>
  </aside>
  <div class="menu_line"></div> 
  
  <table class="table table-hover">
    <colgroup>
        <col style='width: 10%;'/>
        <col style='width: 10%;'/>    
        <col style='width: 20%;'/>
        <col style='width: 20%;'/>
      </colgroup>
      <thead>
        <tr>
          <th class="th_bs">로그인 번호</th>
          <th class="th_bs">관리자 번호</th>
          <th class="th_bs">IP</th>
          <th class="th_bs">로그인 일자</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="manloginVO" items="${list }" varStatus="info">
          <c:set var="manloginno" value="${manloginVO.manloginno }" />
          <c:set var="manager_no" value="${manloginVO.manager_no }" />
    
          <tr>
          <td class="td_bs">${manloginno }</td>
          <td class="td_bs">${manager_no }</td>
          <td class="td_bs">${manloginVO.ip }</td>
          <td class="td_bs">${manloginVO.ldate.substring(0, 10) }</td>
        </tr>
      </c:forEach>
      </tbody>
      
  </table>
 
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>
