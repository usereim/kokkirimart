package com.bookshop01.notice.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.bookshop01.notice.vo.ArticleVO;
import com.bookshop01.notice.vo.ImageVO;



public interface ArticleDAO {
	public List selectAllArticlesList(Map pagingMap) throws DataAccessException;
	public int selectTotArticles() throws DataAccessException;
	
	public int insertNewArticle(Map articleMap) throws DataAccessException;
	public void insertNewImage(Map articleMap) throws DataAccessException;
	
	public int insertReplyArticle(Map articleMap) throws DataAccessException;
	
	public ArticleVO selectArticle(int notice_No) throws DataAccessException;
	public void updateArticle(Map articleMap) throws DataAccessException;
	public void updateImageFile(Map articleMap) throws DataAccessException;
	
	public void deleteArticle(int notice_No) throws DataAccessException;
	public List selectImageFileList(int notice_No) throws DataAccessException;
	
	public void deleteModImage(ImageVO imageVO) throws DataAccessException;
	
	public void insertModNewImage(Map articleMap) throws DataAccessException;

	public int selectNewGroupNO() throws DataAccessException;
	
	public void updateViewCounts(int notice_No) throws DataAccessException;
	
	
}
