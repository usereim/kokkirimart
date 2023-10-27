package com.bookshop01.member.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.bookshop01.member.DTO.KakaoDTO;
import com.bookshop01.member.vo.MemberVO;

@Repository("memberDAO")
public class MemberDAOImpl implements MemberDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public MemberVO login(Map loginMap) throws DataAccessException {
		MemberVO member = (MemberVO) sqlSession.selectOne("mapper.member.login", loginMap);
		return member;
	}

	@Override
	public void insertNewMember(MemberVO memberVO) throws DataAccessException {
		sqlSession.insert("mapper.member.insertNewMember", memberVO);
	}

	@Override
	public String selectOverlappedID(String id) throws DataAccessException {
		String result = sqlSession.selectOne("mapper.member.selectOverlappedID", id);
		return result;
	}

	// ���� ����
	@Override
	public void kakaoinsert(HashMap<String, Object> userInfo) {
		sqlSession.insert("mapper.member.kakaoInsert", userInfo);
	}

	// ���� Ȯ��
	@Override
	public KakaoDTO findkakao(HashMap<String, Object> userInfo) {
		System.out.println("RN:" + userInfo.get("nickname"));
		System.out.println("RE:" + userInfo.get("email"));
		return sqlSession.selectOne("mapper.member.findKakao", userInfo);
	}

}