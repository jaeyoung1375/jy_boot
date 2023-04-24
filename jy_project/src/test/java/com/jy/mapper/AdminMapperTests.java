package com.jy.mapper;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class AdminMapperTests {
	
	@Autowired
	private AdminMapper mapper;
	
	@Test
	public void deleteImageAllTests() {
		
		int productNo = 261;
		mapper.deleteImageAll(productNo);
	}

}
