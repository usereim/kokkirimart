package com.bookshop01.comment.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookshop01.comment.service.CommentService;
import com.bookshop01.comment.vo.CommentVO;

@Controller("commentController")
public class CommentController{
	@Autowired
	private CommentService commentService;
	
	// 게시글 상세 페이지 접근시 해당 게시글의 댓글 데이터 응답
	@RequestMapping(value = "/comment/listComment.do", produces = "application/text; charset=utf8", method = RequestMethod.POST)
	@ResponseBody
	public String listComment(@RequestParam("articleNO") int articleNO , HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		//json형식 문자열 리턴
		String commentList = commentService.commentList(articleNO);
		return commentList;
	}

	// 댓글 작성시 댓글 정보 테이블에 저장 후 갱신된 댓글 정보 데이터 응답
	@RequestMapping(value = "/comment/addComment.do", produces = "application/text; charset=utf8", method = RequestMethod.POST)
	@ResponseBody
	public String addComment(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		CommentVO commentVO = new CommentVO();
		//ajax 요청으로 넘어온 json객체 파싱하여 VO에 저장
		String jsonInfo = request.getParameter("jsonInfo");
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonInfo);
		String content = (String)jsonObject.get("content");
		int articleNO = Integer.parseInt((String)jsonObject.get("articleNO"));
		String id = (String)jsonObject.get("id");
		
		commentVO.setContent(content);
		commentVO.setArticleNO(articleNO);
		commentVO.setId(id);
		// 댓글 저장
		commentService.addComment(commentVO);
		//json형식 문자열 리턴
		String commentList = commentService.commentList(articleNO);
		return commentList;
	}
}