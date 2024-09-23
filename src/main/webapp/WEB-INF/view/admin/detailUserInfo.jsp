<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/adminLayout/header.jsp"%>
<link rel="stylesheet" href="/css/adminMain.css">
<link rel="stylesheet" href="/css/chart.css">

<main class="contents--wrap">
	<form action="/admin/detailUserInfo" method="get">
		<h2>상세 페이지</h2>
		<table class="table">
			<tr class="userInfo">
				<td class="username">이름</td>
				<td>${user.username}</td>
			</tr>
			<tr>
				<td class="userId">아이디</td>
				<td>${user.userId}</td>
			</tr>
			<tr>
				<td class="userPassword">비밀번호</td>
				<td>********</td>
			</tr>
			<tr>
				<td class="userNickname">닉네임</td>
				<td>${user.userNickname}</td>
			</tr>
			<tr>
				<td class="userEmail">이메일</td>
				<td>${user.userEmail}</td>
			</tr>
			<tr>
				<td class="userBirth">생년월일</td>
				<td>${user.userBirth}</td>
			</tr>
			<tr>
				<td class="userGender">성별</td>
				<td>${user.userGender}</td>
			</tr>
			<tr>
				<td class="userTel">전화번호</td>
				<td>${user.userTel}</td>
			</tr>
			<tr>
				<td class="createdAt">가입일</td>
				<td><fmt:formatDate value="${user.createdAt}"
						pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
			<tr>
				<td class="socialType">로그인 타입</td>
				<td>${user.socialType}</td>
			</tr>
		</table>

		<c:if test="${admin != null}">
			<!-- 버튼 -->
			<a href="/admin/userListPage" class="button">회원 목록</a>
			<a href="/admin/updateUserInfo?id=${user.id}" class="button">수정</a>
			<a href="/admin/deleteUserInfo?id=${user.id}" class="button">삭제</a>
		</c:if>
	</form>
</main>

<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/adminLayout/footer.jsp"%>