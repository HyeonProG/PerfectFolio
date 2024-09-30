<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/myInfo.css">
<style>
	/* personal--wrap 스타일 */
	.personal--wrap {
		background-color: #ffffff; /* 테이블 배경 색상 */
		padding: 2rem; /* 내부 여백 */
		border-radius: 12px; /* 둥근 모서리 */
		box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05); /* 테이블 그림자 효과 */
		width: 80%; /* 최대 너비 */
		margin: 0 auto; /* 중앙 정렬 */
		font-family: 'Arial', sans-serif; /* 현대적이고 깔끔한 글꼴 */
		overflow: hidden; /* 둥근 모서리에 맞게 내용 숨기기 */
		margin-bottom: 110px;
	}

	/* 제목 스타일 */
	.personal--wrap h2 {
		font-size: 1.6rem; /* 제목 글씨 크기 */
		color: #2c3e50; /* 짙은 네이비 색상 */
		text-align: center; /* 가운데 정렬 */
		margin-bottom: 1rem; /* 제목과 테이블 간격 */
		font-weight: 600; /* 글씨 두께 */
	}

	/* 테이블 스타일 */
	.personal--wrap table {
		width: 100%; /* 테이블 너비 */
		border-collapse: collapse; /* 테두리 겹침 제거 */
		background-color: #ffffff; /* 테이블 배경색 */
		border-radius: 12px; /* 둥근 모서리 */
		overflow: hidden; /* 테두리 둥글게 적용 */
	}

	.personal--wrap th, .personal--wrap td {
		padding: 0.8rem 1rem; /* 셀 안쪽 여백 */
		text-align: left; /* 텍스트 왼쪽 정렬 */
		border-bottom: 1px solid #e6e6e6; /* 셀 아래쪽 테두리 */
		color: #34495e; /* 텍스트 색상 */
		font-size: 0.95rem; /* 글자 크기 */
		vertical-align: middle; /* 텍스트 수직 정렬 */
	}

	.personal--wrap th {
		background-color: #f7f9fb; /* 헤더 배경색 */
		font-weight: 700; /* 헤더 글씨 두께 */
		color: #34495e; /* 헤더 글씨 색상 */
		font-size: 0.9rem; /* 헤더 글자 크기 */
		text-transform: uppercase; /* 글자 대문자 변환 */
		letter-spacing: 0.05rem; /* 글자 간격 */
		white-space: nowrap; /* 텍스트 줄바꿈 방지 */
		overflow: hidden; /* 넘치는 텍스트 숨기기 */
		text-overflow: ellipsis; /* 넘치는 텍스트 줄임표(...) */
		max-width: 200px; /* 최대 너비 설정 */
	}

	.personal--wrap td {
		transition: background-color 0.3s ease, color 0.3s ease; /* 배경과 글씨 색 전환 효과 */
		white-space: nowrap; /* 텍스트 줄 바꿈 방지 */
		overflow: hidden; /* 넘치는 텍스트 숨기기 */
		text-overflow: ellipsis; /* 넘치는 텍스트 줄임표(...) */
	}

	/* 테이블 행에 마우스 오버 시 효과 */
	.personal--wrap tr:hover {
		background-color: #f0f6fb; /* 마우스 오버 시 행 배경색 */
		transform: scale(1.01); /* 살짝 확대 */
	}

	.personal--wrap tr:hover td {
		background-color: #e8effb; /* 셀 배경색 */
		color: #2c3e50; /* 텍스트 색상 */
	}

	/* 결제 일시 스타일링 */
	.payment-date {
		display: block;
		width: 100%;
		white-space: nowrap; /* 한 줄 표시 */
		overflow: hidden; /* 넘치는 텍스트 숨기기 */
		text-overflow: ellipsis; /* 넘치는 텍스트 줄임표(...) */
	}

	/* 애니메이션 효과 추가 */
	@keyframes fadeIn {
		from {
			opacity: 0;
		}
		to {
			opacity: 1;
		}
	}

	/* 테이블 전체에 페이드 인 효과 */
	.personal--wrap table {
		animation: fadeIn 0.5s ease-in-out;
	}


</style>
<section class="user--section">
	<!-- side bar -->
	<aside class="personal--bar">
		<div class="bar--items">
			<p>내 정보</p>
			<a href="/company/my-info" class="bar--selected">계정관리</a> <a
				href="/company/payHistory">결제 내역</a>
		</div>
		<div class="bar--items">
			<p>입사제안서</p>
			<a href="/company/proposalHistory">입사제안서 내역</a>
		</div>
	</aside>

	<!-- content -->
	<div class="personal--wrap">
		<div>
			<h2>계정관리</h2>
			<p>기본정보</p>
		</div>

		<div class="inner--personal">
			<div class="user--info">
						<table>
							<tr>
								<th>이름</th>
								<td>${principal.username}</td>
							</tr>
							<tr>
								<th>아이디</th>
								<td>${principal.userId}</td>
							</tr>
							<tr>
								<th>입사제안서 수량</th>
								<td>${item}개</td>
							</tr>
						</table>
						<div class="inline--btn--wrap">
							<a href="#" class="info--btn">수정하기</a>
						</div>
			</div>
		</div>

		<div>
			<h2>계정삭제</h2>
		</div>
		<div class="inner--personal">
			<div class="user--info">
				<c:choose>
					<c:when test="${principal.userSocialType == 'com'}">
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
        fetch('http://localhost:8080/advertiser/random-image')
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
        fetch('http://localhost:8080/advertiser/increment-click', {
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