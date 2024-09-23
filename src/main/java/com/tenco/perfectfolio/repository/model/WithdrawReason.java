package com.tenco.perfectfolio.repository.model;

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
public class WithdrawReason {

	private Integer id;
	private String userId;
	private String reaseon;
	private String reasonDetail;
}
