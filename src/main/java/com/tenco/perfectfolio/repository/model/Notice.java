package com.tenco.perfectfolio.repository.model;

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
public class Notice {

	private Integer id;
	private String categories;
	private String title;
	private String content;
	private Timestamp createdAt;
	private Integer views;
	
}
