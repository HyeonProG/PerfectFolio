package com.tenco.perfectfolio.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.tenco.perfectfolio.repository.model.Board;

@Mapper
public interface BoardRepository {

	public int insert(Board board);
	public int update(Board board);
	
	public List<Board> readAllBoardList(@Param("size") Integer size, @Param("offset")Integer offset);
	public int getBoardCounts();
	
	public List<Board> searchCategoryAndTitle(@Param("categories") String categories, @Param("searchContents") String searchContents, @Param("size") Integer size, @Param("offset")Integer offset);
	public List<Board> searchCategoryAndTitleAndContent(@Param ("categories") String categories,@Param("searchContents")String searchContents,@Param("size") Integer size, @Param("offset")Integer offset);
	public List<Board> searchOnlyTitle(@Param("searchContents")String searchContents,@Param("size") Integer size, @Param("offset")Integer offset);
	public List<Board> searchOnlyTitleAndContent(@Param("searchContents")String searchContents,@Param("size") Integer size, @Param("offset")Integer offset);
	
	public int countsCategoryAndTitle(@Param("categories")String categories, @Param("searchContents")String searchContents);
	public int countsCategoryAndTitleAndContent(@Param("categories")String categories, @Param("searchContents")String searchContents);
	public int countsOnlyCategory(String categories);
	public int countsOnlyTitle(String searchContents);
	public int countsOnlyTitleAndContent(String searchContents);
	
	public Board viewBoardById(Integer boardId);
	
	public int checkSameUser(Integer id);
	
	public int insertDeleteBoard(Board board);
	public void deleteBoard(Integer boardId);
	public int increaseViews(@Param(value = "views") Integer views,@Param(value = "boardId") Integer boardId);
	

	

}
