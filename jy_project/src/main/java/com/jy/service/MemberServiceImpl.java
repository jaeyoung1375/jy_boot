package com.jy.service;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jy.configuration.KakapLoginProperties;
import com.jy.mapper.MemberMapper;
import com.jy.model.FacebookProfile;
import com.jy.model.FacekbookResponse;
import com.jy.model.KakaoProfile;
import com.jy.model.MemberVO;
import com.jy.model.OAuthToken;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private KakapLoginProperties properties;
	
//	@Autowired
//	private RestTemplate rt;
//	
//	@Autowired
//	private RestTemplate rt2;
	
	@Autowired
	private HttpHeaders headers;

	
	
	// 회원가입
	public void memberJoin(MemberVO member) {
		
		
		
		memberMapper.memberJoin(member);	
	}


	@Override
	public int memberIdChk(String memberId) {
		
		return memberMapper.memberIdChk(memberId);
	}


	@Override
	public int memberNickNameChk(String memberNickName) {
		
		return memberMapper.memberNickNameChk(memberNickName);
	}


	@Override
	public MemberVO memberLogin(MemberVO member) {
		
		return memberMapper.memberLogin(member);
	}



	public MemberVO selectOne(String memberId) {
		
		return memberMapper.selectOne(memberId);
	}


	@Override
	public MemberVO memberIdSearch(MemberVO member) {
		
		return null;
	}


	@Override
	public KakaoProfile kakaoLogin(String code, OAuthToken oAuthToken) throws URISyntaxException {
		
		// 주소 생성
		
		
		
		// 주소 생성
		URI uri2 = new URI("https://kapi.kakao.com/v2/user/me");
		RestTemplate rt2 = new RestTemplate();
		
		// 헤더 생성
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization","Bearer "+oAuthToken.getAccess_token());
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		// Header + Body를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>> request2 = new HttpEntity<>(headers2);
		
		ResponseEntity<String> response2 = rt2.exchange(uri2, HttpMethod.POST,request2,String.class);
		
		ObjectMapper mapper2 = new ObjectMapper();
		KakaoProfile profile = null;
		
		try {
			profile = mapper2.readValue(response2.getBody(),KakaoProfile.class);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		if(profile.getKakao_account().getGender().equals("male")) {
			profile.getKakao_account().setGender("남성");
		}
		
	
		
		return profile;
	}


	@Override
	public OAuthToken tokenSearch(String code) throws URISyntaxException {
		
		// 주소 생성
				URI uri = new URI("https://kauth.kakao.com/oauth/token");
				
				RestTemplate rt = new RestTemplate();
				
				HttpHeaders headers = new HttpHeaders();
				headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
				
				// HttpBody 생성
				MultiValueMap<String,String> body = new LinkedMultiValueMap<String, String>();
				body.add("grant_type",properties.getGrantType());
				body.add("client_id", properties.getClientId());
				body.add("redirect_uri",properties.getRedirectUri());
				body.add("code", code);
				
				// Header + Body를 하나의 오브젝트에 담기
				HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(body,headers);
				
				// Http 요청 전송하기
				ResponseEntity<String> response = rt.exchange(uri,HttpMethod.POST,request,String.class);
				
				ObjectMapper mapper = new ObjectMapper();
				OAuthToken oAuthToken = null;
				
				try {
					oAuthToken = mapper.readValue(response.getBody(),OAuthToken.class);
				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}
				return oAuthToken;
	}


	@Override
	public FacekbookResponse facebookTokenSearch(String code) throws URISyntaxException {
				
		URI uri = new URI("https://graph.facebook.com/v13.0/oauth/access_token");
		String url = "https://graph.facebook.com/v13.0/oauth/access_token";
		RestTemplate rt = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type","application/x-www-form-urlencoded");
		
		MultiValueMap<String,String> body = new LinkedMultiValueMap<String, String>();
		body.add("client_id","2144292115764306");
		body.add("redirect_uri","http://localhost:8080/member/facebook/auth");
		body.add("client_secret","b0bbd8f33dce98c2a4ba8757da3d367f");
		body.add("code", code);
		
		HttpEntity<MultiValueMap<String,String>> request = new HttpEntity<>(body,headers);
		
		UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(url)
				.queryParam("client_id","2144292115764306")
				.queryParam("redirect_uri","http://localhost:8080/member/facebook/auth")
				.queryParam("client_secret","b0bbd8f33dce98c2a4ba8757da3d367f")
				.queryParam("code",code);
				
										
			
		
		
		ResponseEntity<FacekbookResponse> response = rt.exchange(builder.toUriString(),HttpMethod.POST,request,FacekbookResponse.class);
		
		ObjectMapper mapper = new ObjectMapper();
		FacekbookResponse token = response.getBody();
		/*
		try {
			token = mapper.readValue(response.getBody(),FacekbookResponse.class);
		}catch(Exception e) {
			e.printStackTrace();
		}
		*/
		
		
		return token;
	}


	@Override
	public FacebookProfile facebookLogin(String code, FacekbookResponse response) throws URISyntaxException {
		
		URI uri = new URI("https://graph.facebook.com/v13.0/me");
		String url = "https://graph.facebook.com/v13.0/me";
		RestTemplate rt = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization","Bearer "+response.getAccess_token());
		headers.add("Content-type","application/x-www-form-urlencoded");
		
		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(headers);
		
		UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(url)
										.queryParam("fields","id,email")
										.queryParam("access_token",response.getAccess_token());
		
		
		ResponseEntity<String> response2 = rt.exchange(builder.toUriString(),HttpMethod.POST,request,String.class);
		
		
		ObjectMapper mapper2 = new ObjectMapper();
		FacebookProfile profile = null;
		
		try {
			profile = mapper2.readValue(response2.getBody(),FacebookProfile.class);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		
		
		return profile;
	}
	
	
	
	

}
