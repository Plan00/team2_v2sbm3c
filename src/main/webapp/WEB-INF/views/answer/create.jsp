<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>http://localhost:9093/answer/create.do</title>
<link rel="shortcut icon" href="/images/shortcut.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
</script>
  
</head>
 
<body>
<c:import url="/menu/top.do" />
 
  <div class='title_line'>${param.qna_title} > 답변 등록</div>
  
  <aside class="aside_right">
    <a href="./create.do">등록</a>
    <span class='menu_divide' >│</span>
    <a href="javascript:location.reload();">새로고침</a>
  </aside>
  
  <div class='menu_line'></div>
  
  <form id='frm' name='frm' method='post' action='./create.do' enctype="multipart/form-data">
    <input type="hidden" name="qna_no" value="${param.qna_no}" />
    <input type="hidden" name="manager_no" value="${sessionScope.manager_no}" />
    
    <div>
       <label>답변 내용</label>
       <textarea name='amain' required="required" class="form-control" rows="12" style='width: 100%;'></textarea>
    </div>
    <div class="content_body_bottom">
      <button type="submit" class="btn btn-secondary btn-sm">등록</button>
      <button type="button" onclick="history.back()" class="btn btn-secondary btn-sm">뒤로 가기</button>
    </div>
  
  </form>

 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
