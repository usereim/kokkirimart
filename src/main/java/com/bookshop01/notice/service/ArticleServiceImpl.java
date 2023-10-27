package com.bookshop01.notice.service;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.bookshop01.notice.dao.ArticleDAO;
import com.bookshop01.notice.vo.ArticleVO;
import com.bookshop01.notice.vo.ImageVO;




@Service("articleService")
@Transactional(propagation = Propagation.REQUIRED)
public class ArticleServiceImpl  implements ArticleService{
	@Autowired
	private ArticleDAO articleDAO;

    @Autowired
    private HttpSession session;
    @Autowired
    private SqlSession sqlSession;
    
    private Map<String, Set<Integer>> viewedArticlesMap = new HashMap<String, Set<Integer>>();
	
	public Map listArticles(Map  pagingMap) throws Exception{
		Map articlesMap = new HashMap();
		List<ArticleVO> articlesList = articleDAO.selectAllArticlesList(pagingMap);
		int totArticles = articleDAO.selectTotArticles();
		articlesMap.put("articlesList", articlesList);
		articlesMap.put("totArticles", totArticles);
		//articlesMap.put("totArticles", 170);
		return articlesMap;
		
	}


	@Override
	public int addNewArticle(Map articleMap) throws Exception{
		int notice_No = articleDAO.insertNewArticle(articleMap);
		articleMap.put("notice_No", notice_No);
		
		articleDAO.insertNewImage(articleMap);
		return notice_No;
	}
	
		@Override
		public int addReplyArticle(Map articleMap) throws Exception{
			int articleNO = articleDAO.insertReplyArticle(articleMap);
			articleMap.put("articleNO", articleNO);
			articleDAO.insertNewImage(articleMap);
			return articleNO;
		}

	@Override
//	public Map viewArticle(int articleNO) throws Exception {
    public Map viewArticle(Map viewMap) throws Exception {
        Map articleMap = new HashMap();
        
        int notice_No = (Integer)viewMap.get("notice_No");
        String id = (String) viewMap.get("id");
        
        ArticleVO articleVO = articleDAO.selectArticle(notice_No); 

        //조회수 증가 기능
        getArticleAndIncreaseCount(notice_No);
        
       List<ImageVO> imageFileList = articleDAO.selectImageFileList(notice_No);
       articleMap.put("article", articleVO);
       articleMap.put("imageFileList", imageFileList);

    // List<CommentVO> commentsList = commentDAO.selectAllCommentsList(notice_No);
    // 	articleMap.put("commentsList", commentsList);

       return articleMap;
    }
	
	
	
	@Override
	public void modArticle(Map articleMap) throws Exception {
		articleDAO.updateArticle(articleMap);
		
		List<ImageVO> imageFileList = (List<ImageVO>)articleMap.get("imageFileList");
		List<ImageVO> modAddimageFileList = (List<ImageVO>)articleMap.get("modAddimageFileList");

		if(imageFileList != null && imageFileList.size() != 0) {
			int added_img_num = Integer.parseInt((String)articleMap.get("added_img_num"));
			int pre_img_num = Integer.parseInt((String)articleMap.get("pre_img_num"));

			if(pre_img_num < added_img_num) {  
				articleDAO.updateImageFile(articleMap);     
				articleDAO.insertModNewImage(articleMap);
			}else {
				articleDAO.updateImageFile(articleMap);  
			}
		}else if(modAddimageFileList != null && modAddimageFileList.size() != 0) {  
			articleDAO.insertModNewImage(articleMap);
		}
	}
	
	@Override
	public void removeArticle(int notice_No) throws Exception {
		articleDAO.deleteArticle(notice_No);
	}


	@Override
	public void removeModImage(ImageVO imageVO) throws Exception {
		articleDAO.deleteModImage(imageVO);
	}
	
	//10-23 추가. 조회수 증가 기능.
	public Map getArticleAndIncreaseCount(int notice_No) throws Exception {
		Map articleMap = new HashMap();
		// 게시글 정보 가져오기
		articleMap.put("article", articleDAO.selectArticle(notice_No));

		// 조회수 증가 처리
		Object obj = session.getAttribute("viewedArticles");
		Set<Integer> viewedArticles;
		if (obj != null && obj instanceof Set) {
		    viewedArticles = (Set<Integer>) obj;
		} else {
		    // 처음으로 게시글을 조회하는 경우, HashSet을 새로 만듬.
		    viewedArticles = new HashSet<Integer>();
		}

    //처음으로 읽는 글이 맞을때
		if (!viewedArticles.contains(notice_No)) {

		    System.out.println("세션에서 처음 조회하는 게시글입니다.");

		    // 현재 보고 있는 글의 번호를 HashSet에 추가.
		    viewedArticles.add(notice_No);

		    // HashSet 값을 session에 저장함
		    session.setAttribute("viewedArticles", viewedArticles);

       // 조회수를 증가시키는 SQL 동작.
		   int updatedCount = sqlSession.update("mapper.article.updateViewCounts", notice_No);

		   if (updatedCount > 0) {
		        System.out.println("게시글 번호 : " + notice_No + "의 조회수가 증가되었습니다.");
		   } else {
						// SQL이 제대로 동작하지 않은 경우 아래 내용을 출력함.
		        System.out.println("게시글 번호 : " + notice_No + "의 조회수 업데이트에 실패하였습니다.");
		   }
		} else {
		   // 이미 읽은 게시글일 때
		   System.out.println("이미 존재하는 게시글 번호입니다.");
		   System.out.println("조회수는 증가하지 않습니다.");
		}
		return articleMap;
	
	}
}