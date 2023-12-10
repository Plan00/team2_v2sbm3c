<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
<title>http://localhost:9093/disease/create.do</title>
<link rel="shortcut icon" href="/images/shortcut.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
<c:import url="/menu/top.do" />
<div class='title_line'>카테고리 등록</div>

<form name="frm" method="post" action="/disease/create.do">
  <div>
    <label>카테고리 이름</label>
    <input type="text" name="dname" value="" required="required" autofocus="autofocus" 
    class="form-control form-control-sm" style="width: 50%">
  </div>
  <div class="content_body_bottom">
    <button type="submit" class="btn btn-secondary btn-sm">등록</button>
    <button type="button" class="btn btn-secondary btn-sm">목록</button>
  </div>
</form>
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>