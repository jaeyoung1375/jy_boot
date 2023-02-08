package com.jy.service;

import com.jy.model.MemberVO;

public interface MemberService {
	
	// 회원가입
	public void memberJoin(MemberVO member);
	
	// 아이디 중복확인
	public int memberIdChk(String memberId);
	
	// 닉네임 중복확인
	public int memberNickNameChk(String memberNickName);
	
	// 로그인
	public MemberVO memberLogin(MemberVO member);
	
<<<<<<< HEAD
	// 아이디 찾기
	public MemberVO memberIdSearch(MemberVO member);
=======
	// 상세 조회
	public MemberVO selectOne(String memberId);
>>>>>>> branch 'master' of https://github.com/jaeyoung1375/jy_boot.git

}
