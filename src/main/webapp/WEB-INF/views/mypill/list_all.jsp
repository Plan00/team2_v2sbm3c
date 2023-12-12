<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
<title>http://localhost:9093/mypill/list_all.do</title>
<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
  
</head>
<body>
<c:import url="/menu/top.do" />

  <div class='title_line'>내 알약 목록</div>
  
  <aside class="aside_right">
    <a href="javascript:location.reload();">새로고침</a>
  </aside>
  <div class="menu_line"></div> 
  
  <table class="table table-hover">
    <colgroup>
        <col style='width: 10%;'/>
        <col style='width: 40%;'/>
        <col style='width: 10%;'/>    
        <col style='width: 20%;'/>
        <col style='width: 20%;'/>
      </colgroup>
      <thead>
        <tr>
          <th class="th_bs">순서</th>
          <th class="th_bs">이름</th>
          <th class="th_bs">등록일</th>
          <th class="th_bs">기타</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="mypillVO" items="${list }" varStatus="info">
          <c:set var="mypill_no" value="${mypillVO.mypill_no }" />
    
          <tr>
          <td class="td_bs">${mypill_no }</td>
          <td><a href="../pill/read.do?pill_no=${pill_no }" style="display: block;">${mypillVO.mypill_name }</a></td>
          <td class="td_bs">${mypillVO.mypill_date.substring(0, 10) }</td>
          <td class="td_bs">
            <a href="./delete.do?mypill_no=${mypill_no }" title="삭제"><img src="/cate/images/delete.png" class="icon"></a>
          </td>
        </tr>
      </c:forEach>
      </tbody>
      
  </table>
 
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>
