<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- header.jsp  -->
<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/notice.css">
<!-- sub banner -->
<div class="sub--banner"></div>

<!-- s: container -->
<div class="container">

	<c:if test="${notice.id != null}">
		<form action="/notice/update" method="post">
			<div class="categories">
				<select name="categories" id="categories">
					<option value="업데이트">업데이트</option>
					<option value="공지사항">공지사항</option>
					<option value="이벤트">이벤트</option>
					<option value="기타">기타</option>
					<option value="점검">점검</option>
				</select>
			</div>
			<input type="hidden" name="id" value="${notice.id}">
			<div class="title">
				<p>제목</p>
				<input type="text" name="title" style="width: 900px;"
					value="${notice.title}">
			</div>
			<div class="content--container">
				<p>내용</p>
				<textarea name="content" cols="100" rows="20">${notice.content}</textarea>
			</div>

			<c:if test="${admin != null}">
				<!-- 버튼 -->
				<button type="submit" class="btn btn-primary">수정하기</button>
			</c:if>
		</form>
	</c:if>
</div>

<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/layout/darkFooter.jsp"%>