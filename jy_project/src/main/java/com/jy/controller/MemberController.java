package com.jy.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jy.model.MemberVO;
import com.jy.service.MemberService;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private JavaMailSender mailSender;
	
	// 로그인 페이지 이동
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String loginGET() {
		
		return "member/login";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String loginPOST(MemberVO member, HttpServletRequest request, RedirectAttributes rttr) {
		
		HttpSession session = request.getSession();
		MemberVO lvo = memberService.memberLogin(member);
		
		if(lvo == null) { // 일치하지 않는 아이디, 비밀번호를 입력한 경우
			int result = 0;
			rttr.addFlashAttribute("result",result);
			log.info("로그인 실패 !");
			return "redirect:/member/login";
		}
		
		session.setAttribute("member", lvo); // 로그인 성공시 세션을 "member"로 넘겨줌
		log.info("로그인 성공 !");
		return "redirect:/";
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		session.invalidate();
		log.info("로그아웃 성공 ! ");
		
		
		return "redirect:/";
	}
	
	
	
	// 회원가입 페이지 이동
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String joinGET() {
		
		return "member/join";
	}
	
	// 회원가입 기능
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String joinPOST(MemberVO member) {
		
		memberService.memberJoin(member);
		
		return "redirect:/";
	}
	
	// 아이디 중복검사
	@RequestMapping(value="/memberIdChk", method=RequestMethod.POST)
	@ResponseBody
	public String memberIdChk(String memberId) throws Exception{
		
		log.info("memberIdChk() 진입 " );
		int result = memberService.memberIdChk(memberId);
		System.out.println("result : "+result);
		
		if(result != 0) {
			return "fail";
		}else {
			return "success";
		}
	}
	
	
	// 닉네임 중복검사
	@RequestMapping(value="/memberNickNameChk", method=RequestMethod.POST)
	@ResponseBody
	public String memberNickNameChk(String memberNickName) throws Exception{
			
		log.info("memberNickNameChk() 진입 " );
		int result = memberService.memberNickNameChk(memberNickName);
		System.out.println("result : "+result);
			
		if(result != 0) {
			return "fail";
		}else {
			return "success";
		}
	}
	
//	// 아이디 찾기
//	@RequestMapping(value="/memberIdSearch", method=RequestMethod.GET)
//	public String memberIdSearch() {
//		
//		return "/member/memberIdSearch";
//	}
//	
//	@RequestMapping(value="/memberIdSearch", method=RequestMethod.POST)
//	public String memberIdSearch(@ModelAttribute MemberVO member, Model model) {
//		
//		MemberVO findMember = memberService.memberIdSearch(member);
//		log.info(memberService.memberIdSearch(member));
//		model.addAttribute("list",findMember);
//		
//		return "/member/test";
//	}
	
	
	
	// 이메일 인증
	@RequestMapping(value="/mailCheck", method=RequestMethod.GET)
	@ResponseBody

	public String mailCheckGET(String email) throws Exception{
		
		/* 뷰(view)로 부터 넘어온 데이터 확인 */
		log.info("이메일 데이터 전송 확인");
		log.info("인증번호 : "+ email);
		
		/* 인증번호(난수) 생성 */
		Random random = new Random();
		int checkNum = random.nextInt(888888)+111111;
		log.info("인증번호 : "+checkNum);
		
		/* 이메일 보내기 */
		String setFrom = "jaeyoung1375@naver.com";
		String toMail = email;
		String title = "회원가입 인증 이메일 입니다.";
		String content =
				"홈페이지를 방문해주셔서 감사합니다."+
				"<br><br>"+
				"인증 번호는 "+checkNum+"입니다."+
				"br"+
				"해당 인증번호를 인증번호 확인란에 기입해 주세요.";
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message,true,"UTF-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content,true);
			mailSender.send(message);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		String num = Integer.toString(checkNum);
		
		return num;
	}
	
	
	
	

}
