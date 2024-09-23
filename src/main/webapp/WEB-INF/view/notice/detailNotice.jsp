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

	<form action="/notice/detail" method="get">
		<h2>공지사항</h2>
		<table class="table">
			<tr>
				<td class="categories">카테고리</td>
				<td>${notice.categories}</td>
			</tr>
			<tr>
				<td class="title">제목</td>
				<td>${notice.title}</td>
			</tr>
			<tr>
				<td class="content">내용</td>
				<td>${notice.content}</td>
			</tr>
		</table>

		<c:if test="${admin != null}">
			<!-- 버튼 -->
			<a href="/notice/listPage" class="btn btn-info">목록</a>
			<a href="/notice/update?id=${notice.id}" class="btn btn-info">수정</a>
			<a href="/notice/delete?id=${notice.id}" class="btn btn-info">삭제</a>
		</c:if>
	</form>
</div>


<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/layout/darkFooter.jsp"%>