<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/myInfoAd.css">
<style>
.user--section{
	width:100vh;
}
</style>
<main class="user--section">
	<!-- 왼쪽 사이드바 -->
	<aside class="personal--bar">
		<div class="bar--items">
			<p>내 정보</p>
			<a href="/advertiser/my-info" class="bar--selected"
				data-feather="users"><span data-feather="users"></span>계정관리</a>
		</div>
		<div class="bar--items">
			<p>광고</p>
			<a href="/advertiser/application"><span data-feather="file"></span>신청하기</a>
			<a href="/advertiser/application-list"><span data-feather="file"></span>신청내역</a>
			<a href="/advertiser/active-list"><span
				data-feather="shopping-cart"></span>게시 내역</a> 
			<a href="/advertiser/payment"><span data-feather="bar-chart-2"></span>충전하기</a>
			<a href="/advertiser/requesting-refund">환불 요청</a>
		</div>
		<div class="bar--items">
			<p>탈퇴</p>
			<a href="/advertiser/withdraw"><span
				data-feather="message-square"></span>탈퇴하기</a>
		</div>
	</aside>

	<!-- 메인 컨텐츠 영역 -->
	<section>
		<div class="personal--wrap">
			<div>
				<h2>계정관리</h2>
				<p>기본정보</p>
			</div>

			<div class="inner--personal">
				<div class="user--info">
					<!-- 내 프로필 정보 -->
					<c:choose>
						<c:when test="${advertiser != null}">
							<table>
								<!-- 잔액 표시 -->
								<tr>
									<th>잔액</th>
									<td><span id="balance">${balance}</span> 원</td>
								</tr>
								<tr>
									<th>이름</th>
									<td>${advertiser.username}
									</td>
								</tr>
								<tr>
									<th>아이디</th>
									<td>${advertiser.userId}</td>
								</tr>
								<tr>
									<th>전화번호</th>
									<td>${advertiser.userTel}</td>
								</tr>
								<tr>
									<th>가입일</th>
									<td><fmt:formatDate value="${advertiser.createdAt}"
											pattern="yyyy-MM-dd" /></td>
								</tr>
							</table>
						</c:when>
						<c:otherwise>
							<p>오류</p>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</section>
</main>

<script>
    // 잔액 업데이트 함수
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
</script>

<%@ include file="/WEB-INF/view/layout/lightFooter.jsp"%>