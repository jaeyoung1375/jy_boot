package com.jy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jy.model.MemberVO;
import com.jy.model.PaginationVO;
import com.jy.model.ProductDTO;
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
	

}
