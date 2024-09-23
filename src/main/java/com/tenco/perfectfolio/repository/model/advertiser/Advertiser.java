package com.tenco.perfectfolio.repository.model.advertiser;

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
public class Advertiser {

	private Integer id;
	private String userId;
	private String username;
	private String title;
	private String content;
	private String site;
	private String password;
	private String userTel;
	private Timestamp createdAt;
	private String originFileName;
	private String uploadFileName;
	private String state;
	private Integer balance;
	
}
