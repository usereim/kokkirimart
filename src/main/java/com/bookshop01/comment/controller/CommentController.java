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
	
	// �Խñ� �� ������ ���ٽ� �ش� �Խñ��� ��� ������ ����
	@RequestMapping(value = "/comment/listComment.do", produces = "application/text; charset=utf8", method = RequestMethod.POST)
	@ResponseBody
	public String listComment(@RequestParam("notice_no") int articleNO , HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		//json���� ���ڿ� ����
		System.out.println("게시글 번호" + articleNO);
		String commentList = commentService.commentList(articleNO);
		return commentList;
	}

	// 변수 이름 변겅 해야됨
	@RequestMapping(value = "/comment/addComment.do", produces = "application/text; charset=utf8", method = RequestMethod.POST)
	@ResponseBody
	public String addComment(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		CommentVO commentVO = new CommentVO();
		//ajax ��û���� �Ѿ�� json��ü �Ľ��Ͽ� VO�� ����
		String jsonInfo = request.getParameter("jsonInfo");
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonInfo);
		String content = (String)jsonObject.get("content");
		int articleNO = Integer.parseInt((String)jsonObject.get("articleNO"));
		String id = (String)jsonObject.get("id");
		
		commentVO.setReply_Content(content);
		commentVO.setNotice_No(articleNO);
		commentVO.setMember_Id(id);
		// ��� ����
		commentService.addComment(commentVO);
		//json���� ���ڿ� ����
		String commentList = commentService.commentList(articleNO);
		return commentList;
	}
}