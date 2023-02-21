package com.jy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jy.model.ProductDTO;
@Mapper
public interface ProductMapper {
	
	// 상품 목록
	public List<ProductDTO> selectList();
	
	// 상품 등록
	public void enorll(ProductDTO dto);

}
