<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>

<div class="container">
	<h2>광고 신청 상세 보기</h2>
	<br>
	<c:if test="${not empty application}">
		<table class="table table-bordered">
			<tr>
				<th>신청 ID</th>
				<td>${application.id}</td>
			</tr>
			<tr>
				<th>신청자</th>
				<td>${application.username}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${application.title}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${application.content}</td>
			</tr>
			<tr>
				<th>상태</th>
				<td>${application.state}</td>
			</tr>
			<tr>
				<th>파일 이름</th>
				<td>${application.originFileName}</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>${application.site}</td>
			</tr>
			<tr>
				<th>업로드된 이미지</th>
				<td>
					<c:if test="${not empty imagePath}">
						<img src="${imagePath}" alt="Uploaded Image" style="max-width: 100%;">
					</c:if>
					<c:if test="${not empty imageError}">
						<p>${imageError}</p>
					</c:if>
				</td>
			</tr>
			<tr>
				<th>이미지 크기 (픽셀)</th>
				<td>
					<c:if test="${not empty imageWidth and not empty imageHeight}">
                        ${imageWidth} x ${imageHeight} 픽셀
                    </c:if>
				</td>
			</tr>
		</table>

		<!-- 승인 버튼 -->
		<form id="approveForm" action="/advertiser/approve" method="post">
			<input type="hidden" name="id" value="${application.id}">
			<button type="button" onclick="confirmApprove()" class="btn btn-success">승인</button>
		</form>

		<!-- 거절 버튼 -->
		<form id="rejectForm" action="/advertiser/reject" method="post">
			<input type="hidden" name="id" value="${application.id}">
			<button type="button" onclick="promptRejectReason()" class="btn btn-danger">거절</button>
		</form>
	</c:if>
	<c:if test="${empty application}">
		<p>신청 정보를 불러오는 중 오류가 발생했습니다.</p>
	</c:if>
</div>

<script>
	// 승인 확인 알림창
	function confirmApprove() {
		if (confirm("정말 승인을 진행하시겠습니까?")) {
			document.getElementById("approveForm").submit();
		}
	}

	// 거절 사유 입력 및 제출
	function promptRejectReason() {
		if (confirm("거절 하시겠습니까?")) {
			document.getElementById("rejectForm").submit();
		}
	}
</script>

<%@ include file="/WEB-INF/view/layout/lightFooter.jsp"%>
