package com.tenco.perfectfolio.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tenco.perfectfolio.dto.PrincipalDTO;
import com.tenco.perfectfolio.dto.board.UserBoardDTO;
import com.tenco.perfectfolio.repository.model.Board;
import com.tenco.perfectfolio.repository.model.Notice;
import com.tenco.perfectfolio.repository.model.User;
import com.tenco.perfectfolio.repository.model.admin.Admin;
import com.tenco.perfectfolio.service.BoardService;
import com.tenco.perfectfolio.service.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController {

	@Autowired
	private final UserService userService;
	@Autowired
	private final BoardService boardService;
	@Autowired
	private HttpSession session;

	// 게시판 파트 시작
	/**
	 * 문의사항 작성 페이지 요청
	 * 
	 * @returnboard/write.jsp
	 */
	@GetMapping("/write")
	public String boardWritePage() {
		return "board/write";
	}

	/**
	 * 문의사항 작성 로직 처리 요청
	 * 
	 * @param category  - 문의유형 : 회원정보, 구독/결제
	 * @param title     - 제목
	 * @param writer    - 세션에 내려준 회원 이름
	 * @param createdAt - 오늘 날짜 JS로 세팅
	 * @param comment   - 내용
	 * @return board/list.jsp
	 */
	@PostMapping("/write")
	public String createBoardProc(UserBoardDTO userBoardDTO) {
		boardService.createBoard(userBoardDTO.toBoard());
		return "redirect:/board/listPage";
	}
	
	/**
	 * 문의사항 전체 조회 화면
	 * @return
	 */
	@GetMapping("/listPage")
	public String listPage() {
		return "board/list";
	}

	/**
	 * 문의사항 리스트 전체 조회 및 검색 기능(페이징 처리 포함)
	 * 
	 * @return board/list.jsp
	 */
	@GetMapping("/list")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> boardListPage(
	        @RequestParam(name = "categories", defaultValue = "", required = false) String categories, 
	        @RequestParam(name = "searchRange", defaultValue = "", required = false) String searchRange, 
	        @RequestParam(name = "searchContents", defaultValue = "", required = false) String searchContents, 
	        @RequestParam(name = "page", defaultValue = "1") Integer page, 
	        @RequestParam(name = "size", defaultValue = "10") Integer size) {
		
		 try {
			 List<Board> boardList = null;
			 int totalCount = 0;

		        
	            if(!categories.isEmpty() || !searchContents.isEmpty()) {
	            	// 검색 조건이 있을 경우
	            	boardList = boardService.searchBoard(categories, searchRange,searchContents, page, size);
		            totalCount = boardService.getBoardCounts(categories, searchRange,searchContents);
	            }else {
	            	// 검색 조건이 없을 경우
	            	boardList = boardService.getAllBoards(page, size);
	            	totalCount = boardService.getBoardCounts();
	            }
	            
		        int totalPages = (int) Math.ceil((double) totalCount / size);

		        Map<String, Object> response = new HashMap<>();
		        response.put("totalCount", totalCount);
		        response.put("boardList", boardList);
		        response.put("totalPages", totalPages);
		        response.put("currentPage", page);
		        response.put("pageSize", size);

		        PrincipalDTO principalDTO = (PrincipalDTO) session.getAttribute("principalDTO");
		        if (principalDTO != null) {
		            response.put("principalDTO", principalDTO);
		        }

		        return ResponseEntity.ok(response);
		    } catch (Exception e) {
		        e.printStackTrace(); // 로그에 오류 출력
		        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		    }
	}

	/**
	 * 문의사항 상세보기 페이지 요청
	 * 
	 * @returno
	 */
	@GetMapping("/view")
	public String boardViewPage(Model model, @RequestParam(name = "boardId") Integer boardId) {
		Board board = boardService.viewBoard(boardId);
		boardService.increaseViews(board.getViews(), boardId);
		model.addAttribute("board", board);

		if (session.getAttribute("principal") != null) {
			PrincipalDTO principalDTO = (PrincipalDTO) session.getAttribute("principal");
			User user = userService.searchById(principalDTO.getId());
			int checkSameUser = boardService.checkSameUser(user.getId());
			if (checkSameUser != 0) {
				if (board.getUserId() == user.getId()) {
					model.addAttribute("checkSameUser", checkSameUser);
				}
			}
		}

		return "board/view";
	}

	/**
	 * 문의사항 수정 페이지 요청
	 * 
	 * @return
	 */
	@GetMapping("/update/{boardId}")
	public String updateBoardPage(Model model, @PathVariable(name = "boardId") Integer boardId) {
		Board board = boardService.viewBoard(boardId);
		model.addAttribute("board", board);
		return "board/update";
	}

	/**
	 * 문의사항 수정 로직 요청
	 * 
	 * @return
	 */
	@PostMapping("/update/{boardId}")
	public String updateBoardProc(UserBoardDTO userBoardDTO) {
		boardService.updateBoard(userBoardDTO.toBoard());
		return "redirect:/board/listPage";
	}

	/**
	 * 문의사항 삭제 로직 요청
	 * 
	 * @return
	 */
	@GetMapping("/delete/{boardId}")
	public String deleteBoardProc(@PathVariable(name = "boardId") Integer boardId) {
		boardService.deleteBoard(boardId);
		return "redirect:/board/listPage";
	}

}
