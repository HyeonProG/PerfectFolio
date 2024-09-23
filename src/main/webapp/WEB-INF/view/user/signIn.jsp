<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<%--<%@ include file="/WEB-INF/view/layout/darkHeader.jsp"%>--%>
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
			<li class="tap tablink opacity"
				onclick="openBoard(event,'sigin--form1')">일반회원&기업용</li>
			<li class="tap tablink" onclick="openBoard(event,'sigin--form2')">광고주</li>
		</ul>

		<!-- 일반회원 & 기업용 로그인 폼 -->
		<div class="sigin--form box1_1 board" id="sigin--form1">
			<form action="/user/sign-in" method="post">
				<div class="form-group">
					<label for="userId">아이디</label> <input type="text"
						class="form-control" id="userId" value="${userId}" placeholder="아이디를 입력하세요."
						name="userId" required>
				</div>
				<div class="form-group">
					<label for="userPassword">비밀번호</label> <input type="password"
						class="form-control" id="userPassword" placeholder="비밀번호를 입력하세요."
						name="userPassword" required>
				</div>
				<button type="submit" class="sign--btn">로그인</button>
				<div class="sign--utils--wrap">
					<div class="sign--check">
						<input type="checkbox" id="checkSavedID" name="checkSavedID" value="on">
						<label for="checkSavedID">아이디 저장</label>
					</div>
					<div class="sign--menu">
						<a href="/user/sign-up">회원가입</a> <a href="/user/findUserIdByEmail">아이디
							찾기</a> <a href="/user/findPassword">비밀번호 찾기</a>
					</div>
				</div>
			</form>

			<div class="social--wrap">
				<p>소셜 연동 로그인</p>
				<div class="social--btn--wrap">
					<a
						href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=${kakaoRestApiKey}&redirect_uri=${kakaoRedirectUri}">
						<img alt="카카오 로그인 버튼" class="social--btn"
						src="/images/kakao_login_medium_narrow.png">
					</a> <a
						href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=${naverClientId}&state=${state}&redirect_uri=${naverRedirectUri}">
						<img alt="네이버 로그인 버튼" class="social--btn"
						src="/images/btnG_완성형.png">
					</a> <a
						href="https://accounts.google.com/o/oauth2/v2/auth?client_id=${googleClientId}&redirect_uri=${googleRedirectUri}&response_type=code&scope=email profile&access_type=offline">
						<img alt="구글 소셜 로그인 이미지" class="social--btn"
						src="/images/googleLogIn.png">
					</a>
				</div>
			</div>
		</div>

		<!-- 광고주 로그인 폼 -->
		<div class="sigin--form box1_1 board" id="sigin--form2"
			style="display: none;">
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
						<a href="/advertiser/sign-up">회원가입</a> <a
							href="/user/findUserIdByEmail">아이디 찾기</a> <a
							href="/user/findPassword">비밀번호 찾기</a>
					</div>
				</div>
			</form>
		</div>
		<!-- Ad -->
		<div>
			<a id="imageLink" href="#"> <img id="randomImage"
				class="random-image" alt="" />
			</a>
		</div>
	</div>
	<!-- <a href="${pageContext.request.contextPath}/user/findPassword">비밀번호 찾기</a> -->
</section>

<script>
//tab
function openBoard(evt, boardName) {
	  let i, x, tablinks;
	  x = document.getElementsByClassName("board");
	  for (i = 0; i < x.length; i++) {
		x[i].style.display = "none";
	  }
	  tablinks = document.getElementsByClassName("tablink");
	  for (i = 0; i < x.length; i++) {
		tablinks[i].className = tablinks[i].className.replace(" opacity", "");
	  }
	  document.getElementById(boardName).style.display = "block";
	  evt.currentTarget.className += " opacity";
}
</script>
<!-- 광고 이미지 -->
<script>
    function fetchRandomImage() {
        fetch('http://perfecfolio.jinnymo.com/advertiser/random-image')
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
        fetch('http://perfecfolio.jinnymo.com/advertiser/increment-click', {
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

<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightFooter.jsp"%>