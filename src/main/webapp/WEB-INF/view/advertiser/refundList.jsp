<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>

<div class="container">
	<h2>환불 요청 내역</h2>

	<table class="table table-bordered">
		<thead>
			<tr>
				<th>환불 ID</th>
				<th>주문 ID</th>
				<th>결제 금액</th>
				<th>환불 금액</th>
				<th>환불 사유</th>
				<th>환불 요청 날짜</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="refund" items="${refundList}">
				<tr>
					<td>${refund.id}</td>
					<td>${refund.orderId}</td>
					<td>${refund.amount}</td>
					<td>${refund.cancelAmount}</td>
					<td>${refund.cancelReason}</td>
					<td><fmt:formatDate value="${refund.requestedAt}" pattern="yyyy-MM-dd HH:mm" /></td>
					<td>${refund.status}</td>
				</tr>	
			</c:forEach>
		</tbody>
	</table>

	<a href="/admin">돌아가기</a>
</div>

<%@ include file="/WEB-INF/view/layout/lightFooter.jsp"%>
