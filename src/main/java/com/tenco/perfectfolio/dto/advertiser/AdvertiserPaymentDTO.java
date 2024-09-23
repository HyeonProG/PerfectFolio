package com.tenco.perfectfolio.dto.advertiser;

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
public class AdvertiserPaymentDTO {

	private Integer id;
	private Integer userId;
	private String orderId;
	private String orderName;
	private String paymentKey;
	private Integer amount;
	private String requestedAt;
	private String approvedAt;
	private Date createdAt;
	
}
