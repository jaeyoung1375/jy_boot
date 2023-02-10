package com.jy.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jy.model.BoardVO;
import com.jy.model.Criteria;
import com.jy.model.PageMakeDTO;
import com.jy.service.BoardService;

import lombok.extern.log4j.Log4j;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
//	@GetMapping("/list")
//	public String boardListGET(Model model) {
//		log.info("게시판 목록 페이지 진입");
//		
//		List list = boardService.boardList();
//		
//		model.addAttribute("list",list);
//		
//		return "/board/list";
//	}
	
	@GetMapping("/list")
	public String boardList(Model model, Criteria cri) {
		
		log.info("게시판 목록 페이지 진입");
		
		model.addAttribute("list",boardService.getListPaging(cri));
		
		int total = boardService.getTotal();
		
		PageMakeDTO pageMake = new PageMakeDTO(cri, total);
		model.addAttribute("pageMaker",pageMake);
		
		return "/board/list";
	}
	@GetMapping("/enroll")
	public String boardEnrollGET() {
		log.info("게시판 등록 페이지 진입");
		
		return "/board/enroll";
	}
	
	@PostMapping("/enroll")
	public String boardEnrollPOST(BoardVO board, RedirectAttributes rttr) {
		
		log.info("boardVO : "+board);
		boardService.enroll(board);
		
		rttr.addFlashAttribute("result","enroll success");
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/get")
	public String selectOne(int bno, Model model) {
		
		log.info("게시판 상세조회 진입");
		model.addAttribute("pageInfo",boardService.selectOne(bno));
		
		return "/board/get";
		
	}
	
	@GetMapping("/modify")
	public String modify(int bno, Model model) {
		
		log.info("게시판 수정 페이지 진입 ");
		model.addAttribute("pageInfo",boardService.selectOne(bno));
		
		return "/board/modify";
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr) {
		
		boardService.modify(board);
		
		rttr.addFlashAttribute("result","modify success");
		
		return "redirect:/board/list";
		
	}
	
	@PostMapping("/delete")
	public String delete(int bno, RedirectAttributes rttr) {
		
		boardService.delete(bno);
		rttr.addFlashAttribute("result", "delete success");
		
		return "redirect:/board/list";
	}

}
