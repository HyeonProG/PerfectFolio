package com.tenco.perfectfolio.dto.advertiser;

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
public class AdvertiserSignInDTO {

	private String userId;
	private String password;

	
}
