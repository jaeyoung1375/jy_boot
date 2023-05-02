<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/member/login.css">
<link rel="stylesheet" href="/css/main.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<meta charset="UTF-8">
<title>Insert title here</title>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
</head>
<body>


<%@include file="../include/header.jsp" %>

		<div class="wrapper">
			<form method="post" class="loginForm">
			
			 <h2>로그인</h2>
			 
			 <div class="textForm">
       			 <input name="memberId" type="text" class="id" placeholder="아이디" value="${cookie.id.value}">
    	     </div>
    	     <div class="textForm">
       			 <input name="memberPw" type="password" class="pw" placeholder="비밀번호">
    	     </div>
    	     <c:if test = "${result == 0}">
    	     <div class="login_warn">사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.</div>
    	     </c:if>
			<label><input type="checkbox" name="rememberId" ${empty cookie.id.value ? "" : "checked"}> 아이디 기억</label>
			 <input type="button" class="btn" id="login_button" value="L O G I N"/>
				<br>
				<a href="https://kauth.kakao.com/oauth/authorize?client_id=1b308937b1aec37f7b4bc57faeb4931b&redirect_uri=	
http://localhost:8080/member/auth/kakao/callback&response_type=code&scope=account_email,gender,age_range&prompt=login"><img src="/img/kakaoLogin.png"></a>
				<br>
				<a href="https://accounts.google.com/o/oauth2/v2/auth?client_id=197694978566-bljc0eo7lnf071parv36ntrenp3g69eb.apps.googleusercontent.com&
				redirect_uri=http://localhost:8080/member/login/oauth_google_check&response_type=code
&scope=email%20profile%20openid
&access_type=offline&prompt=login">구글 로그인</a>
			</form>
		</div>
		
		<script>
		
		$(document).ready(function(){
			
			$('#login_button').click(function(){
				$('.loginForm').attr('action','/member/login');
				$('.loginForm').submit();
			});
		});
		
		</script>

</body>
</html>