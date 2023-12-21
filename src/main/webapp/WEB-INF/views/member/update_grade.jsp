<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=5.0, width=device-width" /> 
<title>알약 정보 사이트</title>

<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
  function send() {
    var confirmResult = confirm("정말로 탈퇴하시겠습니까? 계정은 복구되지 않습니다.");
    if (confirmResult) {
      // 사용자가 '확인'을 누른 경우
      document.getElementById('frm').submit();
    }
    // 사용자가 '취소'를 누른 경우
  }
</script>


</head> 


<body>
<c:import url="/menu/top.do" />
  <DIV class='title_line'>회원 탈퇴</DIV>

  <DIV class='content_body'>

  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./list.do'>목록</A>
  </ASIDE> 

  <div class='menu_line'></div>
  
  <div style="width: 60%; margin: 0px auto ">
  <FORM name='frm' id='frm' method='POST' action='./update_grade.do' class="">
    <input type="hidden" name="memberno" value="${memberVO.memberno }">
    
    <div class="form-group"> <%-- 줄이 변경되지 않는 패턴 --%>
      <div class="alert alert-danger" role="alert">
        <h2>${memberVO.id } 계정을 탈퇴합니다.</h2>
      </div>
      <span id='id_msg'></span>
    </div>
    
    <div class="form_input" style="text-align: center;">
      <button type="button" id='btn_send' onclick="send()" class="btn btn-danger btn-sm">탈퇴</button>
      <button type="button" onclick="history.back()" class="btn btn-secondary btn-sm">취소</button>
    </div>

  </FORM>
  </DIV>
  
  </DIV>
  
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>
 