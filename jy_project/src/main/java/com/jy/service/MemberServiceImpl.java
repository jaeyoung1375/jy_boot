package com.jy.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jy.mapper.MemberMapper;
import com.jy.model.MemberVO;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberMapper memberMapper;

	
	// 회원가입
	public void memberJoin(MemberVO member) {
		
		memberMapper.memberJoin(member);	
	}


	@Override
	public int memberIdChk(String memberId) {
		
		return memberMapper.memberIdChk(memberId);
	}


	@Override
	public int memberNickNameChk(String memberNickName) {
		
		return memberMapper.memberNickNameChk(memberNickName);
	}


	@Override
	public MemberVO memberLogin(MemberVO member) {
		
		return memberMapper.memberLogin(member);
	}


	@Override
<<<<<<< HEAD
	public MemberVO memberIdSearch(MemberVO member) {
		
		return memberMapper.memberIdSearch(member);
=======
	public MemberVO selectOne(String memberId) {
		
		return memberMapper.selectOne(memberId);
>>>>>>> branch 'master' of https://github.com/jaeyoung1375/jy_boot.git
	}

}
