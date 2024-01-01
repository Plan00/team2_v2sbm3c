<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="ano" value="${answerVO.ano }" />
<c:set var="qna_title" value="${qnaVO.qna_title }" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
<title>http://localhost:9093/</title>
<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
  
</head>
<body>
<c:import url="/menu/top.do" />
  <DIV class='title_line'> ${param.qna_title } > 답변 삭제</DIV>
  
  <aside class="aside_right">
    <a href="javascript:location.reload();">새로고침</a>
  </aside>
  
  <div class='menu_line'></div>

  <fieldset class="fieldset_basic" style="text-align: center;">
    <ul>
      <li class="li_none" >

        <DIV style='text-align: center; width:100%;'>
          <br>
          <FORM name='frm' method='post' action='./delete.do' style="text-align: center;">
              <input type='hidden' name='ano'  value='${ano}'>
              <br><br>
              <div style='text-align: center; margin: 10px auto;'>
                <span style="color: #FF0000; font-weight: bold;">등록된 답변을 삭제합니다.</span><br><br>
                <br><br>
                <button type = "submit" class="btn btn-secondary btn-sm">삭제 진행</button>
                <button type = "button" onclick = "history.back()" class="btn btn-secondary btn-sm">취소</button>
              </div>   
          </FORM>
        </DIV>
      </li>
     </ul>
  </fieldset>
 
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>