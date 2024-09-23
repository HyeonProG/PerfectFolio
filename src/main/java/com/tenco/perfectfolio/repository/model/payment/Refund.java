package com.tenco.perfectfolio.repository.model.payment;

import com.tenco.perfectfolio.dto.payment.PaymentDTO;
import com.tenco.perfectfolio.dto.payment.PaymentDTO.Card;
import com.tenco.perfectfolio.utils.ValueFormatter;

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
public class Refund{
	
	private Integer id;
	private String lastTransactionKey;
	private String paymentKey;
	private String cancelReason;
	private String requestedAt;
	private String approvedAt;
	private String cancelAmount;
	private Integer adminId;
	
}
