package com.jy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jy.model.cateVO;
import com.jy.model.AttachImageVO;
import com.jy.model.MemberVO;
import com.jy.model.PaginationVO;
import com.jy.model.ProductDTO;
import com.jy.model.ProductImageDto;
@Mapper
public interface AdminMapper {
	
	/* 회원 목록 */
	public List<MemberVO> MemberList(PaginationVO vo);
	
	/* 회원 상세 페이지 */
	public MemberVO selectOne(String memberId);
	
	/* 회원 수정 */
	public int memberUpdate(MemberVO member);
	
	/* 전체 회원 개수 */
	public int count();
	
	/* 상품 목록 */
	public List<ProductDTO> productList();
	
	/* 상품 상세 */
	public ProductDTO productSelectOne(int productNo);
	
	/* 상품 등록 */
	public void productEnroll(ProductDTO dto);
	
	// 카테고리 리스트
	public List<cateVO> cateList();
	
	/* 상품 수정 */
	public int productUpdate(ProductDTO dto);
	
	/* 상품 삭제 */
	public int productDelete(int productNo);
	
	/* 시퀀스 구하기 */
	public int sequence();
	
	/* 이미지 등록 */
	public void imageEnroll(AttachImageVO vo);
	
	

}
