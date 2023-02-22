package com.jy.controller;




import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jy.model.MemberVO;
import com.jy.model.PaginationVO;
import com.jy.model.ProductDTO;
import com.jy.service.AdminService;
import lombok.extern.log4j.Log4j2;


@Controller
@Log4j2
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping("/main")
	public String main() {
		
		log.info("관리자페이지 진입");
		
		return "/admin/main";
	}
	// 회원 관리 페이지
	@GetMapping("/memberManage")
	public String memberManage(Model model, @ModelAttribute("vo") PaginationVO vo) {
		
		log.info("회원관리 페이지 진입");
	
		int totalCnt = adminService.count();
		vo.setCount(totalCnt);
		
		model.addAttribute("list",adminService.MemberList(vo));
		
		
		return "/admin/memberManage";
	}
	// 회원 상세 페이지
	@GetMapping("/memberDetail")
	public String memberManage(@RequestParam String memberId ,Model model) {
		
		log.info("회원 상세 페이지 진입 ");
		model.addAttribute("memberInfo",adminService.selectOne(memberId));
		
		return "/admin/memberDetail";
		
	}
	// 회원 수정 페이지
	@GetMapping("/memberUpdate")
	public String memberUpdate(Model model, @RequestParam String memberId) {
		log.info("회원 수정 페이지 진입");
		model.addAttribute("memberInfo", adminService.selectOne(memberId));
	
		return "/admin/memberUpdate";
	}
	
	@PostMapping("/memberUpdate")
	public String memberUpdate(@ModelAttribute MemberVO member) {
		adminService.memberUpdate(member);
		
		return "redirect:/admin/memberManage";
	}
	
	// 상품 관리 페이지
	@GetMapping("/productManage")
	public String productManage(Model model) {
			
		model.addAttribute("productDto",adminService.productList());
		System.out.println(adminService.productList());
		return "/admin/productManage";
	}
	
	// 상품 상세 페이지
	@GetMapping("/productDetail")
	public String productDetail(Model model, @RequestParam int productNo) {
		model.addAttribute("productDto",adminService.productSelectOne(productNo));
		return "/admin/productDetail";
	}
	
	// 상품 등록 페이지
	@GetMapping("/productEnroll")
	public String productEnroll() {
		
		return "/admin/productEnroll";
	}
	
	@PostMapping("/productEnroll")
	public String productEnroll(@ModelAttribute ProductDTO dto, RedirectAttributes rttr) {
		
		adminService.productEnroll(dto);
		rttr.addFlashAttribute("enroll_result",dto.getProductName());
		
		return "redirect:/admin/main";
	}
	
	
	
	

}
