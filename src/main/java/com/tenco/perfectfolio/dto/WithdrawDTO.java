package com.tenco.perfectfolio.dto;

import java.sql.Timestamp;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class WithdrawDTO {

	private int id;
	private String userId;
	private String createdAt;
	private Timestamp withdrawAt;
	private String reason;
	private String reasonDetail;
	private int count;
	

}
