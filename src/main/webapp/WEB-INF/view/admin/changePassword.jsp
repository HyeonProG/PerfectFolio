<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/adminLayout/header.jsp"%>

<style>
.contents--wrap {
	padding-top: 64px;
	background-color: #fcfcfc;
	width: 80%;
	height: 100%;
	margin: 0 auto;
}
</style>

<div class="contents--wrap">
	<form action="/admin/changePassword" method="post">
		<div class="form-group">
			<label for="userId">아이디</label> <input type="text"
				class="form-control" id="userId" placeholder="아이디를 입력하세요."
				name="userId" required>
		</div>

		<div class="form-group">
			<label for="newPassword">새로운 비밀번호</label> <input type="password"
				class="form-control" id="newPassword" placeholder="비밀번호를 입력하세요."
				name="newPassword" required>
		</div>

		<div class="form-group">
			<label for="checkPassword">비밀번호 확인</label> <input type="password"
				class="form-control" id="checkPassword" placeholder="비밀번호를 입력하세요."
				name="checkPassword" required>
		</div>
		<div class="form-group">
			<button type="submit" class="form-control" id="changePassword">변경</button>
		</div>
	</form>
</div>
<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/adminLayout/footer.jsp"%>