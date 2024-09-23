package com.tenco.perfectfolio.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class PrincipalDTO {

	private Integer id;
	private String username;
	private String userId;
	private String userSocialType;
	private String subscribing;
	private String orderName;
}
