package com.tenco.perfectfolio.dto.admin;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class UserManagementDTO {

	private Integer id;
	private String username;
	private String userId;
	private String userEmail;
	private String userNickname;
	private Timestamp createdAt;
	private Integer orderDays;
}
