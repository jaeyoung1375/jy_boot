package com.jy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jy.mapper.AdminMapper;
import com.jy.model.cateVO;
import com.jy.model.AttachImageVO;
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

	@Transactional
	@Override
	public void productEnroll(ProductDTO dto) {
		adminMapper.productEnroll(dto);
		// 이미지를 첨부하지 않는 경우 return
		if(dto.getImageList() == null || dto.getImageList().size() <= 0) {
			return;
		}
		// List의 각 요소를 하나씩 넘겨주기 위함
		for(AttachImageVO attach : dto.getImageList()) {
			attach.setProductNo(dto.getProductNo());
			adminMapper.imageEnroll(attach);
		}
	}

	@Override
	public List<cateVO> cateList() {
		
		return adminMapper.cateList();
	}
	@Transactional
	@Override
	public int productUpdate(ProductDTO dto) {
		
		int result = adminMapper.productUpdate(dto);
		
		if(result == 1 && dto.getImageList() != null && dto.getImageList().size() > 0) { // 수정 성공
			adminMapper.deleteImageAll(dto.getProductNo());
			
			dto.getImageList().forEach(attach -> {
				
				attach.setProductNo(dto.getProductNo());
				adminMapper.imageEnroll(attach);
			});
		}
		
		return result;
	}

	@Override
	public int sequence() {
		
		return adminMapper.sequence();
	}

	@Override
	public int productDelete(int productNo) {
		
		return adminMapper.productDelete(productNo);
	}

}
