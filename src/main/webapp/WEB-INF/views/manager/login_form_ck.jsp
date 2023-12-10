<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
 
  <DIV class='title_line'>관리자 로그인</DIV>

  <DIV style='width: 40%; margin: 0px auto;'>
    <FORM name='frm' method='POST' action='./login.do'>
    
      <div class="form_input" style="margin-left: 15%;">
        <label>아이디:</label> 
        <input type='text' class="form-control" name='manager_id' id='manager_id' required="required" 
                  style='width: 80%;' placeholder="아이디" autofocus="autofocus" value="${cookie.ck_manager_id.value }">
        <label>   
          <input type='checkbox' name='id_save' value='Y' ${cookie.ck_manager_id_save.value == 'Y' ? "checked='checked'" : "" }> 저장
        </label>
      </div>   
   
      <div class="form_input" style="margin-left: 15%;">
        <label>패스워드:</label> 
        <input type='password' class="form-control" name='manager_passwd' id='manager_passwd' 
                  required="required" style='width: 80%;' placeholder="패스워드" value="${cookie.ck_manager_passwd.value }">
        <label>
          <input type='checkbox' name='passwd_save' value='Y' ${cookie.ck_manager_passwd_save.value == 'Y' ? "checked='checked'" : "" }> 저장
        </label> 
      </div>   
   
      <div class="form_input_bottom">
        <button type="submit" class="btn btn-secondary">로그인</button>
        <button type="button" onclick="history.back();" class="btn btn-secondary">취소</button>
      </div>
      
    </FORM>
  </DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>