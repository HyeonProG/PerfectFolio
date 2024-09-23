package com.tenco.perfectfolio.dto;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

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
public class PortfolioDTO {

	private Integer userId;
	private String originFileName;
	private String uploadFileName;
	private MultipartFile mFile;
	private String status;
	
}
