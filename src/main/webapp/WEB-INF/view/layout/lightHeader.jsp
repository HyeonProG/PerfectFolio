<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Perfectfolio</title>

<!--favicon-->
<link rel="icon" type="image/png" sizes="32x32" href="#">
<!-- css -->
<link rel="stylesheet" href="/css/common2.css">

<!-- font-awesome CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
	integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />

<!-- Link Swiper's CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<!-- Swiper JS -->
<script
	src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<!-- Bootstrap 4 + jquery-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- sweetalert2 CDN -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<!--jquery sorce-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- aos -->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

<style>
.body--bg {
	background-color: #fff;
}
</style>
</head>

<body class="body--bg">
	<div class="service--utils">
		<a href="#mainBanner" class="top--btn">TOP</a>
		<a href="#"
			onclick="openChatBot()" class="chat--bot"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512"><!--!Font Awesome Free 6.6.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M86.3 197.8a51.8 51.8 0 0 0 -41.6 20.1V156a8.2 8.2 0 0 0 -8.2-8.2H8.2A8.2 8.2 0 0 0 0 156V333.6a8.2 8.2 0 0 0 8.2 8.2H36.6a8.2 8.2 0 0 0 8.2-8.2v-8.1c11.6 13.4 25.9 19.8 41.6 19.8 34.6 0 61.9-26.2 61.9-73.8C148.3 225.5 121.2 197.8 86.3 197.8zM71.5 305.7c-9.6 0-21.2-4.9-26.7-12.5V250.2c5.5-7.6 17.2-12.8 26.7-12.8 17.7 0 31.1 13.1 31.1 34C102.6 292.6 89.3 305.7 71.5 305.7zm156.4-59a17.4 17.4 0 1 0 17.4 17.4A17.4 17.4 0 0 0 227.9 246.7zM274 156.7V112a13.3 13.3 0 1 0 -10.2 0V156.7a107.5 107.5 0 1 0 10.2 0zm86 107.4c0 30.5-40.8 55.3-91.1 55.3s-91.1-24.8-91.1-55.3 40.8-55.3 91.1-55.3S359.9 233.5 359.9 264.1zm-50.2 17.4a17.4 17.4 0 1 0 -17.4-17.4h0A17.4 17.4 0 0 0 309.8 281.5zM580.7 250.5c-14.8-2.6-22.4-3.8-22.4-9.9 0-5.5 7.3-9.9 17.7-9.9a65.6 65.6 0 0 1 34.5 10.1 8.2 8.2 0 0 0 11.3-2.5c.1-.1 .1-.2 .2-.3l8.6-14.9a8.2 8.2 0 0 0 -2.9-11.1 99.9 99.9 0 0 0 -52-14.1c-39 0-60.2 21.5-60.2 46.2 0 36.3 33.7 41.9 57.6 45.6 13.4 2.3 24.1 4.4 24.1 11 0 6.4-5.5 10.8-18.9 10.8-13.6 0-31-6.2-42.6-13.6a8.2 8.2 0 0 0 -11.3 2.5c0 .1-.1 .1-.1 .2l-10.2 16.9a8.2 8.2 0 0 0 2.5 11.1c15.2 10.3 37.7 16.7 59.4 16.7 40.4 0 64-19.8 64-46.5C640 260.6 604.5 254.8 580.7 250.5zm-95.9 60.8a8.2 8.2 0 0 0 -9.5-5.9 23.2 23.2 0 0 1 -4.2 .4c-7.8 0-12.5-6.1-12.5-14.2V240.3h20.3a8.1 8.1 0 0 0 8.1-8.1V209.5a8.1 8.1 0 0 0 -8.1-8.1H458.6V171.1a8.1 8.1 0 0 0 -8.1-8.1H422.3a8.1 8.1 0 0 0 -8.1 8.1h0v30.2H399a8.1 8.1 0 0 0 -8.1 8.1h0v22.7A8.1 8.1 0 0 0 399 240.3h15.1v63.7c0 27 15.4 41.3 43.9 41.3 12.2 0 21.4-2.2 27.6-5.4a8.2 8.2 0 0 0 4.1-9.3z"/></svg></a>
	</div>

	<!-- s: header -->
	<div class="h--fixed">
		<header class="header">
			<h1 class="main--logo">
				<a href="/user/main"> <img
					src="/images/main/PerfectFolio_logo_black.gif" alt="">
				</a>
			</h1>

			<nav class="gnb--wrap">
				<ul class="gnb">
					<li class="gnb--item"><a href="/introduction"
						class="gnb--link">About</a>
						<ul class="sub--menu">
							<li class="sub--item"><a href="/introduction"
								class="sub--link">소개</a></li>
							<li class="sub--item"><a href="#" class="sub--link">사업문의</a></li>
						</ul></li>
					<li class="gnb--item"><a href="#" class="gnb--link">Trend</a>
						<ul class="sub--menu">
							<li class="sub--item"><a href="/trend" class="sub--link">트랜드</a>
							</li>
						</ul></li>
					<c:choose>
						<c:when test="${principal.userSocialType == 'com'}">
							<li class="gnb--item"><a href="/company/search"
								class="gnb--link">Search</a>
								<ul class="sub--menu">
									<li class="sub--item"><a href="/company/search"
										class="sub--link">인재 찾기</a></li>
									<li class="sub--item"><a href="/company/favoriteList"
										class="sub--link">즐겨찾기</a></li>
								</ul></li>
							<li class="gnb--item"><a href="/company/payment"
								class="gnb--link">Payment</a>
								<ul class="sub--menu">
									<li class="sub--item"><a href="/company/payment"
										class="sub--link">상품 구매</a></li>
								</ul></li>
						</c:when>
						<c:otherwise>
						<li class="gnb--item"><a href="#" class="gnb--link">Portfolio</a>
						<ul class="sub--menu">
							<li class="sub--item"><a href="/pay/subscribe"
								class="sub--link">구독</a></li>
						</ul></li>
						</c:otherwise>
					</c:choose>
					<li class="gnb--item"><a href="/notice/listPage"
						class="gnb--link">Service</a>
						<ul class="sub--menu">
							<li class="sub--item"><a href="/notice/listPage"
								class="sub--link">공지사항</a></li>
							<li class="sub--item"><a href="/board/listPage"
								class="sub--link">문의사항</a></li>
									<li class="sub--item"><a href="/user/recommendListPage"
								class="sub--link">기업 매칭</a></li>
						</ul></li>
				</ul>
			</nav>

			<div class="utils--wrap">
				<ul class="utils">
					<li class="util--item"><a href="#" class="util--link"><i
							class="fa-regular fa-user"></i></a>
						<ul class="util--sub">
							<c:choose>
								<c:when test="${principal.userSocialType == 'com'}">
									<li class="util--sub--item"><a href="/company/my-info"
										class="sub--link">마이페이지</a></li>
									<li class="util--sub--item"><a href="/user/logout"
										class="sub--link">로그아웃</a></li>
								</c:when>
								<c:when test="${principal != null}">
									<li class="util--sub--item"><a href="/user/my-info"
										class="sub--link">마이페이지</a></li>
									<li class="util--sub--item"><a href="/user/logout"
										class="sub--link">로그아웃</a></li>
								</c:when>
								<c:when test="${advertiser != null}">
									<li class="util--sub--item"><a href="/advertiser/my-info"
										class="sub--link">마이페이지</a></li>
									<li class="util--sub--item"><a href="/advertiser/logout"
										class="sub--link">로그아웃</a></li>
								</c:when>
								<c:otherwise>
									<li class="util--sub--item"><a href="/user/sign-in"
										class="sub--link">로그인</a></li>
									<li class="util--sub--item"><a href="/user/intro-sign-up"
										class="sub--link">회원가입</a></li>
								</c:otherwise>
							</c:choose>
						</ul></li>
				</ul>
			</div>

			<nav class="side--nav">
				<p class="close--btn">X</p>
				<button type="button" class="collapsible" onclick="collapse(this);">About</button>
				<div class="content">
					<a href="#">소개</a>
				</div>
				<button type="button" class="collapsible" onclick="collapse(this);">Trend</button>
				<div class="content">
					<a href="#">트랜드</a>
				</div>
				<button type="button" class="collapsible" onclick="collapse(this);">Portfolio</button>
				<div class="content">
					<a href="#">매칭</a> <a href="#">구독</a>
				</div>
				<button type="button" class="collapsible" onclick="collapse(this);">Service</button>
				<div class="content">
					<a href="/notice/listPage">공지사항</a> <a href="/board/listPage">문의사항</a>
				</div>

				<div>
					<a href="#">로그인 아니면 로그아웃</a>
				</div>
			</nav>
		</header>
	</div>
	<!-- e: header -->

	<script>
		function openChatBot() {
			window.open('/chat/chatPage', 'chatBotPopup',
					'width=600,height=800,top=100,left=100,scrollbars=yes');
		}

		// 모바일 메뉴 펼침 이벤트
		const toggleBtn = document.querySelector(".hamberger--btn");
		const closeBtn = document.querySelector(".close--btn");
		const sidebar = document.querySelector(".side--nav");

		toggleBtn.addEventListener("click", function() {
			sidebar.classList.toggle("show-sidebar");
		});

		closeBtn.addEventListener("click", function() {
			sidebar.classList.remove("show-sidebar");
		});

		// 모바일 메뉴 토글
		function collapse(element) {
			var before = document.getElementsByClassName("active")[0] // 기존에 활성화된 버튼
			if (before
					&& document.getElementsByClassName("active")[0] != element) { // 자신 이외에 이미 활성화된 버튼이 있으면
				before.nextElementSibling.style.maxHeight = null; // 기존에 펼쳐진 내용 접고
				before.classList.remove("active"); // 버튼 비활성화
			}
			element.classList.toggle("active"); // 활성화 여부 toggle

			var content = element.nextElementSibling;
			if (content.style.maxHeight != 0) { // 버튼 다음 요소가 펼쳐져 있으면
				content.style.maxHeight = null; // 접기
			} else {
				content.style.maxHeight = content.scrollHeight + "px"; // 접혀있는 경우 펼치기
			}
		}
	</script>