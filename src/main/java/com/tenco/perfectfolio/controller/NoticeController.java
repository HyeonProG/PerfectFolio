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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tenco.perfectfolio.handler.exception.DataDeliveryException;
import com.tenco.perfectfolio.repository.model.Notice;
import com.tenco.perfectfolio.repository.model.admin.Admin;
import com.tenco.perfectfolio.service.NoticeService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;



@Controller
@RequestMapping("/notice")
@RequiredArgsConstructor
public class NoticeController {

	@Autowired
	private final NoticeService noticeService;
	@Autowired
	private final HttpSession session;
	
	/**
	 * 공지사항 전체 조회 화면
	 * @return
	 */
	@GetMapping("/listPage")
	public String listPage() {
		return "notice/noticeList";
	}
	
	/**
	 * 공지사항 전체 조회 및 검색 기능(페이징 처리 포함)
	 * @param dto
	 * @return
	 */
	@GetMapping("/list")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getAllNotice(
	        @RequestParam(name = "searchType", defaultValue = "", required = false) String searchType, 
	        @RequestParam(name = "keyword", defaultValue = "", required = false) String keyword, 
	        @RequestParam(name = "page", defaultValue = "1") Integer page, 
	        @RequestParam(name = "size", defaultValue = "10") Integer size) {
	    try {
	        List<Notice> noticeList;
	        int totalCount;

	        if (searchType != null && !searchType.isEmpty() && keyword != null && !keyword.isEmpty()) {
	            // 검색 조건이 있을 경우
	            noticeList = noticeService.searchNotice(searchType, keyword, page, size);
	            totalCount = noticeService.getSearchCount(searchType, keyword);
	        } else {
	            // 검색 조건이 없을 경우
	            noticeList = noticeService.getAllNotice(page, size);
	            totalCount = noticeService.getNoticeCount();
	        }

	        int totalPages = (int) Math.ceil((double) totalCount / size);

	        Map<String, Object> response = new HashMap<>();
	        response.put("totalCount", totalCount);
	        response.put("noticeList", noticeList);
	        response.put("totalPages", totalPages);
	        response.put("currentPage", page);
	        response.put("pageSize", size);

	        Admin admin = (Admin) session.getAttribute("admin");
	        if (admin != null) {
	            response.put("admin", admin);
	        }

	        return ResponseEntity.ok(response);
	    } catch (Exception e) {
	        e.printStackTrace(); // 로그에 오류 출력
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	    }
	}


	
	/**
	 * 공지사항 추가 화면
	 * @return
	 */
	@GetMapping("/create")
	public String addNoticePage() {
		return "notice/createNotice"; 
	}
	
	
	/**
	 * 공지사항 추가 기능
	 * @param request
	 * @return
	 */
	@PostMapping("/create")
	public String addNoticeProc(Notice dto) {
		
		if(dto.getCategories() == null) {
			throw new DataDeliveryException("카테고리를 선택해주세요.", HttpStatus.BAD_REQUEST);
		}
		if(dto.getTitle() == null || dto.getTitle().trim().isEmpty()) {
			throw new DataDeliveryException("제목을 입력해주세요.", HttpStatus.BAD_REQUEST);
		}
		if(dto.getContent() == null || dto.getContent().trim().isEmpty()) {
			throw new DataDeliveryException("내용을 입력해주세요.", HttpStatus.BAD_REQUEST);
		}
		
		noticeService.addNotice(dto);
		
		return "redirect:/notice/listPage";
		
		
	}
	
	/**
	 * 공지사항 수정 화면
	 * @return
	 */
	@GetMapping("/update")
	public String updateNoticePage(@RequestParam(name = "id") Integer id, Model model) {
		
		// id를 통해 상세정보 보기
		Notice notice = noticeService.getDetailNotice(id);
		model.addAttribute("notice", notice);
		return "notice/updateNotice"; 
	}
	
	/**
	 * 공지사항 수정 기능
	 * @return
	 */
	@PostMapping("/update")
	public String updateNoticeProc(Notice dto, @RequestParam(name = "id") Integer id) {
		
		if(dto.getTitle() == null || dto.getTitle().trim().isEmpty()) {
			throw new DataDeliveryException("제목을 입력해주세요.", HttpStatus.BAD_REQUEST);
		}
		if(dto.getContent() == null || dto.getContent().trim().isEmpty()) {
			throw new DataDeliveryException("내용을 입력해주세요.", HttpStatus.BAD_REQUEST);
		}
		
		noticeService.updateNotice(dto);
		return "redirect:/notice/detail?id="+ id;
	}
	
	@GetMapping("/delete")
	public String deleteNoticeProc(@RequestParam(name = "id") Integer id) {
		noticeService.deleteNotice(id);
		return "redirect:/notice/listPage";
	}
	
	/**
	 * 공지사항 상세보기 화면
	 * @return
	 */
	@GetMapping("/detail")
	public String detailNoticePage(@RequestParam(name = "id") Integer id, Model model) {
		String sessionKey = "viewedNotice_" + id;
		Notice dto = noticeService.getDetailNotice(id);

        // 세션에 조회 기록이 없는 경우에만 조회수 증가
        if (session.getAttribute(sessionKey) == null) {
            noticeService.incrementViewsCount(id);
            session.setAttribute(sessionKey, true);  // 조회 기록을 세션에 저장
        }
		
		System.out.println("상세값 받아오기 : " + dto);
		model.addAttribute("notice",dto);
		return "notice/detailNotice";
	}
	
}
