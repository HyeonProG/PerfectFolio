<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/adminLayout/header.jsp"%>
<link rel="stylesheet" href="/css/adminMain.css">
<link rel="stylesheet" href="/css/chart.css">


<main class="contents--wrap">
	<c:choose>
		<c:when test="${user.id != null}">

			<form action="/admin/updateUserInfo" method="post">
				<h2>회원 정보 수정 페이지</h2>
				<input type="hidden" name="id" value="${user.id}"> <input
					type="hidden" name="userId" value="${user.userId}"> <input
					type="hidden" name="userPassword" value="${user.userPassword}">
				<input type="hidden" name="userEmail" value="${user.userEmail}">
				<input type="hidden" name="createdAt" value="${user.createdAt}">
				<input type="hidden" name="socialType" value="${user.socialType}">

				<table class="table">
					<tr class="userInfo">
						<td class="username">이름</td>
						<td><input type="text" name="username"
							value="${user.username}"></td>
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
						<td><input type="text" name="userNickname"
							value="${user.userNickname}"></td>
					</tr>
					<tr>
						<td class="userEmail">이메일</td>
						<td>${user.userEmail}</td>
					</tr>
					<tr>
						<td class="userBirth">생년월일</td>
						<td><input type="date" name="userBirth"
							value="${user.userBirth}"></td>
					</tr>
					<tr>
						<td class="userGender">성별</td>
						<td><input type="text" name="userGender"
							value="${user.userGender}"></td>
					</tr>
					<tr>
						<td class="userTel">전화번호</td>
						<td><input type="tel" name="userTel" value="${user.userTel}"></td>
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
					<button type="submit" class="btn btn-primary">수정하기</button>
				</c:if>
			</form>
		</c:when>
	</c:choose>
</main>

<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/layout/darkFooter.jsp"%>