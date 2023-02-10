package com.jy.model;

public class PageMakeDTO {
	
	// 시작 페이지
	private int beginPage;
	
	// 마지막 페이지
	private int endPage;
	
	// 이전 페이지, 다음 페이지 존재 유무
	private boolean prev,next;
	
	// 전체 게시물 개수
	private int totalPage;
	
	// 현재 페이지, 페이지당 게시물 표시수 정보
	private Criteria cri;
	
	public PageMakeDTO(Criteria cri, int totalPage) {
		
		this.cri = cri;
		this.totalPage = totalPage;
		
		// 마지막 페이지
				this.endPage = (int)(Math.ceil(cri.getPageNum()/10.0))*10;
		
		// 시작 페이지
		this.beginPage = this.endPage - 9;
		
		
		
		// 전체 마지막 페이지
		int realEnd = (int)(Math.ceil(totalPage *1.0)/cri.getAmount());
		
		// 전체 마지막 페이지가 화면에 보이는 마지막 페이지보다 작은 경우 보이는페이지를 전체 마지막 페이지로 변경
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		prev = beginPage!= 1;
		next = endPage < realEnd;
			
	}

	public int getBeginPage() {
		return beginPage;
	}

	public void setBeginPage(int beginPage) {
		this.beginPage = beginPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public Criteria getCri() {
		return cri;
	}

	public void setCri(Criteria cri) {
		this.cri = cri;
	}

	@Override
	public String toString() {
		return "PageMakeDTO [beginPage=" + beginPage + ", endPage=" + endPage + ", prev=" + prev + ", next=" + next
				+ ", totalPage=" + totalPage + ", cri=" + cri + "]";
	}
	
	
	

}
