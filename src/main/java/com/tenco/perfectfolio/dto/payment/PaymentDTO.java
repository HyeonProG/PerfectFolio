package com.tenco.perfectfolio.dto.payment;

import java.util.Date;

import com.tenco.perfectfolio.repository.model.payment.Order;
import com.tenco.perfectfolio.repository.model.payment.Payment;
import com.tenco.perfectfolio.repository.model.payment.Refund;
import com.tenco.perfectfolio.repository.model.payment.Subscribing;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class PaymentDTO{
	// 결제 시도시 필요한 값
	private Integer userId;
	private String customerKey;
	private String billingKey;
	private Integer amount;
	private String orderName;

	// 결제 완료 후 받아오는 값
	private String lastTransactionKey;
	private String paymentKey;
	private String orderId;
	private String orderName2;
	private String requestedAt;
	private String approvedAt;
	private String totalAmount;
	private String cancel;
	private Card card;

	// 결체 취소시 입력되는 값
	private String cancelReason;
	private String cancelAmount;
	private Integer adminId;

	// 다음 정기결제일 계산
	private String nextPay;
	
	// 에러 메시지
	private Integer billingErrorCode;
	private Integer payErrorCode;
	private String billingErrorMsg;
	private String payErrorMsg;

	// 보류
	@Data
	public class Card {
		String number;
		String installmentPlanMonths;
		String cardType;
		String ownerType;
		String amount;
	}

	// Order 객체 반환
	public Order toOrder() {
		return Order.builder()
				.userId(userId)
				.customerKey(customerKey)
				.billingKey(billingKey)
				.amount(amount)
				.orderId(orderId)
				.orderName(orderName)
				.billingErrorCode(billingErrorCode)
				.payErrorCode(payErrorCode)
				.build();

	}

	// Payment 객체 반환
	public Payment toPayment() {
		return Payment.builder()
				.userId(userId)
				.lastTransactionKey(lastTransactionKey)
				.paymentKey(paymentKey)
				.orderId(orderId)
				.orderName(orderName2)
				.billingKey(billingKey)
				.customerKey(customerKey)
				.amount(amount)
				.totalAmount(totalAmount)
				.requestedAt(requestedAt)
				.approvedAt(approvedAt)
				.cancel(cancel)
				.build();
	}

	// Refund 객체 변환
	public Refund toRefund() {
		return Refund.builder()
				.lastTransactionKey(lastTransactionKey)
				.paymentKey(paymentKey)
				.cancelReason(cancelReason)
				.requestedAt(requestedAt)
				.approvedAt(approvedAt)
				.cancelAmount(cancelAmount)
				.adminId(adminId)
				.build();
	}

	// subscribing 객체 반환
	public Subscribing toSubscribing() {
		return Subscribing.builder()
				.subscribing("Y")
				.userId(userId)
				.orderName(orderName2)
				.billingKey(billingKey)
				.customerKey(customerKey)
				.amount(amount)
				.nextPay(nextPay)
				.build();
	}
	
}