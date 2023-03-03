package com.jy.mapper;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class AttachMapperTests {
	
	@Autowired
	private AttachMapper mapper;
	
	@Test
	public void AttachTest() {
		
		int productNo = 263;
		System.out.println("이미지 정보 : "+mapper.getAttachList(productNo));
	}

}
