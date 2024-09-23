package com.tenco.perfectfolio.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tenco.perfectfolio.controller.UserController;
import com.tenco.perfectfolio.handler.exception.DataDeliveryException;
import com.tenco.perfectfolio.repository.interfaces.NoticeRepository;
import com.tenco.perfectfolio.repository.model.Notice;
import com.tenco.perfectfolio.utils.Define;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeService {
	
	@Autowired
	private final NoticeRepository noticeRepository;

	// TODO - 예외 처리 확인
	
	// 공지사항 추가
	@Transactional
	public void addNotice(Notice dto) {
		int result = 0;
		result = noticeRepository.addNotice(dto);
		if(result == 0) {
			throw new DataDeliveryException(Define.PROCESS_FAIL, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	// 공지사항 수정
	@Transactional
	public int updateNotice(Notice dto) {
		int result = 0;
		result = noticeRepository.updateNotice(dto);
		System.out.println("수정:" + result);
		
		if(result == 0) {
			throw new DataDeliveryException(Define.PROCESS_FAIL, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return result;
	}
	
	// 공지사항 삭제
	@Transactional
	public void deleteNotice(int id) {
		noticeRepository.deleteNotice(id);
	}
	
	// 공지사항 상세보기
	public Notice getDetailNotice(int id) {
		return noticeRepository.getNoticeById(id);
	}

	
	// 전체 공지사항 조회 및 페이징 처리
	public List<Notice> getAllNotice(int page, int size){
		List<Notice> list = new ArrayList<>();
		int limit = size;
		int offset = (page - 1) * size;
		list = noticeRepository.getAllNotice(limit, offset);
		return list;
	}
	
	// 게시글 수
	public int getNoticeCount() {
		return noticeRepository.getNoticeCount();
	}
	
	// 조회수 상승
	@Transactional
	public void incrementViewsCount(int id) {
		noticeRepository.incrementViewsCount(id);
	}
	
	// 공지사항 검색 및 페이징 처리
	public List<Notice> searchNotice(String searchType, String keyword, int page, int size) {
		int limit = size;
		int offset = (page - 1) * size;
		
		List<Notice> noticeList = null;
		switch (searchType) {
		case "categories":
			noticeList = noticeRepository.searchByCategories("%" + keyword + "%", limit, offset);
			break;
		case "title":
			noticeList = noticeRepository.searchByTitle("%" + keyword + "%", limit, offset);
			break;
		case "titleAndContent":
			noticeList = noticeRepository.searchByTitleAndContent("%" + keyword + "%", limit, offset);
			break;
		default:
			throw new IllegalArgumentException("Invalid search type: " + searchType);
		}
		return noticeList;
	}
	
	// 검색 결과 수 반환
	public int getSearchCount(String searchType, String keyword) {
		int count = 0;
		
		switch (searchType) {
		case "categories":
			count = noticeRepository.searchByCategoriesCount("%" + keyword + "%");
			break;
		case "title":
			count = noticeRepository.searchByTitleCount("%" + keyword + "%");
			break;
		case "titleAndContent":
			count = noticeRepository.searchByTitleAndContentCount("%" + keyword + "%");
			break;
		default:
			throw new IllegalArgumentException("Invalid search type: " + searchType);
		}
		return count;
	}

	/**
	 * 메인 출력용 공지사항 리스트
	 * @return
	 */
	public List<Notice> getNoticeForMain() {
		List<Notice> list = new ArrayList<>();
		list = noticeRepository.getNoticeForMain();
		return list;
	}
	

}
