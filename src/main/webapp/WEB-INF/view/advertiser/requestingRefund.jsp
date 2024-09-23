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
			<a href="/advertiser/requesting-refund" class="bar--selected">환불
				요청</a>
		</div>
		<div class="bar--items">
			<p>탈퇴</p>
			<a href="/advertiser/withdraw"><span
				data-feather="message-square"></span>탈퇴하기</a>
		</div>
	</aside>

	<!-- 메인 컨텐츠 영역 -->
	<section class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
		<div class="personal--wrap">
			<div>
				<h2>광고</h2>
				<p>환불 요청 내역</p>
			</div>

			<div class="inner--personal">
				<div class="user--info">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>요청일</th>
								<th>처리</th>
							</tr>
						</thead>
						<tbody id="boardList">
							<c:forEach var="requestingList" items="${requestingList}">
								<tr>
									<td>${requestingList.createdAt}</td>
									<td>${requestingList.approved}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<div>
				<p>처리 내역</p>
			</div>
			<div class="inner--personal">
				<div class="user--info">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>요청일</th>
								<th>처리</th>
							</tr>
						</thead>
						<tbody id="boardList">
							<c:forEach var="doneList" items="${doneList}">
								<tr>
									<td>${doneList.createdAt}</td>
									<td>${doneList.approved}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<div>
				<p>환불 요청하기</p>
			</div>
			<div class="inner--personal">
				<div class="user--info">

					<form action="/advertiser/requesting-refund" method="post">
						<div class="form-group">
							<label for="content">결제일</label> <input type="text"
								class="form-control" placeholder="결제일을 입력하세요." id="content"
								name="paymentDate" required>
						</div>
						<div class="form-group">
							<label for="content">결제 금액</label> <input type="text"
								class="form-control" placeholder="결제한 금액을 입력하세요." id="content"
								name="paymentAmount" required>
						</div>
						<div class="form-group">
							<label for="content">환불 요청 금액</label> <input type="text"
								class="form-control" placeholder="환불 요청할 금액을 입력하세요."
								id="content" name="refundAmount" required>
						</div>
						<div class="form-group">
							<label for="content">환불 사유</label> <input type="text"
								class="form-control" placeholder="환불 사유를 입력하세요." id="content"
								name="reason" required>
						</div>
						<div class="inline--btn--wrap">
							<button type="submit" class="info--btn">신청하기</button>
						</div>
					</form>

				</div>
			</div>
		</div>
	</section>

</main>

<%@ include file="/WEB-INF/view/layout/lightFooter.jsp"%>