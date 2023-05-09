package com.jy.service;

import java.net.URISyntaxException;

import com.jy.model.FacebookProfile;
import com.jy.model.FacekbookResponse;
import com.jy.model.KakaoProfile;
import com.jy.model.MemberVO;
import com.jy.model.OAuthToken;

public interface MemberService {
	
	// 회원가입
	public void memberJoin(MemberVO member);
	
	// 아이디 중복확인
	public int memberIdChk(String memberId);
	
	// 닉네임 중복확인
	public int memberNickNameChk(String memberNickName);
	
	// 로그인
	public MemberVO memberLogin(MemberVO member);
	
	// 아이디 찾기
	public MemberVO memberIdSearch(MemberVO member);
	// 상세 조회
	public MemberVO selectOne(String memberId);
	
	// 카카오 토큰 조회
	public OAuthToken tokenSearch(String code) throws URISyntaxException;
	
	// 카카오 로그인
	public KakaoProfile kakaoLogin(String code, OAuthToken oAuthToken) throws URISyntaxException;
	
	// 페이스북 토큰 조회
	public FacekbookResponse facebookTokenSearch(String code) throws URISyntaxException;
	
	// 페이스북 로그인
	public FacebookProfile facebookLogin(String code, FacekbookResponse response) throws URISyntaxException;

}
