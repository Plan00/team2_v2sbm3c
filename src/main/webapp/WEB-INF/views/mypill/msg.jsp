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

<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

</head> 
<body>
<c:import url="/menu/top.do" />

<div class='title_line'>알림</div>

<div class='message'>
  <fieldset class='fieldset_basic'>
    <ul>
      <c:choose>
        <c:when test="${param.code == 'create_success'}"> <%-- Java if --%>
          <li class='li_none'>
            <span class="span_success">내 알약에 등록했습니다.</span>
          </li>  
          <li class='li_none'>
            <button type='button' 
                         onclick="location.href='/'"
                         class="btn btn-secondary btn-sm">시작 화면</button>
          </li> 
        </c:when>
        
        <c:when test="${param.code == 'create_fail'}"> <%-- Java if --%>
          <li class='li_none'>
            <span class="span_fail">내 알약 등록에 실패했습니다.</span>
          </li>
          <li class='li_none'>
            <button type='button' 
                         onclick="location.href='/'"
                         class="btn btn-secondary btn-sm">시작 화면</button>
          </li>                                                                      
        </c:when>

        <c:when test="${param.code == 'already'}"> <%-- Java if --%>
          <li class='li_none'>
            <span class="span_fail">이미 등록된 알약입니다. <br>다시 시도해주세요.</span>
          </li>
          <li class='li_none'>
            <button type='button' 
                         onclick="location.href='/'"
                         class="btn btn-secondary btn-sm">시작 화면</button>
          </li>                                                                      
        </c:when>
        
        <c:otherwise>
          <li class='li_none_left'>
            <span class="span_fail">알 수 없는 에러로 작업에 실패했습니다.</span>
          </li>
          <li class='li_none_left'>
            <span class="span_fail">다시 시도해주세요.</span>
          </li>
        </c:otherwise>
        
      </c:choose>
      <li class='li_none'>
        <br>
        <c:choose>
            <c:when test="${param.cnt == 0 }">
                <button type='button' onclick="history.back()" class="btn btn-secondary btn-sm">다시 시도</button>    
            </c:when>
        </c:choose>
        

      </li>
    </ul>
  </fieldset>

</div>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>