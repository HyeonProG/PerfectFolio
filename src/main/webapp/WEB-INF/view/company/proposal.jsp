
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/myInfo.css">

<section class="user--section">
	<!-- side bar -->
	<aside class="personal--bar">
		<div class="bar--items">
			<p>내 정보</p>
			<a href="/company/my-info">계정관리</a> <a href="/company/payHistory">결제
				내역</a>
		</div>
		<div class="bar--items">
			<p>입사제안서</p>
			<a href="/company/proposalHistory" class="bar--selected">입사제안서 내역</a>
		</div>
	</aside>

	<!-- content -->
	<div class="personal--wrap">
		<div>
			<h2>입사 제안 내역</h2>
			<table>
				<thead>
					<tr>
						<th>유저 이름</th>
						<th>제안 날짜</th>
						<th>제안 상태</th>
						<th>정보 확인</th>
						<!-- 새로운 열 추가 -->
					</tr>
				</thead>
				<tbody>
					<c:forEach var="proposal" items="${proposalList}">
						<tr>
							<td>${proposal.userName}</td>
							<td>${proposal.formatLocalDateTime()}</td>
							<td>${proposal.status}</td>
							<td>
								<!-- 수락 상태일 때만 버튼 활성화 -->
								<button class="info--btn"
									onclick="showInfoModal('${proposal.userName}', '${proposal.userEmail}', '${proposal.userGender}', '${proposal.userTel}', '${proposal.formatLocalDateTime()}', '${proposal.status}')"
									<c:if test="${proposal.status != '수락'}">disabled</c:if>>
									정보 보기</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- Ad -->
		<div>
			<a id="imageLink" href="#"> <img id="randomImage"
				class="random-image" alt="" />
			</a>
		</div>
	</div>
</section>

<!-- 모달창 구조 -->
<div id="infoModal" class="modal">
	<div class="modal-content">
		<span class="close" onclick="closeModal()">&times;</span>
		<h2 class="modal-title">유저 정보</h2>
		<div class="modal-body">
			<div class="modal-row">
				<div class="modal-label">이름:</div>
				<div class="modal-value" id="modalUserName"></div>
			</div>
			<div class="modal-row">
				<div class="modal-label">이메일:</div>
				<div class="modal-value" id="modalUserEmail"></div>
			</div>
			<div class="modal-row">
				<div class="modal-label">성별:</div>
				<div class="modal-value" id="modalUserGender"></div>
			</div>
			<div class="modal-row">
				<div class="modal-label">연락처:</div>
				<div class="modal-value" id="modalUserTel"></div>
			</div>
			<div class="modal-row">
				<div class="modal-label">상태:</div>
				<div class="modal-value" id="modalProposalStatus"></div>
			</div>
			<div class="modal-row">
				<div class="modal-label">제안 날짜:</div>
				<div class="modal-value" id="modalProposalDate"></div>
			</div>
		</div>
	</div>
</div>

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

        // 모달창 관련 스크립트
        function showInfoModal(userName, userEmail, userGender, userTel, proposalDate, proposalStatus) {
            document.getElementById('modalUserName').innerText = userName;
            document.getElementById('modalUserEmail').innerText = userEmail;
            document.getElementById('modalUserGender').innerText = userGender;
            document.getElementById('modalUserTel').innerText = userTel;
            document.getElementById('modalProposalDate').innerText = proposalDate;
            document.getElementById('modalProposalStatus').innerText = proposalStatus;
            document.getElementById('infoModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('infoModal').style.display = 'none';
        }

        // 모달창 닫기 (외부 클릭 시 닫기)
        window.onclick = function(event) {
            if (event.target == document.getElementById('infoModal')) {
                closeModal();
            }
        }
    </script>

<!-- CSS for Modal -->
<style>
/* 모달창 스타일 */
.modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.6); /* 어두운 배경 */
	padding-top: 60px;
	animation: fadeIn 0.5s ease-out; /* 부드러운 페이드 인 효과 */
}

.modal-content {
	background-color: #ffffff;
	margin: 5% auto;
	padding: 20px 30px; /* 패딩 조정 */
	border-radius: 15px; /* 둥근 모서리 */
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3); /* 더 깊은 그림자 */
	width: 80%;
	max-width: 600px; /* 최대 너비 설정 */
	position: relative; /* 닫기 버튼 위치 조정 */
	overflow: hidden; /* 넘치는 내용 숨김 */
	font-family: 'Helvetica Neue', Arial, sans-serif; /* 깔끔한 폰트 */
}

.modal-title {
	font-size: 1.8rem; /* 큰 제목 */
	font-weight: bold; /* 굵은 글꼴 */
	color: #333; /* 진한 색상 */
	text-align: center; /* 중앙 정렬 */
	margin-bottom: 1.5rem; /* 하단 여백 */
}

.modal-body {
	display: grid; /* 그리드 레이아웃 */
	grid-template-columns: 1fr 2fr; /* 레이블과 값의 비율 설정 */
	gap: 1rem; /* 그리드 간격 */
	margin-bottom: 1.5rem; /* 하단 여백 */
}

.modal-row {
	display: flex;
	justify-content: space-between; /* 공간을 고르게 분배 */
	align-items: center; /* 세로 중앙 정렬 */
	padding: 0.5rem 0; /* 위아래 여백 */
}

.modal-label {
	font-weight: 600; /* 레이블 굵게 */
	color: #555; /* 연한 색상 */
	text-transform: uppercase; /* 대문자로 변환 */
	letter-spacing: 0.05rem; /* 글자 간격 */
	flex: 1; /* 동일한 비율로 확장 */
}

.modal-value {
	font-weight: 400; /* 기본 굵기 */
	color: #333; /* 진한 색상 */
	flex: 2; /* 더 많은 공간을 차지 */
	word-break: break-all; /* 내용 줄바꿈 */
}

/* 닫기 버튼 스타일 */
.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
	transition: color 0.3s ease;
	position: absolute; /* 위치 고정 */
	top: 10px; /* 상단 여백 */
	right: 20px; /* 우측 여백 */
}

.close:hover, .close:focus {
	color: #ff5e5e; /* 호버 시 색상 변경 */
	text-decoration: none;
}

/* 페이드 인 효과 */
@
keyframes fadeIn {from { opacity:0;
	transform: translateY(-20px); /* 살짝 위에서 */
}

to {
	opacity: 1;
	transform: translateY(0); /* 원래 위치로 */
}

}
.info--btn[disabled] {
	background-color: #ddd;
	cursor: not-allowed;
}

/* personal--wrap 테이블 스타일 */
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
	font-size: 1.8rem; /* 제목 글씨 크기 */
	color: #2c3e50; /* 짙은 네이비 색상 */
	text-align: center; /* 가운데 정렬 */
	margin-bottom: 1.5rem; /* 제목과 테이블 간격 */
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
	padding: 1rem; /* 셀 안쪽 여백 */
	text-align: left; /* 텍스트 왼쪽 정렬 */
	border-bottom: 1px solid #e6e6e6; /* 셀 아래쪽 테두리 */
	color: #34495e; /* 텍스트 색상 */
	font-size: 1rem; /* 글자 크기 */
}

.personal--wrap th {
	background-color: #f7f9fb; /* 헤더 배경색 */
	font-weight: 700; /* 헤더 글씨 두께 */
	color: #34495e; /* 헤더 글씨 색상 */
	font-size: 1rem; /* 헤더 글자 크기 */
	text-transform: uppercase; /* 글자 대문자 변환 */
	letter-spacing: 0.05rem; /* 글자 간격 */
}

.personal--wrap tr {
	transition: background-color 0.3s ease, transform 0.3s ease;
	/* 배경색과 변형 효과 */
}

.personal--wrap tr:hover {
	background-color: #f0f6fb; /* 마우스 오버 시 행 배경색 */
	transform: scale(1.02); /* 살짝 확대 */
}

.personal--wrap td:last-child {
	width: 30%; /* 결제 일시 셀 너비 */
	font-size: 0.95rem; /* 텍스트 크기 */
	color: #2c3e50; /* 결제 일시 텍스트 색상 */
}

.personal--wrap th:last-child {
	width: 30%; /* 결제 일시 헤더 너비 */
}

.personal--wrap td {
	transition: background-color 0.3s ease, color 0.3s ease;
	/* 배경과 글씨 색 전환 효과 */
	white-space: nowrap; /* 텍스트 줄 바꿈 방지 */
	overflow: hidden; /* 넘치는 텍스트 숨기기 */
	text-overflow: ellipsis; /* 넘치는 텍스트 줄임표(...) */
}

/* 마우스 오버 시 셀 배경과 텍스트 색상 */
.personal--wrap tr:hover td {
	background-color: #e0e7ef; /* 셀 배경색 */
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
@
keyframes fadeIn {from { opacity:0;
	
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

<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightFooter.jsp"%>
