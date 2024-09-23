package com.tenco.perfectfolio.dto.advertiser;

import java.sql.Timestamp;

import com.tenco.perfectfolio.repository.model.advertiser.Advertiser;

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
public class AdvertiserSignUpDTO {

	private String userId;
	private String username;
	private String password;
	private String userTel;
	private Timestamp createdAt;
	
	public Advertiser toAdvertiser() {
		return Advertiser.builder()
				.userId(this.userId)
				.username(this.username)
				.password(this.password)
				.userTel(this.userTel)
				.createdAt(this.createdAt)
				.build();
	}
	
}
