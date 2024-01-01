<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
  <title>http://localhost:9093/</title>
  <link rel="shortcut icon" href="/images/shortcut.png" /> <%-- /static 기준 --%>
  <link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
  <style>
    .image-container {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
    }

    .image-box {
      margin: 10px;
      padding: 10px;
      text-align: center;
      border: 5px solid #ccc;
      border-radius: 10px;
      width: 100%;
      text-align: center;
    }

    .image-container img {
      width: 100%;
      height: auto;
      max-width: 100%; /* 이미지가 부모 요소에 맞게 표시되도록 설정 */
      margin-bottom: 10px;
    }

    .page-info {
      text-align: center;
      font-weight: bold;
    }

    .section-title {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 20px;
    }
    
  </style>
</head>
<body>
  <c:import url="/menu/top.do" />

  <div class="container">
    <div class="section-title mb-4">약품 관련 사이트</div>
    <div class="row">
      <!-- 첫 번째 이미지와 링크 -->
      <div>
        <div class="image-box">
          <a href="https://www.health.kr/">
            <img src="/main/약학정보원.png" alt="약학정보원">
          </a>
          <div class="page-info">
            <p>약학정보원 - <a href="https://www.health.kr/">https://www.health.kr/</a></p>
          </div>
        </div>
      </div>
    </div>

    <div class="row">
      <!-- 두 번째 이미지와 링크 -->
      <div>
        <div class="image-box">
          <a href="https://www.druginfo.co.kr/">
            <img src="/main/드러그인포.jpg" alt="드러그인포">
          </a>
          <div class="page-info">
            <p>드러그인포 - <a href="https://www.druginfo.co.kr/">https://www.druginfo.co.kr/</a></p>
          </div>
        </div>
      </div>
    </div>

    <div class="row">
      <!-- 세 번째 이미지와 링크 -->
      <div>
        <div class="image-box">
          <a href="https://health.seoulmc.or.kr/">
            <img src="/main/서울시민건강포털.png" alt="서울시민건강포털">
          </a>
          <div class="page-info">
            <p>서울시민건강포털 - <a href="https://health.seoulmc.or.kr/">https://health.seoulmc.or.kr/</a></p>
          </div>
        </div>
      </div>
    </div>

    <div class="row">
      <!-- 네 번째 이미지와 링크 -->
      <div>
        <div class="image-box">
          <a href="https://www.hira.or.kr/">
            <img src="/main/건강보험심사평가원.png" alt="건강보험심사평가원">
          </a>
          <div class="page-info">
            <p>건강보험심사평가원 - <a href="https://www.hira.or.kr/">https://www.hira.or.kr/</a></p>
          </div>
        </div>
      </div>
    </div>
  </div>

  <jsp:include page="./menu/bottom.jsp" flush='false' /> 
</body>
</html>
