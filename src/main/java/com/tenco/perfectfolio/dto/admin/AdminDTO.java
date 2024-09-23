package com.tenco.perfectfolio.dto.admin;

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
public class AdminDTO {

	private Integer id;
	private String adminName;
	private String adminEmail;
	
}
