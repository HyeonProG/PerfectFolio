<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/adminLayout/header.jsp"%>

<link rel="stylesheet" href="/css/adminMain.css">
<style>
.contents--wrap {
	padding-top: 64px;
	background-color: #fcfcfc;
	width: 80%;
	height: 100%;
	margin: 0 auto;
}
</style>

<main class="contents--wrap">
	<div class="container">
		<h2>광고 신청 검토 페이지</h2>
		<br>
		<c:if test="${not empty applicationsList}">
			<table class="table table-striped">
				<thead>
					<tr>
						<th>신청 ID</th>
						<th>신청자</th>
						<th>제목</th>
						<th>내용</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="application" items="${applicationsList}">
						<tr>
							<td>${application.id}</td>
							<td>${application.username}</td>
							<td><a href="/advertiser/review/detail/${application.id}">${application.title}</a></td>
							<td>${application.content}</td>
							<td>${application.state}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
		<c:if test="${empty pendingApplications}">
			<p>승인 대기중인 광고 신청이 없습니다.</p>
		</c:if>
	</div>
</main>

<%@ include file="/WEB-INF/view/adminLayout/footer.jsp"%>
