<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Responsive Sliding Sidebar Menu</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.random-image {
	max-width: 100%;
	height: auto;
}

html, body {
	height: 100%;
	margin: 0;
	background: linear-gradient(135deg, #1a1a2e, #383872, #7367f0);
	color: #ffffff;
	font-family: 'Roboto', sans-serif;
	display: flex;
	flex-direction: column;
}

.navbar {
	background-color: rgba(42, 42, 72, 0.8);
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
	opacity: 0;
	transform: translateY(-20px);
	transition: opacity 1.5s ease-in-out, transform 1.5s ease-in-out;
}

.navbar.visible {
	opacity: 1;
	transform: translateY(0);
}

.navbar-brand img {
	max-height: 50px; /* 이미지 크기를 조정 */
}

.navbar-toggler {
	border-color: #ffffff;
}

.navbar-toggler-icon {
	background-image:
		url("data:image/svg+xml;charset=utf8,%3Csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath stroke='rgba%2888, 88, 255, 1%29' stroke-width='2' linecap='round' linejoin='round' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E");
}

.content {
	flex: 1;
	padding: 20px;
	display: flex;
	justify-content: center;
	align-items: center;
	text-align: center;
}

/* 타이핑 애니메이션 */
.typing-effect {
	font-size: clamp(2rem, 5vw, 5rem); /* 화면 크기에 따라 동적으로 크기 조절 */
	font-weight: bold;
	white-space: nowrap;
	overflow: hidden;
	background: linear-gradient(90deg, #ffffff, #d1c4e9); /* 그라데이션 색상 */
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	animation: typing 4s steps(30, end), fadeInText 1s ease-in-out forwards;
	border-right: 4px solid #ffffff;
	opacity: 0;
}

@
keyframes typing {from { width:0;
	
}

to {
	width: 100%;
}

}
@
keyframes fadeInText {from { opacity:0;
	
}

to {
	opacity: 1;
}

}

/* 사이드 메뉴 스타일 */
.side-menu {
	position: fixed;
	top: 0;
	right: -250px;
	width: 250px;
	height: 100%;
	background-color: #2a2a48;
	transition: right 0.3s ease;
	z-index: 1050;
	padding-top: 60px;
}

.side-menu.show {
	right: 0;
}

.side-menu .nav-link {
	color: #ffffff;
	padding: 10px 20px;
	border-bottom: 1px solid #444;
}

.side-menu .nav-link:hover {
	background-color: #444;
	color: #b39ddb;
}

/* 오버레이 스타일 */
.overlay {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	z-index: 1049;
	display: none;
}

.overlay.show {
	display: block;
}

/* 반응형 디자인에서 메뉴 간격 조정 */
@media ( min-width : 992px) {
	.navbar-nav {
		margin: 0 auto;
		display: flex;
		justify-content: space-around; /* 메뉴 간격을 띄움 */
		width: 50%;
	}
	.navbar-nav .nav-item {
		margin: 0 10px;
	}
}

/* 보라색, 흰색 적용 */
.navbar-nav .nav-link {
	color: #d1c4e9; /* 연한 보라색 */
	transition: color 0.3s;
}

.navbar-nav .nav-link:hover {
	color: #b39ddb; /* 더 진한 보라색 */
}

.navbar-brand {
	color: #b39ddb !important; /* 보라색 */
	font-weight: bold;
}

/* 메인 컨텐츠 스타일 */
.display-4, .lead {
	text-shadow: 0 0 5px rgba(255, 255, 255, 0.2);
}

/* 푸터 스타일 */
footer {
	background-color: rgba(42, 42, 72, 0.8);
	padding: 20px 0;
	color: #ffffff;
	text-align: center;
}
</style>
</head>

<body>

	<!-- Navbar Example -->
	<nav class="navbar navbar-expand-lg">
		<a class="navbar-brand" href="#"><img
			src="/mnt/data/제목 없는 디자인.png" alt="Logo"></a>
		<button class="navbar-toggler" type="button">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item"><a class="nav-link"
					href="/advertiser/payment">결제하기</a></li>
				<li class="nav-item"><a class="nav-link"
					href="/advertiser/application">광고 신청</a></li>
				<li class="nav-item"><a class="nav-link"
					href="/advertiser/my-info">마이페이지</a></li>
			</ul>
		</div>
		<c:choose>
			<c:when test="${principal != null }">
				<div class="">
					<ul class="navbar-nav ml-auto">
						</li>
						<li class="nav-item"><a class="nav-link"
							href="/advertiser/logout">로그아웃</a></li>
					</ul>
				</div>
			</c:when>
			<c:otherwise>
				<div class="">
					<ul class="navbar-nav ml-auto">
						<li class="nav-item"><a class="nav-link"
							href="/advertiser/sign-in">로그인</a></li>
						<li class="nav-item"><a class="nav-link"
							href="/advertiser/sign-up">회원가입</a></li>
					</ul>
				</div>
			</c:otherwise>
		</c:choose>


	</nav>

	<!-- Main Content Example -->
	<div class="content">
		<div class="row">
			<div class="col">
				<h1 class="typing-effect">당신의 포트폴리오는 완벽합니까?</h1>
			</div>
		</div>
	</div>
<a id="imageLink" href="#">
    <img id="randomImage" class="random-image" alt=""/>
</a>
	<!-- Footer Example -->
	<footer>
		<div class="container">
			<div class="text-center">&copy; 2024 Your Company</div>
		</div>
	</footer>

	<!-- Side Menu -->
	<div class="side-menu" id="sideMenu">
		<a class="nav-link" href="#">New Trend</a> <a class="nav-link"
			href="#">Analysis</a> <a class="nav-link" href="#">Service</a> <a
			class="nav-link" href="#">My Page</a>
	</div>

	<!-- Overlay -->
	<div class="overlay" id="overlay"></div>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script>
        document.addEventListener('DOMContentLoaded', function () {
            const typingEffect = document.querySelector('.typing-effect');
            const navBar = document.querySelector('.navbar');

            typingEffect.addEventListener('animationend', function () {
                setTimeout(() => {
                    navBar.classList.add('visible');
                }, 500); // 문구가 끝난 후 0.5초 뒤에 네비게이션 바가 나타남
            });
        });

        const toggler = document.querySelector('.navbar-toggler');
        const sideMenu = document.getElementById('sideMenu');
        const overlay = document.getElementById('overlay');

        toggler.addEventListener('click', function () {
            sideMenu.classList.toggle('show');
            overlay.classList.toggle('show');
        });

        overlay.addEventListener('click', function () {
            sideMenu.classList.remove('show');
            overlay.classList.remove('show');
        });
    </script>
    <script>
    function fetchRandomImage() {
        fetch('http:perfecfolio.jinnymo.com/advertiser/random-image')
            .then(response => response.json())
            .then(data => {
            	console.log("서버 응답 데이터: " + data);
                if (data.imageUrl && data.site && data.uploadFileName) {
                    // 이미지와 링크 업데이트
                    document.getElementById('randomImage').src = data.imageUrl;
                    document.getElementById('imageLink').href = data.site;

                    // 이미지 클릭 시 클릭 카운트를 증가시키는 함수 등록
                    document.getElementById('imageLink').onclick = function () {
                        incrementClickCount(data.imageUrl);
                        console.log('Image clicked:', data.imageUrl);
                    };
                } else {
                    console.error('데이터 오류:', data);
                }
            })
            .catch(error => console.error('오류 발생:', error));
    }

    function incrementClickCount(imageUrl) {
        fetch('http:perfecfolio.jinnymo.com/advertiser/increment-click', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ imageUrl: imageUrl })
        })
        .then(response => {
            if (!response.ok) {
                console.error('클릭 카운트 증가 실패');
            }
        })
        .catch(error => console.error('오류 발생:', error));
    }

    // 페이지 로드 시 이미지 요청
    document.addEventListener('DOMContentLoaded', fetchRandomImage);
</script>

</body>

</html>