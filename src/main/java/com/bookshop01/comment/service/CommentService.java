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


	public String commentList(int articleNO) throws Exception {
		// 게시글 번호를 이용하여 게시글의 댓글 조회
		List<CommentVO> commentList = commentDAO.selectComment(articleNO);
		// 조회한 데이터를 json형식의 문자열로 만들어 리턴
		JSONObject commentObject = null;
		JSONArray commentArray = new JSONArray();
		JSONObject totalComment = new JSONObject();
		for (CommentVO vo : commentList) {
			commentObject = new JSONObject();
			commentObject.put("commentNO", vo.getCommentNO());
			commentObject.put("content", vo.getContent());
			commentObject.put("id", vo.getId());

			commentArray.add(commentObject);
		}
		
		totalComment.put("comment", commentArray);
		
		String jsonInfo = totalComment.toJSONString();
		return jsonInfo;
	}


	public void addComment(CommentVO commentVO) throws Exception {
		int commentNO = commentDAO.selectNewCommentNO();
		//매개변수로 받은 VO에 새 댓글 번호를 가져와 설정
		commentVO.setCommentNO(commentNO);
		Map<String, CommentVO> map = new HashMap<String, CommentVO>();
		map.put("comment", commentVO);
		commentDAO.insertNewComment(map);
	}

	
}
