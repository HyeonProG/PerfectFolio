package com.tenco.perfectfolio.dto;

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
public class KakaoAddUserInfoDTO {

	private String username;
	private String userEmail;
	private String userBirth;
	private String userGender;
	private String userTel;
}
