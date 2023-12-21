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
        
<script type="text/javascript">
  window.onload = ()=> {
    document.getElementById('btn_retry').addEventListener('click', () => {
      location.href="./login.do";
    });

    document.getElementById('btn_home').addEventListener('click', () => {
      location.href="../index.do";
    });
  }

</script>
 
</head> 
<body>
<c:import url="/menu/top.do" />
 
<DIV class='title_line'>알림</DIV>
  <DIV class='message'>
    <fieldset class='fieldset_basic'>
      <ul>
        <c:choose>
          <c:when test="${param.code == 'del_member'}">
            <li class='li_none'>탈퇴한 회원입니다.</li>
            <li class='li_none'>
              <button type="button" id="btn_retry" class="btn btn-secondary btn-sm">로그인 다시 시도</button>
              <button type="button" id="btn_home" class="btn btn-secondary btn-sm">확인</button>
            </li>
          </c:when>
          <c:when test="${param.code == 'not_match'}">
            <li class='li_none'>회원 로그인에 실패했습니다.</li>
            <li class='li_none'>ID 또는 패스워드가 일치하지 않습니다.</li>
            <li class='li_none'>
              <button type="button" id="btn_retry" class="btn btn-secondary btn-sm">로그인 다시 시도</button>
              <button type="button" id="btn_home" class="btn btn-secondary btn-sm">확인</button>
            </li>
          </c:when>
        </c:choose>
      </ul>
    </fieldset>    
  </DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>