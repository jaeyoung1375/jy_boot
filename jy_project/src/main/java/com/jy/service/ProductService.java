package com.jy.service;

import java.util.List;

import com.jy.model.ProductDTO;

public interface ProductService {
	
	// 상품목록
	public List<ProductDTO> selectList();
	
	// 상품등록
	public void enroll(ProductDTO dto);

}
