package com.tenco.perfectfolio.dto.advertiser;

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
public class AdvertiserRefundDTO {

	private Integer userId;
	private String paymentKey;
	private String orderId;
	private String cancelReason;
	private String requestedAt;
	private String approvedAt;
	private Integer cancelAmount;
	
}
