<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<% String root = request.getContextPath(); // context 추출 %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알약 정보 사이트</title>
<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
 
<body>
<c:import url="/menu/top.do" />

<div style='width: 80%; margin: 0px auto;'>
<div class='title_line'>ID 찾기</div>
<form name='mailForm' method='post' action="./send.do">
  <table class='table_basic'>
    <colgroup>
      <col style='width: 20%;' />   <!-- 출력 순서 -->
      <col style='width: 80%;' /> <!-- 제목 -->
    </colgroup>
    <tr>
      <th class='th_basic'>성명</th>
      <td class='td_left'><input type="text" name="mname" value='' class='input_basic' style='width: 50%;'></td>
    </tr>
    <tr>
      <th class='th_basic'>전화번호</th>
      <td class='td_left'><input type="text" name="tel" value='' class='input_basic' style='width: 90%;'></td>
  </tr>
</table>
 
<div  class="bottom_menu">
  <input type="submit" value="보내기">
  <input type="button" value="취소" onclick="history.back()">
</div>
</form>
</div>
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>