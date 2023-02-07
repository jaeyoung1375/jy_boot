package com.jy.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jy.model.MemberVO;
import com.jy.service.AdminService;

import lombok.extern.log4j.Log4j;
import lombok.extern.log4j.Log4j2;


@Controller
@Log4j2
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public String main() {
		
		log.info("관리자페이지 진입");
		
		return "/admin/main";
	}
	
	@RequestMapping(value="/memberManage", method=RequestMethod.GET)
	public String memberManage(MemberVO member, Model model) {
		
		log.info("회원관리 페이지 진입");
		
		List<MemberVO> list = adminService.MemberList();
		model.addAttribute("list",list);
		
		
		return "/admin/memberManage";
	}
	
	@RequestMapping(value="/memberDetail", method=RequestMethod.GET)
	public String memberManage(String memberId ,Model model) {
		
		log.info("회원 상세 페이지 진입 ");
		model.addAttribute("memberInfo",adminService.selectOne(memberId));
		
		return "/admin/memberDetail";
		
	}
	
	@RequestMapping(value="/memberUpdate", method=RequestMethod.GET)
	public String memberUpdate(Model model, String memberId) {
		log.info("회원 수정 페이지 진입");
		model.addAttribute("memberInfo", adminService.selectOne(memberId));
	
		return "/admin/memberUpdate";
	}
	
	@PostMapping("/memberUpdate")
	public String memberUpdate(MemberVO member) {
		adminService.memberUpdate(member);
		
		return "redirect:/admin/memberManage";
	}
	

}
