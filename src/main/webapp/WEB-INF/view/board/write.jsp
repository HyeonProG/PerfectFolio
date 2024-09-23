<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<link rel="stylesheet" href="/css/board.css">

<div class="sub--banner">
  <h1>문의사항 작성 페이지</h1>
</div>
<!-- s: container -->
<div class="container">
<c:choose>
<c:when test="${principal != null }">
<div class="container">
  <form action="/board/write" method="post">
  
    <div class="form-group">
      <label for="sel1">문의유형</label>
      <select class="form-control" id="sel1" name="category">
        <option>회원정보</option>
        <option>구독/결제</option>
        <option>포트폴리오</option>
      </select>
    </div>
    
<div class="form-group">
  <label for="title">제목</label>
  <input type="text" class="form-control" id="title" name = "title">
</div>

<div class="form-group">
  <label for="">작성자</label>
  <input type="text" class="form-control" id="writer" value="${principal.username}" name = "writer" readonly>
  <input type ="hidden" value="${principal.id}" name = "userId">
</div>

<div class="form-group">
  <label for="">작성일</label>
  <input type="text" class="form-control" id="currentDate" name="createdAt" readonly>
</div>

<div class="form-group">
  <label for="content">내용</label>
  <textarea class="form-control" rows="5" id="content" name="content" minlength="10" maxlength="255"></textarea>
</div>

<button type="submit" class="btn btn-info">작성완료</button>
    
  </form>
</div>
</c:when>
<c:otherwise>
<p>이용 권한이 없습니다.</p>
</c:otherwise>
</c:choose>
</div>
<script>
  document.getElementById('currentDate').value = new Date().toISOString().substring(0, 10);
</script>

<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/layout/darkFooter.jsp"%>