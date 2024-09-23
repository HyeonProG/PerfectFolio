package com.tenco.perfectfolio.repository.model.payment;

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
public class Payment{

	private Integer id;
	private Integer userId;
	private String lastTransactionKey;
	private String paymentKey;
	private String orderId;
	private String orderName;
	private String billingKey;
	private String customerKey;
	private Integer amount;
	private String totalAmount;
	private String requestedAt;
	private String approvedAt;
	private String cancel;
	
}
