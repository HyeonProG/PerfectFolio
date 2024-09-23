package com.tenco.perfectfolio.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.tenco.perfectfolio.repository.model.Notice;

@Mapper
public interface NoticeRepository {

	public Notice getNoticeById(int id);
	public int addNotice(Notice notice);
	public int updateNotice(Notice notice);
	public void deleteNotice(int id);
	public void incrementViewsCount(int id);
	
	public List<Notice> getAllNotice(@Param("limit") Integer limit, @Param("offset")Integer offset);
	public int getNoticeCount();
	
	public List<Notice> searchByCategories(@Param("keyword") String keyword, @Param("limit") Integer limit, @Param("offset")Integer offset);
	public Integer searchByCategoriesCount(@Param("keyword") String keyword);
	
	public List<Notice> searchByTitle(@Param("keyword") String keyword, @Param("limit") Integer limit, @Param("offset")Integer offset);
	public Integer searchByTitleCount(@Param("keyword") String keyword);
	
	public List<Notice> searchByTitleAndContent(@Param("keyword") String keyword, @Param("limit") Integer limit, @Param("offset")Integer offset);
	public Integer searchByTitleAndContentCount(@Param("keyword") String keyword);
	// 메인 출력 공지사항 리스트
	public List<Notice> getNoticeForMain();
	
}
