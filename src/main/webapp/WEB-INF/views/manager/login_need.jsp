<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
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
 
  <div class='message'>
    <h4>관리자 로그인이 필요한 페이지입니다.</H4>
    <br><br>
    <button type='button' onclick="location.href='/manager/login.do'" class="btn btn-secondary">관리자 로그인</button>       
  </div>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>