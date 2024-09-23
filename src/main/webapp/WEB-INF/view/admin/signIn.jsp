<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>

<!-- css -->
<link rel="stylesheet" href="/css/signIn.css">

<!-- content -->
<section class="signin--wrap">

	<div class="sign--title">
		<h2>Perfectfolio</h2>
		<p>개발자 포트폴리오 매칭서비스</p>
	</div>

	<div id="formWrapper">
		<ul id="signTap">
			<li style="font-weight: bold;">관리자</li>
		</ul>
		<div class="sigin--form box1_1 board" id="sigin--form1">
			<form action="/admin/sign-in" method="post">
				<div class="form-group">
					<label for="userId">아이디</label> <input type="text"
						class="form-control" id="userId" placeholder="아이디를 입력하세요."
						name="userId" required>
				</div>
				<div class="form-group">
					<label for="userPassword">비밀번호</label> <input type="password"
						class="form-control" id="userPassword" placeholder="비밀번호를 입력하세요."
						name="userPassword" required>
				</div>
				<button type="submit" class="btn btn-primary">로그인</button>
			</form>
		</div>
	</div>
</section>

<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightFooter.jsp"%>