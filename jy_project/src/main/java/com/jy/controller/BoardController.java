package com.jy.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

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
		
		int total = boardService.getTotal(cri);
		
		PageMakeDTO pageMake = new PageMakeDTO(cri, total);
		model.addAttribute("pageMaker",pageMake);
		
		return "/board/list";
	}
	@GetMapping("/enroll")
	public String boardEnrollGET(HttpSession session,Model model) {
		log.info("게시판 등록 페이지 진입");
		String memberId = (String) session.getAttribute("member");
		model.addAttribute("memberId",memberId);
		
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
	public String selectOne(int bno, Model model, Criteria cri, HttpSession session) {
		
		log.info("게시판 상세조회 진입");
		model.addAttribute("pageInfo",boardService.selectOne(bno));
		model.addAttribute("cri",cri);
		
		BoardVO board = boardService.selectOne(bno);
		String memberId = (String) session.getAttribute("member");
		
		boolean owner = board.getWriter() != null &&
						board.getWriter().equals(memberId);
		model.addAttribute("owner",owner);
		
		if(!owner) {
			Set<Integer> memory = (Set<Integer>) session.getAttribute("memory");
			if(memory == null) {
				memory = new HashSet<>();
			}
			
			if(!memory.contains(bno)) {
				boardService.updateReadCount(bno);
				board.setUpdateRead(board.getUpdateRead()+1);
				memory.add(bno);
			}
			System.out.println("memory = "+memory);
			session.setAttribute("memory", memory);
		}
	
		return "/board/get";		
	}
	
	@GetMapping("/modify")
	public String modify(int bno, Model model, Criteria cri) {
		
		log.info("게시판 수정 페이지 진입 ");
		model.addAttribute("pageInfo",boardService.selectOne(bno));
		model.addAttribute("cri",cri);
		
		return "/board/modify";
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr, Criteria cri, Model model) {
		
		boardService.modify(board);
		
		rttr.addFlashAttribute("result","modify success");
		model.addAttribute("cri",cri);
		
		return "redirect:/board/list";
		
	}
	
	@PostMapping("/delete")
	public String delete(int bno, RedirectAttributes rttr) {
		
		boardService.delete(bno);
		rttr.addFlashAttribute("result", "delete success");
		
		return "redirect:/board/list";
	}

}
