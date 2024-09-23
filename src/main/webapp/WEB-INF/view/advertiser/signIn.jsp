<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/signIn.css">

<!-- content -->
<section class="signin--wrap">

	<div class="sign--title">
		<h2>Perfectfolio Advertising</h2>
		<p>광고주 전용 로그인</p>
	</div>

	<div class="sigin--form">
		<form action="/advertiser/sign-in" method="post">
			<div class="form-group">
				<label for="userId">아이디</label> <input type="text"
					class="form-control" id="userId" placeholder="아이디를 입력하세요."
					name="userId" required>
			</div>
			<div class="form-group">
				<label for="password">비밀번호</label> <input type="password"
					class="form-control" id="password" placeholder="비밀번호를 입력하세요."
					name="password" required>
			</div>
			<button type="submit" class="sign--btn">로그인</button>
			<div class="sign--utils--wrap">
				<div class="sign--check">
					<input type="checkbox" id="checkSavedID"> <label
						for="checkSavedID">아이디 저장</label>
				</div>
				<div class="sign--menu">
					<a href="/user/sign-up">회원가입</a> <a href="/user/findUserIdByEmail">아이디
						찾기</a> <a href="/user/findPassword">비밀번호 찾기</a>
				</div>
			</div>
		</form>
	</div>
</section>


<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightFooter.jsp"%>