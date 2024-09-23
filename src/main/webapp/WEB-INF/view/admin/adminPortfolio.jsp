<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/adminLayout/header.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/adminMain.css">
<link rel="stylesheet" href="/css/chart.css">

<main class="contents--wrap">

	<c:choose>
		<c:when test="${not empty portfolioWaitList}">
			<c:forEach items="${portfolioWaitList}" var="portfolio">
				<div class="portfolio-item">
					<h3>${userNameMap.get(portfolio.userId)}님의포트폴리오</h3>
					<p>
						업로드 파일: <a href="/portfolio/download/${portfolio.uploadFileName}"
							style="color: black; text-decoration: none;">다운로드 확인하기</a>
					</p>
					<p>상태: ${portfolio.status}</p>

					<c:if test="${portfolio.status eq '대기'}">
						<!-- 단일 폼으로 여러 버튼 관리 -->
						<form action="/portfolio/approve" method="post">
							<input type="hidden" name="portfolioId"
								value="${portfolio.userId}">
							<button type="submit" name="action" value="approve">승인</button>
							<button type="submit" formaction="/portfolio/reject"
								name="action" value="reject">반려</button>
						</form>
					</c:if>
				</div>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<div class="no-portfolio">
				<p>작업할 포트폴리오가 없습니다.</p>
			</div>
		</c:otherwise>
	</c:choose>
</main>

<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/adminLayout/footer.jsp"%>