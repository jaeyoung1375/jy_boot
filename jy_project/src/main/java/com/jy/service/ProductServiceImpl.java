package com.jy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jy.mapper.ProductMapper;
import com.jy.model.ProductDTO;
@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductMapper productMapper;

	@Override
	public List<ProductDTO> selectList() {
		
		return productMapper.selectList();
	}

	@Override
	public void enroll(ProductDTO dto) {
		productMapper.enorll(dto);
	}

}
