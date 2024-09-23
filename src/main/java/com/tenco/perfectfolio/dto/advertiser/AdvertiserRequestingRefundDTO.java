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
public class AdvertiserRequestingRefundDTO {

	private Integer id;
	private Integer userId;
	private String paymentDate;
	private String paymentAmount;
	private String refundAmount;
	private String reason;
	private String createdAt;
	private String approved;
	private String rejectReason;
	
}
