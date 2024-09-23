package com.tenco.perfectfolio.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tenco.perfectfolio.dto.board.UserBoardDTO;
import com.tenco.perfectfolio.repository.interfaces.BoardRepository;
import com.tenco.perfectfolio.repository.model.Board;
import com.tenco.perfectfolio.repository.model.Notice;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardService {

	@Autowired
	private final BoardRepository boardRepository;

	@Transactional
	public void createBoard(Board board) {
		int result = 0;
		result = boardRepository.insert(board);
	};

	@Transactional
	public void updateBoard(Board board) {
		int result = 0;
		result = boardRepository.update(board);
	};

	public Board viewBoard(Integer boardId) {
		Board board = null;
		board = boardRepository.viewBoardById(boardId);
		return board;
	};

	public int checkSameUser(Integer id) {
		int result = 0;
		result = boardRepository.checkSameUser(id);

		return result;
	};

	@Transactional
	public void deleteBoard(Integer boardId) {
		int insertResult = 0;
		Board board = boardRepository.viewBoardById(boardId);
		insertResult = boardRepository.insertDeleteBoard(board);
		boardRepository.deleteBoard(boardId);
	}

	@Transactional
	public void increaseViews(Integer views, Integer boardId) {
		int result = 0;
		views += 1;
		result = boardRepository.increaseViews(views, boardId);
	}

	// 문의사항 검색 및 페이징 처리
	public List<Board> searchBoard(String categories, String searchRange, String searchContents, Integer page,
			Integer size) {
		int offset = (page - 1) * size;
		List<Board> boardList = null;

		if (categories != null) {
			if (searchRange.equals("제목")) {
				boardList = boardRepository.searchCategoryAndTitle(categories, searchContents, size, offset);
			} else if (searchRange.equals("제목내용")) {
				boardList = boardRepository.searchCategoryAndTitleAndContent(categories, searchContents, size, offset);
			} 
		} else {
			if (searchRange.equals("제목")) {
				boardList = boardRepository.searchOnlyTitle(searchContents, size, offset);
			} else {
				boardList = boardRepository.searchOnlyTitleAndContent(searchContents, size, offset);
			}

		}

		return boardList;
	}

	// 전체 문의사항 조회 및 페이징 처리
	public List<Board> getAllBoards(Integer page, Integer size) {
		List<Board> list = new ArrayList<>();
		int limit = size;
		int offset = (page - 1) * size;
		list = boardRepository.readAllBoardList(size, offset);
		return list;
	}

	// 문의사항 게시글 수 - 검색 값 O
	public int getBoardCounts(String categories, String searchRange, String searchContents) {
		int count = 0;

		if (categories != null) {
			if (searchRange.equals("제목")) {
				count = boardRepository.countsCategoryAndTitle(categories,searchContents);
			} else if (searchRange.equals("제목내용")) {
				count = boardRepository.countsCategoryAndTitleAndContent(categories,searchContents);
			}
		} else {
			if (searchRange.equals("제목")) {
				count = boardRepository.countsOnlyTitle(searchContents);
			} else {
				count = boardRepository.countsOnlyTitleAndContent(searchContents);
			}

		}

		return count;
	}

	// 문의사항 게시글 수 - 검색 값 X
	public int getBoardCounts() {
		int count = 0;
		count = boardRepository.getBoardCounts();
		return count;
	}

}
