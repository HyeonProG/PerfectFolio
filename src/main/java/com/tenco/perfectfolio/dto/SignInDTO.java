package com.tenco.perfectfolio.dto;

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
public class SignInDTO {

	private String userId;
	private String userPassword;
	
	public Admin toAdmin() {
		return Admin.builder()
				.adminId(this.userId)
				.adminPassword(this.userPassword)
				.build();
	}
	
}