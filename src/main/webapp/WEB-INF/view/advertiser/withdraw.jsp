<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/myInfoAd.css">
<style>
.user--section {
	display: flex; /* 플렉스박스 사용 */
}

.personal--bar {
	width: 20%; /* 사이드바 너비 조정 */
	min-width: 200px; /* 최소 너비 설정 */
	padding: 1rem;
}

.col-md-9 {
	width: 80%; /* 메인 콘텐츠 영역 너비 조정 */
	padding: 1rem;
}

.inner--personal {
	border: 0px solid #eee;
	border-radius: 20px;
	padding: 2rem;
}

.table {
	width: 100%;
}

.table th, .table td {
	text-align: left;
	padding: 8px;
	border: 1px solid #ddd;
	vertical-align: middle;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.user--info table td {
	padding-left: 0.5rem;
}

.table th {
	text-align: center !important;
}

.user--section {
	width: 100vh;
}
</style>
<main class="user--section">
	<!-- 왼쪽 사이드바 -->
	<aside class="personal--bar">
		<div class="bar--items">
			<p>내 정보</p>
			<a href="/advertiser/my-info" data-feather="users"><span
				data-feather="users"></span>계정관리</a>
		</div>
		<div class="bar--items">
			<p>광고</p>
			<a href="/advertiser/application"><span data-feather="file"></span>신청하기</a>
			<a href="/advertiser/application-list"><span data-feather="file"></span>신청내역</a>
			<a href="/advertiser/active-list"><span
				data-feather="shopping-cart"></span>게시 내역</a> <a
				href="/advertiser/payment"><span data-feather="bar-chart-2"></span>충전하기</a>
				<a href="/advertiser/requesting-refund">환불 요청</a>
		</div>
		<div class="bar--items">
			<p>탈퇴</p>
			<a href="/advertiser/withdraw" class="bar--selected"><span
				data-feather="message-square"></span>탈퇴하기</a>
		</div>
	</aside>

	<!-- 메인 컨텐츠 영역 -->
	<section class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
		<div class="personal--wrap">
			<div>
				<h2>탈퇴</h2>
				<p>회원 탈퇴하기</p>
			</div>

			<div class="inner--personal">
				<div class="user--info">
					<!-- 탈퇴 안내 메시지 -->
					<p>회원 탈퇴 안내</p>
					<p>탈퇴를 진행하시겠습니까? 탈퇴 시 모든 정보는 복구할 수 없습니다.</p>
					<!-- 탈퇴 사유 입력 및 탈퇴 버튼 -->
					<form action="/advertiser/withdraw" method="post">
						<div class="form-group">
							<label for="withdrawReason">탈퇴 사유</label>
							<textarea class="form-control" id="reason" name="reason" rows="3"
								placeholder="탈퇴 사유를 입력해주세요" required></textarea>
						</div>
						<br>
						<button type="submit" class="btn btn-danger">회원 탈퇴</button>
					</form>
				</div>
			</div>
		</div>
	</section>

</main>


<%@ include file="/WEB-INF/view/layout/lightFooter.jsp"%>