<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/notice.css">
<!-- sub banner -->
<div class="sub--banner"></div>

<!-- s: container -->
<div class="container">

	<form action="/notice/create" method="post">
		<div class="categories">
			<select name="categories" id="categories">
				<option value="업데이트">업데이트</option>
				<option value="공지사항">공지사항</option>
				<option value="이벤트">이벤트</option>
				<option value="기타">기타</option>
				<option value="점검">점검</option>
			</select>
		</div>
		<div class="title">
			<p>제목</p>
			<input type="text" name="title" placeholder="제목을 입력하세요"
				required="required" style="width: 900px;">
		</div>

		<div class="content--container">
			<p>내용</p>
			<textarea name="content" cols="100" rows="20" placeholder="내용을 입력하세요"></textarea>
		</div>
		<a href="/notice/listPage" class="btn btn-info">목록</a> <input
			type="submit" class="btn btn-info" value="등록">
	</form>
</div>


<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/layout/darkFooter.jsp"%>
