package com.tenco.perfectfolio.repository.model;

import java.sql.Timestamp;

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
public class UserWithdraw {
	
	private int id;
	private String userName;
	private String userId;
	private String userPassword;
	private String UserNickname;
	private String UserEmail;
	private String userBirth;
	private String userGender;
	private String userTel;
	private String socialType;
	private String createdAt;
	private Timestamp withdrawAt;
	
}

