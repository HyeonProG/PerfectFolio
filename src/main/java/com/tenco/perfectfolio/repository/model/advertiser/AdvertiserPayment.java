package com.tenco.perfectfolio.repository.model.advertiser;

import java.util.Date;

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
public class AdvertiserPayment {

	private Integer id;
	private Integer userId;
	private String orderId;
	private String paymentKey;
	private Integer amount;
	private String requestedAt;
	private String approvedAt;
	private String cancelReason;
	private Integer cancelAmount;
	private Date createdAt;
	private String state;
	
}
