package com.tenco.perfectfolio.repository.model.company;

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
public class Bookmark {

	private Integer id;
	private Integer comId;
	private Integer userId;
	private Timestamp bookmarkDate;
	
}
