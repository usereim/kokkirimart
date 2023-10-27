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
		// �Խñ� ��ȣ�� �̿��Ͽ� �Խñ��� ��� ��ȸ
		List<CommentVO> commentList = commentDAO.selectComment(articleNO);
		// ��ȸ�� �����͸� json������ ���ڿ��� ����� ����
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
		//�Ű������� ���� VO�� �� ��� ��ȣ�� ������ ����
		commentVO.setCommentNO(commentNO);
		Map<String, CommentVO> map = new HashMap<String, CommentVO>();
		map.put("comment", commentVO);
		commentDAO.insertNewComment(map);
	}

	
}