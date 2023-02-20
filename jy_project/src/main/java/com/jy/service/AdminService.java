package com.jy.service;

import java.util.List;

import com.jy.model.MemberVO;
import com.jy.model.PaginationVO;

public interface AdminService {
	
	/* 회원 목록 */
	public List<MemberVO> MemberList(PaginationVO vo);
	
	/* 회원 상세 페이지 */
	public MemberVO selectOne(String memberId);
	
	/* 회원 수정 */
	public int memberUpdate(MemberVO member);
	
	/* 전체 회원 개수 */
	public int count();

}
