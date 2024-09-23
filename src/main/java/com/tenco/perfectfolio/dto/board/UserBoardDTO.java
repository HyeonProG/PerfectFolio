package com.tenco.perfectfolio.dto.board;

import com.tenco.perfectfolio.repository.model.Board;

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
public class UserBoardDTO {

	private Integer id;
	private String category;
	private String title;
	private Integer userId;
	private String writer;
	private String createdAt;
	private String content;
	private Integer views;

	// Board 반환
	public Board toBoard() {
		return Board.builder().id(id).categories(this.category).title(this.title).userId(this.userId).writer(this.writer)
				.createdAt(this.createdAt).content(this.content).build();

	}
}
