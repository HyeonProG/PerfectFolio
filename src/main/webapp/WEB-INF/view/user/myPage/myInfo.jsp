<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/myInfo.css">
<section class="user--section">
	<!-- side bar -->
	<aside class="personal--bar">
		<div class="bar--items">
			<p>내 정보</p>
			<a href="#" class="bar--selected">계정관리</a>
			<a href="/user/my-subscribe">구독 내역</a>
			<a href="/user/mySkillPage">스킬스택 관리</a>

		</div>
		<div class="bar--items">
			<p>포트폴리오</p>
			<a href="/user/my-portfolio">포트폴리오</a>
		</div>
	</aside>

	<!-- content -->
	<div class="personal--wrap">
		<div>
			<h2>계정관리</h2>
		</div>

		<div class="inner--personal">
			<div class="user--info">
				<c:choose>
					<c:when test="${principal.userSocialType == 'local'}">
						<table>
							<tr>
								<th>이름</th>
								<td>${principal.username}</td>
							</tr>
							<tr>
								<th>아이디</th>
								<td>${principal.userId}</td>
							</tr>
						</table>
						<div class="inline--btn--wrap">
							<a href="/user/updateUserInfo" class="info--btn">수정하기</a>
						</div>
					</c:when>

					<c:when test="${principal.userSocialType != 'local'}">
						<table>
							<tr>
								<th>이름</th>
								<td>${principal.username}</td>
							</tr>
							<tr>
								<th>계정 연동</th>
								<td>${principal.userSocialType}<span>연결됨</span>
								</td>
							</tr>
						</table>
					</c:when>
					<c:otherwise>
						<p>오류</p>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<br>
		<div>
			<h2>계정삭제</h2>
		</div>
		<div class="inner--personal">
			<div class="user--info">
				<c:choose>
					<c:when test="${principal.userSocialType == local}">
						<div class="inline--btn--wrap">
							<a href="/user/withdraw" class="info--btn">탈퇴하기</a>
						</div>
					</c:when>

					<c:when test="${principal.userSocialType != local }">
						<p>계정 삭제 시 프로필 및 포트폴리오 정보가 모두 삭제됩니다.</p>
						<div class="inline--btn--wrap">
							<a href="/user/withdraw" class="info--btn">연동 해지</a>
						</div>
					</c:when>
					<c:otherwise>
						<p>오류</p>
					</c:otherwise>
				</c:choose>




			</div>
		</div>
		<!-- Ad -->
		<div>
			<a id="imageLink" href="#"> <img id="randomImage"
				class="random-image" alt="" />
			</a>
		</div>
	</div>
</section>

<!-- 광고 이미지 -->
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

<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightFooter.jsp"%>