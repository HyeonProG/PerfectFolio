package com.tenco.perfectfolio.dto.advertiser;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

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
public class AdvertiserApplicationDTO {

	private Integer id;
	private Integer userId;
	private String username;
	private String title;
	private String content;
	private String site;
	private String originFileName;
	private String uploadFileName;
	private Integer viewCount;
	private Integer clickCount;
	private Integer balance;
	private MultipartFile mFile;
	private Timestamp createdAt;
	private String state;
	
	
	public Advertiser toAdvertiser() {
		return Advertiser.builder()
				.id(this.userId)
				.title(this.title)
				.content(this.content)
				.balance(this.balance)
				.originFileName(this.originFileName)
				.uploadFileName(this.uploadFileName)
				.build();
	}
	
}
