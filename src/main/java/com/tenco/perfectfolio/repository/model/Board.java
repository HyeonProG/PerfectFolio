package com.tenco.perfectfolio.repository.model;

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
public class Board {

	private Integer id;
	private String categories;
	private String title;
	private Integer userId;
	private String writer;
	private String content;
	private String createdAt;
	private String deletedAt;
	private Integer views;
	
}
