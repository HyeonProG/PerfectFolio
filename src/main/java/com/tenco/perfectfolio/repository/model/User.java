package com.tenco.perfectfolio.repository.model;

import java.sql.Timestamp;

import com.tenco.perfectfolio.dto.admin.AdminUserInfoDTO;
import com.tenco.perfectfolio.dto.admin.UserManagementDTO;

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
public class User {
	private Integer id;
	private String username;
	private String userId;
	private String userPassword;
	private String userNickname;
	private String userEmail;
	private String userBirth;
	private String userGender;
	private String userTel;
	private Timestamp createdAt;
	private String socialType;
	private String subscribing;
	private String orderName;
	

	public AdminUserInfoDTO toDTO(){

		return AdminUserInfoDTO.builder()
				.id(id)
				.username(username)
				.userNickname(userNickname)
				.createdAt(createdAt.toString())
				.userSocialType(socialType)
				.build();

	}
	

	
}
