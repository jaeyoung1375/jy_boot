package com.jy.mapper;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.jy.model.AttachImageVO;
import com.jy.model.ProductDTO;

@SpringBootTest
public class ImageMapperTests {
	
	@Autowired
	private AdminMapper adminMapper;
	
//	@Test
//	public void imageEnrollTest() {
//		
//		AttachImageVO vo = new AttachImageVO();
//		
//		vo.setProductNo(122);
//		vo.setFileName("test");
//		vo.setUploadPath("test");
//		vo.setUuid("test2");
//		
//		adminMapper.imageEnroll(vo);
//		
//	}
	
	@Test
	public void productEnrollTest() {
		
		ProductDTO dto = new ProductDTO();
//		dto.setProductNo(523);
		dto.setProductName("name test");
		dto.setProductPrice(5);
		dto.setProductStock(12);
		dto.setProductDescription("des test");
		dto.setProductCateCode("201");
		dto.setProductDiscount(5);
		
		System.out.println("before : " +dto);
		adminMapper.productEnroll(dto);
		System.out.println("after : " +dto);
		
	}

}
