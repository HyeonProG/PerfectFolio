package com.tenco.perfectfolio.dto;

import java.sql.Date;

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
public class NaverToken {
	private String access_token;
	private String refresh_token;
	private String token_type;
	private Integer expires_in;
	private String error;
	private String error_description;
	private String result;
}
