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
public class NaverUserInfoDTO {

	public String resultcode;
	public String message;
	public response response;

	@Data
	public class response {
		String id;
		String nickname;
		String name;
		String email;
		String gender;
		String age;
		String birthday;
		String profile_image;
		String birthyear;
		String mobile;
	}

	public String genderType(String gender) {
		if (gender.equals("M")) {
			response.setGender("남성");
//			naverUserInfoDTO.getResponse().setGender("남성");
		} else if (gender.equals("F")) {
			response.setGender("여성");
//			naverUserInfoDTO.getResponse().setGender("여성");
		}else {
			response.setGender("");
		}
		return gender;
	}
	
}
