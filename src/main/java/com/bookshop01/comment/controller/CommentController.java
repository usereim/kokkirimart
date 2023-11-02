package com.bookshop01.comment.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookshop01.comment.service.CommentService;
import com.bookshop01.comment.vo.CommentVO;

@Controller("commentController")
public class CommentController {
	@Autowired
	private CommentService commentService;

	// �Խñ� �� ������ ���ٽ� �ش� �Խñ��� ��� ������ ����
	@RequestMapping(value = "/comment/listComment.do", produces = "application/text; charset=utf8", method = RequestMethod.POST)
	@ResponseBody
	public String listComment(@RequestParam("notice_no") int articleNO, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// json���� ���ڿ� ����
		System.out.println("게시글 번호" + articleNO);
		String commentList = commentService.commentList(articleNO);
		return commentList;
	}

	// 11/02 json으로 댓글 내용 받던거 RequestParam으로 받는 걸로 변경
	@RequestMapping(value = "/comment/addComment.do", produces = "application/text; charset=utf8", method = RequestMethod.POST)
	@ResponseBody
	public String addComment(@RequestParam("ac_content") String ac_content, @RequestParam("userId") String userId,
			@RequestParam("notice_no") int articleNO, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		CommentVO commentVO = new CommentVO();
		// ajax ��û���� �Ѿ�� json��ü �Ľ��Ͽ� VO�� ����
//		String jsonInfo = request.getParameter("jsonInfo");
//		JSONParser jsonParser = new JSONParser();
//		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonInfo);
//		String content = (String) jsonObject.get("content");
//		int articleNO = Integer.parseInt((String) jsonObject.get("articleNO"));
//		String id = (String) jsonObject.get("id");

		commentVO.setReply_Content(ac_content);
		commentVO.setNotice_No(articleNO);
		commentVO.setMember_Id(userId);
		commentVO.setParent_No(0);
		// ��� ����
		commentService.addComment(commentVO);
		// json���� ���ڿ� ����
		String commentList = commentService.commentList(articleNO);
		return commentList;
	}
	
		// 11/02 대댓글 등록 메서드
		@RequestMapping(value = "/comment/addCocomment.do", produces = "application/text; charset=utf8", method = RequestMethod.POST)
		@ResponseBody
		public String addCocomment(@RequestParam("ac_parentNO") int parent_No, @RequestParam("ac_content") String ac_content, @RequestParam("userId") String userId,
				@RequestParam("notice_no") int articleNO, HttpServletRequest request, HttpServletResponse response)
				throws Exception {
			CommentVO commentVO = new CommentVO();
			

			commentVO.setReply_Content(ac_content);
			commentVO.setNotice_No(articleNO);
			commentVO.setMember_Id(userId);
			commentVO.setParent_No(parent_No);

			commentService.addComment(commentVO);

			String commentList = commentService.commentList(articleNO);
			return commentList;
		}
}