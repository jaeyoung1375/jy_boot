package com.jy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jy.mapper.AdminMapper;
import com.jy.model.MemberVO;
import com.jy.model.PaginationVO;
import com.jy.model.ProductDTO;

@Service
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	private AdminMapper adminMapper;
	
	/* 회원 목록 */
	public List<MemberVO> MemberList(PaginationVO vo){
		
		List<MemberVO> list = adminMapper.MemberList(vo);
		
		return list;
	}

	@Override
	public MemberVO selectOne(String memberId) {
		
		return adminMapper.selectOne(memberId);
	}

	@Override
	public int memberUpdate(MemberVO member) {
		
		return adminMapper.memberUpdate(member);
	}

	@Override
	public int count() {
		
		return adminMapper.count();
	}

	@Override
	public List<ProductDTO> productList() {
		
		return adminMapper.productList();
	}

	@Override
	public ProductDTO productSelectOne(int productNo) {
		return adminMapper.productSelectOne(productNo);
	}

	@Override
	public void productEnroll(ProductDTO dto) {
		adminMapper.productEnroll(dto);
	}

}
