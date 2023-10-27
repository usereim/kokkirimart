package com.bookshop01.notice.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.bookshop01.notice.vo.ArticleVO;
import com.bookshop01.notice.vo.ImageVO;



@Repository("articleDAO")
public class ArticleDAOImpl implements ArticleDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List selectAllArticlesList(Map pagingMap) throws DataAccessException {
		List<ArticleVO> articlesList  = sqlSession.selectList("mapper.article.selectAllArticlesList", pagingMap);
		return articlesList;
	}
	

	@Override
	public int selectTotArticles() throws DataAccessException {
		int totArticles = sqlSession.selectOne("mapper.article.selectTotArticles");
		return totArticles;
	}

	
	@Override
	public int insertNewArticle(Map articleMap) throws DataAccessException {
//		int groupNO  = selectNewGroupNO();
//		articleMap.put("groupNO", groupNO);
		int notice_No = selectNewArticleNO();
		articleMap.put("notice_No", notice_No);
		sqlSession.insert("mapper.article.insertNewArticle",articleMap);
		return notice_No;
	}
	
	@Override
	public int insertReplyArticle(Map articleMap) throws DataAccessException {
		int notice_No = selectNewArticleNO();
		articleMap.put("notice_No", notice_No);
		sqlSession.insert("mapper.article.insertReplyArticle",articleMap);
		return notice_No;
	}
	
    
	//다중 파일 업로드
	@Override
	public void insertNewImage(Map articleMap) throws DataAccessException {
		List<ImageVO> imageFileList = (ArrayList)articleMap.get("imageFileList");
		int notice_No = (Integer)articleMap.get("notice_No");
		int image_No = selectNewImageFileNO();
		
		if(imageFileList != null && imageFileList.size() != 0) {
			for(ImageVO imageVO : imageFileList){
				imageVO.setImage_No(++image_No);
				imageVO.setNotice_No(notice_No);
			}
			sqlSession.insert("mapper.article.insertNewImage",imageFileList);
		}
		
	}
	
	@Override
	public ArticleVO selectArticle(int notice_No) throws DataAccessException {
		return sqlSession.selectOne("mapper.article.selectArticle", notice_No);
	}

	@Override
	public void updateArticle(Map articleMap) throws DataAccessException {
		sqlSession.update("mapper.article.updateArticle", articleMap);
	}
	
	@Override
	public void updateImageFile(Map articleMap) throws DataAccessException {
		
		List<ImageVO> imageFileList = (ArrayList)articleMap.get("imageFileList");
		int notice_No = Integer.parseInt((String)articleMap.get("notice_No"));
		
		for(int i = imageFileList.size()-1; i >= 0; i--){
			ImageVO imageVO = imageFileList.get(i);
			String imageFileName = imageVO.getImage_Name();
			if(imageFileName == null) {  //기존에 이미지를 수정하지 않는 경우 파일명이 null 이므로  수정할 필요가 없다.
				imageFileList.remove(i);
			}else {
				imageVO.setNotice_No(notice_No);
			}
		}
		
		if(imageFileList != null && imageFileList.size() != 0) {
			sqlSession.update("mapper.article.updateImageFile", imageFileList);
		}
		
	}

	
	

	@Override
	public void deleteArticle(int notice_No) throws DataAccessException {
		sqlSession.delete("mapper.article.deleteArticle", notice_No);
		
	}
	
	@Override
	public List selectImageFileList(int notice_No) throws DataAccessException {
		List<ImageVO> imageFileList = null;
		imageFileList = sqlSession.selectList("mapper.article.selectImageFileList",notice_No);
		return imageFileList;
	}
	
	private int selectNewArticleNO() throws DataAccessException {
		return sqlSession.selectOne("mapper.article.selectNewArticleNO");
	}
	
	private int selectNewImageFileNO() throws DataAccessException {
		return sqlSession.selectOne("mapper.article.selectNewImageFileNO");
	}


	@Override
	public void deleteModImage(ImageVO imageVO) throws DataAccessException {
		sqlSession.delete("mapper.article.deleteModImage", imageVO );
		
	}


	@Override
	public void insertModNewImage(Map articleMap) throws DataAccessException {
		List<ImageVO> modAddimageFileList = (ArrayList<ImageVO>)articleMap.get("modAddimageFileList");
		int notice_No = Integer.parseInt((String)articleMap.get("notice_No"));
		
		int image_No = selectNewImageFileNO();
		
		for(ImageVO imageVO : modAddimageFileList){
			imageVO.setNotice_No(notice_No);
			imageVO.setImage_No(++image_No);
		}
		
//		sqlSession.delete("mapper.board.insertModNewImage", modAddimageFileList );
		sqlSession.insert("mapper.article.insertModNewImage", modAddimageFileList );
		
	}
	

	@Override
	public int selectNewGroupNO() throws DataAccessException {
			int maxGroupNO = sqlSession.selectOne("mapper.article.selectNewGroupNO");
			return maxGroupNO;
	}


	@Override
	public void updateViewCounts(int notice_No) throws DataAccessException {
		sqlSession.update("mapper.article.updateViewCounts", notice_No);
	}

		
}



