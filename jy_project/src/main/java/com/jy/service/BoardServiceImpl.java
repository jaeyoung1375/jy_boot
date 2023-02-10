package com.jy.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jy.mapper.BoardMapper;
import com.jy.model.BoardVO;
import com.jy.model.Criteria;

import lombok.extern.log4j.Log4j2;
@Service
@Log4j2
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardMapper boardMapper;

	// 게시판 등록
	public void enroll(BoardVO board) {
		
		log.info("게시판 등록 진입 ");
		boardMapper.enroll(board);
	}


	public List<BoardVO> boardList() {
		
		log.info("게시판 목록 진입");
		return boardMapper.boardList();
	}


	@Override
	public BoardVO selectOne(int bno) {
		
		log.info("게시판 상세 조회 진입");
		return boardMapper.selectOne(bno);
	}


	@Override
	public int modify(BoardVO board) {
		
		log.info("게시판 수정 페이지 진입");
		return boardMapper.modify(board);
	}


	@Override
	public int delete(int bno) {
		
		log.info("게시판 삭제");
		return boardMapper.delete(bno);
	}


	@Override
	public List<BoardVO> getListPaging(Criteria cri) {
		
		return boardMapper.getListPaging(cri);
	}


	@Override
	public int getTotal() {
		
		return boardMapper.getTotal();
	}

}
