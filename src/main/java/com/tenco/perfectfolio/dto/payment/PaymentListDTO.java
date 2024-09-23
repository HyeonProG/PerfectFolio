package com.tenco.perfectfolio.dto.payment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class PaymentListDTO{

	private Integer id;
	private String orderId;
	private String orderName;
	private String paymentKey;
	private String billingKey;
	private String requestedAt;
	private String approvedAt;
	private String totalAmount;
	private String cancel;
	
}
