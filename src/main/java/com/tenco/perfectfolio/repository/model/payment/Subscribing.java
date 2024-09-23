package com.tenco.perfectfolio.repository.model.payment;

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
public class Subscribing{

	private Integer id;
	private String subscribing;
	private String orderName;
	private String billingKey;
	private String customerKey;
	private Integer amount;
	private Integer userId;
	private Date createdAt;
	private String nextPay;
	
}
