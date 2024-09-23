package com.tenco.perfectfolio.dto.admin;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class UserCountDTO {

	private String year;
	private String month;
	private Integer count;
	private String gender;
	private String ageGroup; // 연령별(문자열)
	private String socialType;
	private String reason;
}
