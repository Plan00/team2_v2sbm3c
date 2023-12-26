<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>http://localhost:9093/qna/create.do</title>
<link rel="shortcut icon" href="/images/shortcut.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
  function send() {
    var confirmResult = confirm("QNA는 등록되면 삭제나 수정이 제한됩니다. 등록하시겠습니까?");
    if (confirmResult) {
      // 사용자가 '확인'을 누른 경우
      document.getElementById('frm').submit();
    }
    // 사용자가 '취소'를 누른 경우, 폼 제출이 중지됩니다.
  }
</script>
  
</head>
 
<body>
<c:import url="/menu/top.do" />
 
  <div class='title_line'>QNA 등록</div>
  
  <aside class="aside_right">
    <a href="./create.do">등록</a>
    <span class='menu_divide' >│</span>
    <a href="javascript:location.reload();">새로고침</a>
  </aside>
  
  <div class='menu_line'></div>
  
  <form id='frm' name='frm' method='post' action='./create.do' enctype="multipart/form-data">
    <div>
       <label>제목</label>
       <input type='text' name='qna_title' value='' required="required" 
                 autofocus="autofocus" class="form-control" style='width: 100%;'>
    </div>
    <div>
       <label>내용</label>
       <textarea name='qna_main' required="required" class="form-control" rows="12" style='width: 100%;'></textarea>
    </div>
    <div>
       <label>패스워드</label>
       <input type='password' name='qna_passwd' value='' required="required" 
                 class="form-control" style='width: 50%;'>
    </div>   
    <div class="content_body_bottom">
      <button type="button" onclick="send()" class="btn btn-secondary btn-sm">등록</button>
      <button type="button" onclick="location.href='./list_paging.do'" class="btn btn-secondary btn-sm">목록</button>
    </div>
  
  </form>

 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>