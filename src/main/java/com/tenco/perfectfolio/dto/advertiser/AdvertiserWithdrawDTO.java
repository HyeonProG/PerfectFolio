package com.tenco.perfectfolio.dto.advertiser;

import java.sql.Timestamp;

import com.google.auto.value.AutoValue.Builder;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class AdvertiserWithdrawDTO {
    
	private Integer id;
	private String userId;
	private String userName;
	private String createdAt;
	private Timestamp withdrawAt;
	private String reason;

}
