package com.bookshop01.member.service;

import java.util.HashMap;
import java.util.Map;

import com.bookshop01.member.DTO.KakaoDTO;
import com.bookshop01.member.vo.MemberVO;

public interface MemberService {
	public MemberVO login(Map  loginMap) throws Exception;
	public void addMember(MemberVO memberVO) throws Exception;
	public String overlapped(String id) throws Exception;
	public String getAccessToken(String authorize_code);
	public KakaoDTO getUserInfo(String access_Token);
}