package com.jy.service;

import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.jy.model.AttachImageVO;
import com.jy.model.ProductDTO;

@SpringBootTest
public class serviceTests {
	
	@Autowired
	private AdminService adminService;
	
	// 상품 등록 && 이미지 등록 테스트
	@Test
	public void productEnrollTest() {
		ProductDTO dto = new ProductDTO();
		
		dto.setProductName("name test");
		dto.setProductPrice(5);
		dto.setProductStock(12);
		dto.setProductDescription("des test");
		dto.setProductCateCode("201");
		dto.setProductDiscount(5);
		
		// 이미지 정보
		List<AttachImageVO> imageList = new ArrayList<AttachImageVO>();
		
		AttachImageVO image1 = new AttachImageVO();
		AttachImageVO image2 = new AttachImageVO();
		
		image1.setFileName("test Image1");
		image1.setUploadPath("test image1");
		image1.setUuid("test 111");
		
		image2.setFileName("test Imagasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasase2");
		image2.setUploadPath("test image2");
		image2.setUuid("test 221");
		
		imageList.add(image1);
		imageList.add(image2);
		
		dto.setImageList(imageList);
		
		adminService.productEnroll(dto);
		
		System.out.println("등록된 VO : "+dto);
	}

}
