package com.jy.model;

import java.util.List;

import lombok.Data;

@Data
public class ProductDTO {
	
	private int productNo;
	private String productName;
	private int productPrice;
	private double productDiscount;
	private int productStock;
	private String productDescription;
	private String productCateCode;
	private List<AttachImageVO> imageList;
	
}
