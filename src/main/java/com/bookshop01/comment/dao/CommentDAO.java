package com.bookshop01.comment.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.bookshop01.comment.vo.CommentVO;

@Repository("commentDAO")
public class CommentDAO {
	@Autowired
	private SqlSession sqlSession;


	public List<CommentVO> selectComment(int articleNO) throws DataAccessException {
		List<CommentVO> commentList = sqlSession.selectList("mapper.comment.selectComment", articleNO);
		return commentList;
	}

	public int selectNewCommentNO() {
		int commentNO = sqlSession.selectOne("mapper.comment.selectNewCommentNO");
		return commentNO;
	}


	public void insertNewComment(Map<String, CommentVO> map) throws DataAccessException {
		sqlSession.insert("mapper.comment.insertNewComment", map);
	}
}
