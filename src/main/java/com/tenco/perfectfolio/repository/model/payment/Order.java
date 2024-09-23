package com.tenco.perfectfolio.repository.model.payment;

import com.tenco.perfectfolio.repository.model.Board;

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
public class Order {
	
	private Integer id;
	private Integer userId;
	private String customerKey;
	private String billingKey;
	private Integer amount;
	private String orderId;
	private String orderName;
	private Integer billingErrorCode;
	private Integer payErrorCode;
	private String created_at;
	
}
