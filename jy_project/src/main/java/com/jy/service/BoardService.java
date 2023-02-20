package com.jy.service;

import java.util.List;

import com.jy.model.BoardVO;
import com.jy.model.Criteria;

public interface BoardService {
	
	// 게시판 등록
	public void enroll(BoardVO board);
	
	// 게시판 목록
	public List<BoardVO> boardList();
	
	// 게시판 목록(페이징)
	public List<BoardVO> getListPaging(Criteria cri);
	
	// 게시판 상세조회
	public BoardVO selectOne(int bno);
	
	// 게시판 수정
	public int modify(BoardVO board);
	
	// 게시판 삭제
	public int delete(int bno);
	
	// 게시판 총 개수
	public int getTotal(Criteria cri);
	
	// 조회수 증가
	public int updateReadCount(int bno);
	

}
