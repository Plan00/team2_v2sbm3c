<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dev.mvc.disease.DiseaseVO" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
<title>http://localhost:9093/disease/read.do?dno=1</title>
<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
  
</head>
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

<div class='title_line'>질병 카테고리 조회</div>
  <%
  DiseaseVO diseaseVO = (DiseaseVO)request.getAttribute("diseaseVO");
  %>
  <div class="container mt-3">
    <ul class="list-group list-group-flush">
      <li class="list-group-item">번호: <%=diseaseVO.getDno() %></li>
      <li class="list-group-item">이름: <%=diseaseVO.getDname() %></li>
      <li class="list-group-item">등록 글수: <%=diseaseVO.getCnt() %></li>
      <li class="list-group-item">등록일: <%=diseaseVO.getRdate() %></li>
    </ul>
  </div>

  <div class="content_body_bottom">
    <button type="button" onclick="location.href='./create.do'" class="btn btn-secondary btn-sm">등록</button>
    <button type="button" onclick="location.href='./list_all.do'" class="btn btn-secondary btn-sm">목록</button> 
  </div>
 
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>