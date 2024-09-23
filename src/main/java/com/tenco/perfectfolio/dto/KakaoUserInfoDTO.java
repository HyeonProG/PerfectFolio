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
public class KakaoUserInfoDTO {
	public String id;
	public String connectedApp;
	public Properties properties;
	
	@Data
	public class Properties {
		private String nickname;
		private String profileImage;
		private String thumbnailImage;
	}
}
