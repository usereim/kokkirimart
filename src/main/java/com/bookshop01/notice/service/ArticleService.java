package com.bookshop01.notice.service;

import java.util.List;
import java.util.Map;

import com.bookshop01.notice.vo.ArticleVO;
import com.bookshop01.notice.vo.ImageVO;

public interface ArticleService {
	public Map listArticles(Map pagingMap) throws Exception;
	public int addNewArticle(Map articleMap) throws Exception;
	public int addReplyArticle(Map articleMap) throws Exception;
	public Map viewArticle(Map viewMap) throws Exception;
	public void modArticle(Map articleMap) throws Exception;
	public void removeArticle(int notice_No) throws Exception;
	
	public void removeModImage(ImageVO imageVO) throws Exception;
	
}
