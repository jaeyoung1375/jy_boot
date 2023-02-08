package com.jy.service;

import java.util.List;

import com.jy.model.BoardVO;

public interface BoardService {
	
	// 게시판 등록
	public void enroll(BoardVO board);
	
	// 게시판 목록
	public List<BoardVO> boardList();
	

}
