package com.bookshop01.comment.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.bookshop01.comment.dao.CommentDAO;
import com.bookshop01.comment.vo.CommentVO;

@Service("commentService")
@Transactional(propagation = Propagation.REQUIRED)
public class CommentService {

	@Autowired
	CommentDAO commentDAO;

	//댓글 목록
	public String commentList(int articleNO) throws Exception {

		List<CommentVO> commentList = commentDAO.selectComment(articleNO);
		//JSON 타입으로 댓글 내용을 전달함
		JSONObject commentObject = null;
		JSONArray commentArray = new JSONArray();
		JSONObject totalComment = new JSONObject();
		for (CommentVO vo : commentList) {
			commentObject = new JSONObject();
			commentObject.put("reply_No", vo.getReply_No());
			commentObject.put("reply_Content", vo.getReply_Content());
			commentObject.put("member_Id", vo.getMember_Id());
			commentObject.put("parent_No", vo.getParent_No());
			commentArray.add(commentObject);
		}
		
		totalComment.put("comment", commentArray);
		
		String jsonInfo = totalComment.toJSONString();
		return jsonInfo;
	}

	//댓글 추가
	public void addComment(CommentVO commentVO) throws Exception {
		int commentNO = commentDAO.selectNewCommentNO();
		commentVO.setReply_No(commentNO);
		Map<String, CommentVO> map = new HashMap<String, CommentVO>();
		map.put("comment", commentVO);
		commentDAO.insertNewComment(map);
	}

	
}
