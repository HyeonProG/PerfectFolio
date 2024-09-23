package com.tenco.perfectfolio.dto;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class KakaoToken {
	public String token_type;
	public String access_token;
	public Integer expires_in;
	public String refresh_token;
	public Integer refresh_token_expires_in;
}
