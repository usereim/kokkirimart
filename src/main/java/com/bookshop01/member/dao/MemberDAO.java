package com.bookshop01.member.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.bookshop01.member.DTO.KakaoDTO;
import com.bookshop01.member.vo.MemberVO;

public interface MemberDAO {
	public MemberVO login(Map loginMap) throws DataAccessException;
	public void insertNewMember(MemberVO memberVO) throws DataAccessException;
	public String selectOverlappedID(String id) throws DataAccessException;
	public void kakaoinsert(HashMap<String, Object> userInfo) throws DataAccessException;
	public KakaoDTO findkakao(HashMap<String, Object> userInfo) throws DataAccessException;
}