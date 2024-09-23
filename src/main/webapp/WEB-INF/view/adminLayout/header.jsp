<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%-- chart.js --%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<%--jquery sorce --%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<%-- Bootstrap 4--%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<%-- sweetalert2 CDN --%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<%-- font-awesome CSS --%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
	integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<%-- css --%>
<link rel="stylesheet" href="/css/adminMain.css">
<!-- Bootstrap JS (Popper.js 포함) -->
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>


<title>관리자</title>
</head>

<body>

	<div class="hamberger--wrap">
		<a href="#" class="hamberger--btn">&#9776;</a>
	</div>

	<aside class="bar--wrap">
		<nav class="nav--bar">
			<div class="close--btn">X
			<div class="admin--btn">
				<a href="/admin/logout" class="btn btn-info">로그아웃</a> <a
					href="/admin/changePassword" class="btn btn-info">비밀번호 변경</a>
			</div>
			</div>
			<ul class="inner--menu">
				<li><a href="/admin/main"><i class="fa-solid fa-clipboard"></i>대시보드</a></li>
				<li><a href="/admin/chart"><i
						class="fa-solid fa-chart-simple"></i>통계</a></li>
				<li><a href="/admin/userListPage"><i
						class="fa-solid fa-user"></i>회원관리</a></li>
				<li><a href="/pay/paymentList"><i
						class="fa-solid fa-credit-card"></i>결제관리</a></li>
				<li><a href="/advertiser/refund"><i
						class="fa-solid fa-rectangle-ad"></i>광고관리</a></li>
				<li><a href="/advertiser/review"><i
						class="fa-solid fa-rectangle-ad"></i>광고 신청</a></li>
				<li><a href="/portfolio/working"><i class="fa-solid fa-file"></i>포트폴리오</a></li>
				<li><a href="/board/listPage"><i
						class="fa-solid fa-clipboard-question"></i>문의사항</a></li>
				<li><a href="/notice/listPage"><i
						class="fa-solid fa-triangle-exclamation"></i>공지사항</a></li>
			</ul>
		</nav>

	</aside>

	<script>
		const toggleBtn = document.querySelector(".hamberger--btn");
		const closeBtn = document.querySelector(".close--btn");
		const sidebar = document.querySelector(".bar--wrap");

		toggleBtn.addEventListener("click", function() {
			sidebar.classList.toggle("show-sidebar");
		});

		closeBtn.addEventListener("click", function() {
			sidebar.classList.remove("show-sidebar");
		});

		/* 	$('#hamberger--btn').click(function() {
				$('.bar--wrap').css("margin-right", 0);
				$(this).hide();
			});
			$('.close--btn').click(function() {
				$('.bar--wrap').css("margin-right", -200px);
			}); */
	</script>