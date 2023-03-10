package com.jy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jy.model.BoardVO;
import com.jy.model.Criteria;
@Mapper
public interface BoardMapper {
	
	// 게시판 등록
	public void enroll(BoardVO board);
	
	// 게시판 목록
	public List<BoardVO> boardList();
	
	// 게시판 목록(페이징 적용)
	public List<BoardVO> getListPaging(Criteria cri);
	
	// 게시판 상세 조회
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
