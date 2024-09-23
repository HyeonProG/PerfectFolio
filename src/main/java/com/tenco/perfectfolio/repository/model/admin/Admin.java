package com.tenco.perfectfolio.repository.model.admin;

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
public class Admin {
	private Integer id;
	private String adminName;
	private String adminId;
	private String adminPassword;
	private String adminEmail;
	private String adminGender;
	private Timestamp createdAt;
	
}
