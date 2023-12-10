<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
  .top_menu_link:link{  /* 방문전 상태 */
    text-decoration: none; /* 밑줄 삭제 */
    color: #FFFFFF;
    font-weight: bold;
  }

  .top_menu_link:visited{  /* 방문후 상태 */
    text-decoration: none; /* 밑줄 삭제 */
    color: #FFFFFF;
    font-weight: bold;
  }

  .top_menu_link:hover{  /* A 태그에 마우스가 올라간 상태 */
    text-decoration: none; /* 밑줄 출력 */
    color: #FFFFFF;
    font-size: 1.05em;
  }
</style> 

<div class='container_main'>
  <div class='top_img'>
    <div class="top_menu_label">알약 정보 사이트</div>      
  </div> <!-- <div class='top_img'></div> 종료 -->
  
  <nav class="navbar navbar-expand-md navbar-dark navbar-custom">
    <a class="navbar-brand" href="/"><img src='/css/images/home.png' title="시작페이지" style='display: block; padding-left: 5px;'></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle Navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarCollapse">
          <ul class="navbar-nav mr-auto">
            <%-- 게시판 목록 출력 --%>
              <c:forEach var="diseaseVO" items="${list_top }">
                <c:set var="dno" value="${diseaseVO.dno }" />
                <c:set var="dname" value="${diseaseVO.dname }" />
                <li class="nav-item"> <%-- 서브 메뉴가 없는 독립메뉴 --%>
                <a class="nav-link top_menu_link" href="/pill/list_by_dno.do?dno=${diseaseVO.dno }&now_page=1">${diseaseVO.dname }</a> 
              </li>
            </c:forEach>
            
            <li class="nav-item"> <%-- 서브 메뉴가 없는 독립메뉴 --%>
              <a class="nav-link top_menu_link" href="/pill/list_all.do">전체 글 목록</a>
            </li>
            
            <li class="nav-item dropdown"> <%-- 회원 서브 메뉴 --%>
              <a class="nav-link top_menu_link dropdown-bs-toggle" data-bs-toggle="dropdown" href="#">회원</a>
              <div class="dropdown-menu">
                <c:choose>
                  <c:when test="${sessionScope.id == null }">
                    <a class="dropdown-item" href="/mem/create.do">회원 가입</a>
                    <a class="dropdown-item" href="#">아이디 찾기</a>
                    <a class="dropdown-item" href="#">비밀번호 찾기</a>
                  </c:when>
                  <c:otherwise>
                    <a class="dropdown-item" href="/mem/read.do">가입 정보</a>
                    <a class="dropdown-item" href="/mem/passwd_update.do">비밀번호 변경</a>
                    <a class="dropdown-item" href="/mem/read.do">회원 정보 수정</a>
                    <a class="dropdown-item" href="javascript: alert('개발 예정')">로그인 내역</a>
                    <a class="dropdown-item" href="#">회원 탈퇴</a>
                  </c:otherwise>
                </c:choose>
              </div>
            </li>
            
            <c:choose>
              <c:when test="${sessionScope.manager_id == null }">
                <li class="nav-item">
                  <a class="nav-link top_menu_link" href="/manager/login.do">관리자 로그인</a>
                </li>
              </c:when>
              <c:otherwise>
                <li class="nav-item dropdown"> <%-- 관리자 서브 메뉴 --%>
                  <a class="nav-link top_menu_link dropdown-toggle" data-bs-toggle="dropdown" href="#">관리자</a>
                  <div class="dropdown-menu">
                    <a class="dropdown-item" href='/disease/list_all.do'>카테고리 전체 목록</a>
                    <a class="dropdown-item" href='/mem/list.do'>회원 목록</a>
                    <a class="dropdown-item" href='/manager/logout.do'>관리자 ${sessionScope.manager_id } 로그아웃</a>
                  </div>
                </li>
              </c:otherwise>
            </c:choose>
            
            <li class="nav-item"> <%-- 서브 메뉴가 없는 독립메뉴 --%>
              <c:choose>
                  <c:when test="${sessionScope.id == null}">
                      <a class="nav-link top_menu_link" href="/mem/login.do">로그인</a>
                  </c:when>
                  <c:otherwise>
                      <a class="nav-link top_menu_link" href='/mem/logout.do'>${sessionScope.id } 로그아웃</a>
                  </c:otherwise>
              </c:choose>
            </li>     
          </ul>
      </div>    
  </nav>
    
  <div class='content_body'> <!--  내용 시작 -->