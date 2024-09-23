package com.tenco.perfectfolio.dto;

import com.tenco.perfectfolio.repository.model.User;
import com.tenco.perfectfolio.repository.model.admin.Admin;

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
public class SignUpDTO {
	
	private String username;
	private String userId;
	private String userPassword;
	private String passwordCheck;
	private String userNickname;
	private String userEmail;
	private String userBirth;
	private String userGender;
	private String userTel;
//	private MultipartFile mFile;
//	private String userOriginProfileImage;
//	private String userUploadProfileImage;
	private String userSocialType;
	
	// 사업자번호
	private String userTexId;
	

	// User Object 반환 
	public User toUser() {
		return User.builder()
				.username(this.username)
				.userId(this.userId)
				.userPassword(this.userPassword)
				.userNickname(this.userNickname)
				.userEmail(this.userEmail)
				.userBirth(this.userBirth)
				.userGender(this.userGender)
				.userTel(this.userTel)
				.socialType(this.userSocialType)
				.build();
	} 
	
	
}
