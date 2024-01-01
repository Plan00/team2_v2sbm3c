<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
<title>http://localhost:9093/disease/list_all.do</title>
<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
  
</head>
<body>
<c:import url="/menu/top.do" />

  <div class='title_line'>질병 카테고리</div>
  
  <aside class="aside_right">
    <a href="./create.do?dno=${diseaseVO.dno }">등록</a>
    <span class='menu_divide' >│</span>
    <a href="javascript:location.reload();">새로고침</a>
  </aside>
  <div class="menu_line"></div> 
  
  <form name='frm' method='post' action='/disease/create.do'>
    <div style="text-align: center;">
      <label>질병 이름</label>
      <input type="text" name="dname" value="" required="required" autofocus="autofocus" 
                 class="" style="width: 50%">
      <button type="submit" class="btn btn-secondary btn-sm" style="height: 28px; margin-bottom: 5px;">등록</button>
      <button type="button" onclick="location.href='./list_all.do'" class="btn btn-secondary btn-sm" 
                  style="height: 28px; margin-bottom: 5px;">목록</button> 
    </div>
  </form>
  
  <table class="table table-hover">
    <colgroup>
        <col style='width: 10%;'/>
        <col style='width: 40%;'/>
        <col style='width: 10%;'/>    
        <col style='width: 20%;'/>
        <col style='width: 20%;'/>
      </colgroup>
      <thead>
        <tr>
          <th class="th_bs">순서</th>
          <th class="th_bs">카테고리 이름</th>
          <th class="th_bs">자료수</th>
          <th class="th_bs">등록일</th>
          <th class="th_bs">기타</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="diseaseVO" items="${list }" varStatus="info">
          <c:set var="dno" value="${diseaseVO.dno }" />
          <c:set var="seqno" value="${diseaseVO.seqno }" />
    
          <tr>
          <td class="td_bs">${seqno }</td>
          <td><a href="../issue/list_by_dno.do?dno=${dno }" style="display: block;">${diseaseVO.dname }</a></td>
          <td class="td_bs">${diseaseVO.cnt }</td>
          <td class="td_bs">${diseaseVO.rdate.substring(0, 10) }</td>
          <td class="td_bs">
            <a href="../pill/create.do?dno=${dno }" title="등록"><img src="/cate/images/create.png" class="icon"></a>
            <c:choose>
              <c:when test="${diseaseVO.visible == 'Y' }">
                <a href="./update_visible_n.do?dno=${dno }" title="카테고리 공개 설정"><img src="/cate/images/show.png" class="icon"></a>
              </c:when>
              <c:otherwise>
                <a href="./update_visible_y.do?dno=${dno }" title="카테고리 비공개 설정"><img src="/cate/images/hide.png" class="icon"></a>
              </c:otherwise>
            </c:choose>
            <a href="./update_seqno_forward.do?dno=${dno }" title="우선 순위 높임"><img src="/cate/images/decrease.png" class="icon"></a>
            <a href="./update_seqno_backward.do?dno=${dno }" title="우선 순위 낮춤"><img src="/cate/images/increase.png" class="icon"></a>
            <a href="./update.do?dno=${dno }" title="수정"><img src="/cate/images/update.png" class="icon"></a>
            <a href="./delete.do?dno=${dno }" title="삭제"><img src="/cate/images/delete.png" class="icon"></a>
          </td>
        </tr>
      </c:forEach>
      </tbody>
      
  </table>
 
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>
