<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
<title>http://localhost:9093/pill/list_all_gallery.do</title>
<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<!-- Fotorama -->
<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
<link href="/jquery/fotorama/fotorama.css" rel="stylesheet"> <!-- /static 기준 -->
<script src="/jquery/fotorama/fotorama.js"></script>
  
</head>
<body>
<c:import url="/menu/top.do" />
<div class='title_line'>Gallery</div>

<aside class="aside_right">
  <a href="javascript:location.reload();">새로고침</a>
</aside>
<div class="menu_line"></div> 

<div style='margin: 0px auto; width: 800px;' >
  <!-- Fotorama data-ratio="100%/66%" -->
  <div class="fotorama"
         data-autoplay="5000"
         data-nav="thumbs"
         data-ratio="800/520"
         data-width="100%">
    <c:forEach var="pillVO" items="${list }" varStatus="info">
    
    <c:set var="file1saved" value="${pillVO.file1saved }" />
        <c:if test="${file1saved.endsWith('jpg') || file1saved.endsWith('png') || file1saved.endsWith('gif')}">
          <img src="/issue/storage/${file1saved }" style="width: 120px; height: 90px;">
        </c:if>
        
    </c:forEach>
    
  </div>
</div>
 
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>