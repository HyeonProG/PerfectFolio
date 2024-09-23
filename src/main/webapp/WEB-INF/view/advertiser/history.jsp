<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/myInfoAd.css">

<section class="user--section">
	<!-- side bar -->
	<aside class="personal--bar">
		<div class="bar--items">
			<p>내 정보</p>
			<a href="#">계정관리</a>
		</div>
		<div class="bar--items">
			<p>광고</p>
			<a href="/advertiser/application">신청하기</a>
			<a href="/advertiser/history" class="bar--selected">신청내역</a>
		</div>
	</aside>

	<!-- content -->
	<div class="personal--wrap">
		<div>
			<h2>광고</h2>
			<p>신청내역</p>
		</div>
		
			<div class="inner--personal">
		<div class="user--info">
				<!-- 잔액 표시 -->
		<div>
			<h3>
				나의 잔액: <span id="balance">${balance}</span> 원
			</h3>
		</div>

		<hr>

		<!-- 신청한 광고 내역 -->
		<h3>내가 신청한 광고 내역</h3>

		<c:if test="${not empty applications}">
			<!-- 신청한 광고가 있을 경우 -->
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>신청 ID</th>
						<th>제목</th>
						<th>상태</th>
						<th>신청일</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="application" items="${applications}">
						<tr>
							<td>${application.id}</td>
							<td>${application.title}</td>
							<td>${application.state}</td>
							<td><fmt:formatDate value="${application.createdAt}"
									pattern="yyyy-MM-dd HH:mm" /></td>
							<td>
								<form id="cancelForm-${application.id}"
									action="/advertiser/cancel" method="post">
									<input type="hidden" name="id" value="${application.id}">
									<button type="button" onclick="cancel(${application.id})"
										class="btn btn-success">취소</button>
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
		<c:if test="${empty applications}">
			<!-- 신청한 광고가 없을 경우 -->
			<p>신청한 광고가 없습니다.</p>
		</c:if>

		<hr>

		<!-- 사용중인 광고 내역 -->
		<h3>사용중인 광고 내역</h3>

		<c:if test="${not empty activeAds}">
			<!-- 사용중인 광고가 있을 경우 -->
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>광고 ID</th>
						<th>제목</th>
						<th>상태</th>
						<th>광고 시작일</th>
						<th>조회수</th>
						<th>접속수</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="ad" items="${activeAds}">
						<tr>
							<td>${ad.id}</td>
							<td>${ad.title}</td>
							<td>${ad.state}</td>
							<td><fmt:formatDate value="${ad.createdAt}"
									pattern="yyyy-MM-dd" /></td>
							<td>${ad.viewCount}</td>
							<td>${ad.clickCount}</td>
							<c:if test="${ad.state eq '승인'}">
								<td>
									<form id="updateForm-${ad.id}" action="/advertiser/update-ad"
										method="post">
										<input type="hidden" name="id" value="${ad.id}"> <input
											type="hidden" name="state" value="중지">
										<button type="button" onclick="stop(${ad.id})"
											class="btn btn-success">중지</button>
									</form>
								</td>
							</c:if>
							<c:if test="${ad.state eq '중지'}">
								<td>
									<form id="updateForm-${ad.id}" action="/advertiser/update-ad"
										method="post">
										<input type="hidden" name="id" value="${ad.id}"> <input
											type="hidden" name="state" value="승인">
										<button type="button" onclick="use(${ad.id})"
											class="btn btn-success">사용</button>
									</form>
								</td>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
		<c:if test="${empty activeAds}">
			<!-- 사용중인 광고가 없을 경우 -->
			<p>현재 사용중인 광고가 없습니다.</p>
		</c:if>
		</div>
	</div>
		
	</div>
</section>

<script>
	function updateBalance() {
	    fetch('http:perfecfolio.jinnymo.com/advertiser/get-balance')
	        .then(response => response.json())
	        .then(data => {
	            if (data.balance) {
	                document.getElementById('balance').textContent = data.balance;
	            } else {
	                console.error('잔액 데이터 오류:', data);
	            }
	        })
	        .catch(error => console.error('오류 발생:', error));
	}
	
	document.addEventListener('DOMContentLoaded', updateBalance);

	function cancel(id) {
		if (confirm("취소하시겠습니까?")) {
			document.getElementById("cancelForm-" + id).submit();
		}
	}
	
	function stop(id) {
		if (confirm("중지하시겠습니까?")) {
			document.getElementById("updateForm-" + id).submit();
		}
	}

	function use(id) {
		if (confirm("다시 사용하시겠습니까?")) {
			document.getElementById("updateForm-" + id).submit();
		}
	}
</script>

<%@ include file="/WEB-INF/view/layout/lightFooter.jsp"%>