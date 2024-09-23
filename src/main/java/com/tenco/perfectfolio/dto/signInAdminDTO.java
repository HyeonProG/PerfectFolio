package com.tenco.perfectfolio.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class signInAdminDTO {
	
	private String adminId;
	private String adminPassword;
	
}
