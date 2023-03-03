package com.jy.model;

import lombok.Data;

@Data
public class PaginationVO {
	
	private int page = 1;
	private int size = 10;
	private int count;
	private int blockSize = 10;
	
	public int getBegin() {
		return page * size - (size-1); 
	}
	
	public int getEnd() {
		return (int)Math.min(page*size,count); 
	}
	
	public int getTotalPage() {
		return (count + size -1) / size;
	}
	
	public int getStartBlock() {
		return (page - 1) / blockSize * blockSize + 1; // 1
	}
	
	public int getFinishBlock() {
		int value = (page -1) /blockSize * blockSize + blockSize; // 10
		return Math.min(value,getTotalPage());
	}
	
	public boolean isFirst() {
		return page == 1; 
	}
	
	public boolean isLast() {
		return page == getTotalPage();
	}
	
	public boolean isPrev() {
		return getStartBlock() > 1;
	}
	
	public boolean isNext() {
		return getFinishBlock() < getTotalPage();
	}
	
	public int getPrevPage() {
		return getStartBlock() - 1;
	}
	
	public int getNextPage() {
		return getFinishBlock() + 1;
	}
	
	
	
	
	
	

}
