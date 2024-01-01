<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="qna_no" value="${qnaVO.qna_no }" />
<c:set var="qna_title" value="${qnaVO.qna_title }" />
<c:set var="qna_date" value="${qnaVO.qna_date }" />
<c:set var="qna_main" value="${qnaVO.qna_main }" />

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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>
$(document).ready(function () {
    // 페이지 로딩 시에는 버튼 영역을 감춤
    $("#answerBtnArea").hide();

    // "답변 보기" 버튼 클릭 이벤트 처리
    $("#showAnswerBtn").on("click", function () {
        // Ajax 통신
        $.ajax({
            url: "/answer/read_by_qna_no.do",
            method: "GET",
            data: { qna_no: "${qna_no}" },
            success: function (response) {
                // 서버에서의 응답을 처리
                if (response.answerVO) {
                    // 답변이 있는 경우
                    $("#answerContainer").html(response.answerVO.amain);
                    // 답변이 있을 때는 "답변 수정하기" 버튼을 보이고 "답변 작성하기" 버튼을 숨김
                    $("#editAnswerBtn").show();
                    // "답변 수정하기" 버튼 클릭 이벤트 처리에 ano 전달
                    $("#editAnswerBtn").on("click", function () {
                        // ano 값을 가져와서 URL에 추가
                        var ano = response.answerVO.ano;
                        window.location.href = "/answer/update_text.do?ano=" + ano + "&qna_title=${qna_title}&qna_no=${qna_no}";
                    });
                    $("#writeAnswerBtn").hide();
                    // 답변이 있을 때는 "답변 삭제하기" 버튼을 보이도록 처리
                    $("#deleteAnswerBtn").show();
                    // "답변 삭제하기" 버튼 클릭 이벤트 처리
                    $("#deleteAnswerBtn").on("click", function () {
                        if (confirm("답변을 삭제하시겠습니까?")) {
                            // 확인 시 삭제 처리
                            var ano = response.answerVO.ano;
                            var qna_title = "${qna_title}";
                            window.location.href = "/answer/delete.do?ano=" + ano + "&qna_title=" + qna_title;
                        }
                    });
                    
                } else {
                    // 답변이 없는 경우
                    $("#answerContainer").html("아직 답변이 등록되지 않았습니다.");
                    // 답변이 없을 때는 "답변 작성하기" 버튼을 보이고 "답변 수정하기" 버튼을 숨김
                    $("#writeAnswerBtn").show();
                    $("#editAnswerBtn").hide();
                    // "답변 작성하기" 버튼 클릭 이벤트 처리
                    $("#writeAnswerBtn").on("click", function () {
                        window.location.href = "/answer/create.do?qna_no=${qna_no}&qna_title=${qna_title}";
                    });
                    // 답변이 없을 때는 "답변 삭제하기" 버튼을 숨기도록 처리
                    $("#deleteAnswerBtn").hide();
                }
                // 버튼 영역을 보이도록 처리
                $("#answerBtnArea").show();
            },
            error: function () {
                // 에러 처리
                console.error("Ajax 요청 중 에러 발생");
            },
        });
    });

    

    
});
</script>
</head> 
 
<body>
<c:import url="/menu/top.do" />
  <DIV class='title_line'><A href="./list_all.do" class='title_link'>QNA > 세부사항</A></DIV>

  <ASIDE class="aside_right">
    <%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
    <c:if test="${sessionScope.manager_id != null }">
      <A href="./create.do">등록</A>
      <span class='menu_divide' >│</span>
      <A href="./update_text.do?qna_no=${qna_no}&now_page=${param.now_page}">QNA 수정</A>
      <span class='menu_divide' >│</span>
      <A href="./delete.do?qna_no=${qna_no}&now_page=${param.now_page}">삭제</A>  
      <span class='menu_divide' >│</span>
    </c:if>
    
    <c:if test="${sessionScope.manager_id != null }">
    
    </c:if>
    
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>    
    <A href="./list_search.do?dno=${dno }&now_page=${param.now_page}&search=${param.search }">목록형</A>    
  </ASIDE> 
  
  <DIV class='menu_line'></DIV>

  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">
        <DIV style="width: 100%; word-break: break-all;">
          <span style="font-size: 1.5em; font-weight: bold;">${qna_title }</span>
          <span style="font-size: 1em;"> ${qna_date }</span><br>
          내용: ${qna_main }
        </DIV>
        
        <DIV id="answer_line" class='menu_line'></DIV>
        
        <button id="showAnswerBtn" class="btn btn-secondary btn-sm">답변 보기</button><br><br>
        <div id="answerContainer"></div><br>
        
        <%-- 답변이 있을 때, 없을 때의 버튼 영역 --%>
        <div id="answerBtnArea" style="display: none;">
          <button id="editAnswerBtn" onclick="location.href='/answer/update_text.do?ano=${answerVO.ano}&qna_no=${qna_no}&qna_title=${qna_title}'" class="btn btn-secondary btn-sm">답변 수정하기</button>
          <button id="writeAnswerBtn" class="btn btn-secondary btn-sm">답변 작성하기</button>
          <button id="deleteAnswerBtn" class="btn btn-secondary btn-sm">답변 삭제하기</button>
        </div>
        
      </li>

    </ul>
  </fieldset>

</div>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>