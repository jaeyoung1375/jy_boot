package com.jy.controller;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.http.HttpRequest;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;


import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jy.model.GoogleInfResponse;
import com.jy.model.GoogleOAuthRequest;
import com.jy.model.GoogleRequest;
import com.jy.model.GoogleResponse;
import com.jy.model.KakaoProfile;
import com.jy.model.MemberVO;
import com.jy.model.OAuthToken;
import com.jy.service.MemberService;

import ch.qos.logback.core.recovery.ResilientSyslogOutputStream;
import lombok.extern.log4j.Log4j2;

// 인증이 안된 사용자들이 출입할 수 있는 경로를 /auth/** 허용
// 그냥 주소가 /이면 index.jsp 허용
// static 이하에 있는 /js/**, /css/**, /image/**

@Controller
@Log4j2
@RequestMapping("/member")
public class MemberController {
	
	
	@Value("${cos.key}")
	private String cosKey;
	
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private JavaMailSender mailSender;

	
	
	
	// 로그인 페이지 이동
	@GetMapping("/login")
	public String loginGET() {
		
		return "member/login";
	}
	
	@PostMapping("/login")
	public String loginPOST(@ModelAttribute MemberVO member,
			                HttpServletRequest request, RedirectAttributes rttr) {
		
		HttpSession session = request.getSession();
		MemberVO lvo = memberService.memberLogin(member);
		
		if(lvo == null) { // 일치하지 않는 아이디, 비밀번호를 입력한 경우
			int result = 0;
			rttr.addFlashAttribute("result",result);
			log.info("로그인 실패 !");
			return "redirect:/member/login";
		}
		
		session.setAttribute("member",lvo.getMemberId()); // 로그인 성공시 세션을 "member"로 넘겨줌
		log.info("로그인 성공 !");
		return "redirect:/";
	}
	
	@GetMapping("/logout")
	public String logout(HttpServletRequest request, HttpSession session) {
		
		session.removeAttribute("member");
		log.info("로그아웃 성공 ! ");
		
		
		return "redirect:/";
	}
	
	
	
	// 회원가입 페이지 이동
	@GetMapping("/join")
	public String joinGET() {
		
		return "member/join";
	}
	
	// 회원가입 기능
	@PostMapping("/join")
	public String joinPOST(@ModelAttribute MemberVO member) {
		
		
		
		memberService.memberJoin(member);
		
		return "redirect:/";
	}
	
	// 아이디 중복검사
	@PostMapping("/memberIdChk")
	@ResponseBody
	public String memberIdChk(@RequestParam String memberId) throws Exception{
		
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
	@PostMapping("/memberNickNameChk")
	@ResponseBody
	public String memberNickNameChk(@RequestParam String memberNickName) throws Exception{
			
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
	@GetMapping("/mailCheck")
	@ResponseBody
	public String mailCheckGET(@RequestParam String email) throws Exception{
		
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
	
	@GetMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		
		String memberId =(String) session.getAttribute("member");
		log.info("memberId : "+memberId);
		model.addAttribute("list",memberService.selectOne(memberId));
		return "/member/mypage";
	}
	
	@GetMapping("/auth/kakao/callback")
	public String kakaoCallback(String code,HttpSession session) { // Data를 리턴해주는 컨트롤러 함수
		
		// POST 방식으로 key=value 데이터를 요청(카카오쪽으로)
		RestTemplate rt = new RestTemplate();
		
		// HttpHeader 오브젝트 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		// HttpBody 오브젝트 생성
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "1b308937b1aec37f7b4bc57faeb4931b");
		params.add("redirect_uri", "http://localhost:8080/member/auth/kakao/callback");
		params.add("code", code);
		
		// HttpHeader와 HttpBody를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params,headers);
		
		// Http 요청하기 - Post방식으로 - 그리고 response의 변수의 응답 받음
		ResponseEntity<String> response = rt.exchange("https://kauth.kakao.com/oauth/token",
												HttpMethod.POST,
												kakaoTokenRequest,
												String.class);
		ObjectMapper objectMapper = new ObjectMapper();
		OAuthToken oAuthToken = null;
		
		try {
			oAuthToken = objectMapper.readValue(response.getBody(),OAuthToken.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		String access_token = oAuthToken.getAccess_token();
		System.out.println("카카오 엑세스 토큰 : "+access_token);
		
		
		
		RestTemplate rt2 = new RestTemplate();
		
		// HttpHeader 오브젝트 생성
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization","Bearer "+oAuthToken.getAccess_token());
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		
		// HttpHeader와 HttpBody를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest2 = new HttpEntity<>(headers2);
		
		// Http 요청하기 - Post방식으로 - 그리고 response의 변수의 응답 받음
		ResponseEntity<String> response2 = rt2.exchange("https://kapi.kakao.com/v2/user/me",
												HttpMethod.POST,
												kakaoProfileRequest2,
												String.class);
		
		ObjectMapper objectMapper2 = new ObjectMapper();
		KakaoProfile kakaoProfile = null;
		try {
			kakaoProfile = objectMapper2.readValue(response2.getBody(),KakaoProfile.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		// username,password,email
		System.out.println("카카오 아이디  : " +kakaoProfile.getId());
		System.out.println("카카오 이메일  : " +kakaoProfile.getKakao_account().getEmail());
		
		if(kakaoProfile.getKakao_account().getGender().equals("male")) {
			kakaoProfile.getKakao_account().setGender("남성");
		}
		
		System.out.println("성별 : " + kakaoProfile.getKakao_account().getGender());
		System.out.println("성별 : " + kakaoProfile.getKakao_account().getAge_range());
		
		System.out.println("블로그서버 유저네임 : "+kakaoProfile.getKakao_account().getEmail()+"_"+kakaoProfile.getId());
		System.out.println("블로그서버 이메일  : " +kakaoProfile.getKakao_account().getEmail());
		System.out.println("블로그 서버 패스워드 : "+cosKey);
		MemberVO kakaoUser = new MemberVO();
		kakaoUser.setMemberName(kakaoProfile.getKakao_account().getEmail());
		kakaoUser.setMemberPw(cosKey);
		kakaoUser.setMemberId(kakaoProfile.getKakao_account().getEmail());
		kakaoUser.setMemberNickName(kakaoProfile.getKakao_account().getEmail()+"_"+kakaoProfile.getId());
		kakaoUser.setMemberEmail(kakaoProfile.getKakao_account().getEmail());
		// 가입자 혹은 비가입자 체크해서 처리
		MemberVO originMember = memberService.selectOne(kakaoUser.getMemberName());
		
		if(originMember == null) {
			System.out.println("기존 회원이 아니므로 자동 회원가입을 진행합니다.");
			memberService.memberJoin(kakaoUser);
		}
		System.out.println("자동 로그인을 진행합니다.");
		session.setAttribute("member", access_token);
		session.setAttribute("refresh_token", oAuthToken.getRefresh_token());
		return "redirect:/";
	}
	
	@GetMapping("/v1/user/logout")
	public String kakaoLogout(HttpSession session, HttpServletResponse response, HttpServletRequest request) {
	    String access_token = (String) session.getAttribute("member");
	    String refresh_token = (String) session.getAttribute("refresh_token");
	    
	    try {
	        // send a request to the logout API endpoint
	        String logoutUrl = "https://kapi.kakao.com/v1/user/logout";
	        URL url = new URL(logoutUrl);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Authorization", "Bearer " + access_token);
	        int responseCode = conn.getResponseCode();
	        System.out.println("Response Code : " + responseCode);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }

	    // remove tokens from session and cookies
	    session.removeAttribute("member");    
	    session.removeAttribute("refresh_token");

	    
	  

	    return "redirect:/";
	}
	
	@GetMapping("/login/oauth_google_check")
	public String googleLoign(HttpServletRequest request, @RequestParam(value = "code") String authCode,
			HttpSession session){
		
		RestTemplate rt = new RestTemplate();
		
		// HttpBody 오브젝트 생성
		 GoogleRequest googleOAuthRequestParam = GoogleRequest
	                .builder()
	                .clientId("197694978566-bljc0eo7lnf071parv36ntrenp3g69eb.apps.googleusercontent.com")
	                .clientSecret("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")
	                .code(authCode)
	                .redirectUri("http://localhost:8080/member/login/oauth_google_check")
	                .grantType("authorization_code").build();
		 
		
		 
		
		 ResponseEntity<GoogleResponse> resultEntity = rt.postForEntity("https://oauth2.googleapis.com/token",
	                googleOAuthRequestParam, GoogleResponse.class);
		 
		
		 
		 
		
		
		 String jwtToken=resultEntity.getBody().getId_token();
	        Map<String, String> map=new HashMap<>();
	        map.put("id_token",jwtToken);
	        ResponseEntity<GoogleInfResponse> resultEntity2 = rt.postForEntity("https://oauth2.googleapis.com/tokeninfo",
	                map, GoogleInfResponse.class);
	        
	      
	    
	        
	        
	        System.out.println("엑세스 토큰 : "+resultEntity.getBody().getAccess_token());
	        System.out.println("아이디 토큰 : "+resultEntity.getBody().getId_token());
	        System.out.println("리프레시 토큰 : "+resultEntity.getBody().getRefresh_token());
	        String email=resultEntity2.getBody().getEmail();  
	        String name = resultEntity2.getBody().getName();
	        System.out.println("이메일 : "+email);
	        System.out.println("이름 : "+name);
	      
	        
	        MemberVO googleUser = new MemberVO();
	        googleUser.setMemberName(name);
	        googleUser.setMemberEmail(email);
	        googleUser.setMemberId(email);
	        googleUser.setMemberPw(cosKey);
	        googleUser.setMemberNickName(email);
	        
	        // 가입자 혹은 비가입자 체크해서 처리
	        MemberVO originMember = memberService.selectOne(googleUser.getMemberName());
	        
	        if(originMember == null) {
	        	System.out.println("기존 회원이 아니므로 자동 회원가입을 진행합니다");
	        	memberService.memberJoin(googleUser);
	        }
	        System.out.println("자동 로그인을 진행합니다.");
	        session.setAttribute("member",resultEntity.getBody().getAccess_token());
	        session.setAttribute("refresh_token", resultEntity.getBody().getRefresh_token());
	       
	        
	      
	      
	        
	        return "redirect:/";
		
		
		
		
		
		
	
		
		
	}
	
	
	
	
		
}

