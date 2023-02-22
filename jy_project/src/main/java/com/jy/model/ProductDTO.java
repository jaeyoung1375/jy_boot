package com.jy.model;

import lombok.Data;

@Data
public class ProductDTO {
	
	private int productNo;
	private String productName;
	private int productPrice;
	private int productStock;
	private String productDescription;
	private String productCateCode;
	
}
