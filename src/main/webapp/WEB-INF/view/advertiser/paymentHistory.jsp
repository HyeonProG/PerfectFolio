<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>

<div class="container">
	<h2>결제 내역</h2>

	<div>
		<h3>
			나의 잔액: <span id="balance">${balance}</span> 원
		</h3>
	</div>

	<table class="table table-bordered">
		<thead>
			<tr>
				<th>ID</th>
				<th>주문 ID</th>
				<th>결제 금액</th>
				<th>결제 날짜</th>
				<th>환불 신청</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="payment" items="${paymentHistory}">
				<tr>
					<td>${payment.id}</td>
					<td>${payment.orderId}</td>
					<td>${payment.amount}</td>
					<td><fmt:formatDate value="${payment.createdAt}"
							pattern="yyyy-dd-MM HH:mm" /></td>
					<td>
						<form id="refundForm-${payment.id}"
							action="/advertiser/application-refund" method="post">
							<input type="hidden" name="paymentKey"
								value=${"payment.paymentKey"}> <input type="hidden"
								name="id" value="${payment.id}"> <input type="hidden"
								id="refundReason-${payment.id}" name="cancelReason" value="">
							<input type="hidden" id="refundState-${payment.id}" name="state"
								value="대기">
							<button type="button" class="btn btn-success"
								onclick="submitRefund(${payment.id})">환불</button>
						</form>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<a href="">돌아가기</a>
</div>

<script>
	// 환불 요청 처리
	function submitRefund(paymentId) {
		// 환불 사유를 입력받기 위한 prompt 창 표시
		let refundReason = prompt("환불 사유를 입력하세요:");

		if (refundReason !== null && refundReason.trim() !== "") {
			// 입력된 환불 사유를 숨겨진 필드에 설정
			document.getElementById('refundReason-' + paymentId).value = refundReason;

			// 환불 상태를 '대기'로 설정
			document.getElementById('refundState-' + paymentId).value = "대기";

			// 해당 폼 제출
			document.getElementById('refundForm-' + paymentId).submit();
		} else {
			alert("환불 사유를 입력해야 합니다.");
		}
	}

	// 잔액 업데이트
	function updateBalance() {
		fetch('http://localhost:8080/advertiser/get-balance')
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

