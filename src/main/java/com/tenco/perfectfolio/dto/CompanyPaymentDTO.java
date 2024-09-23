package com.tenco.perfectfolio.dto;

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
public class CompanyPaymentDTO {

	private Integer id;
	private Integer userId;
	private String orderId;
	private String orderName;
	private String paymentKey;
	private Integer amount;
	private Date createdAt;
	
}
