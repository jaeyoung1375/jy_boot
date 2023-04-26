<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/member/join.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body style="height:1200px;">
	<%@include file="../include/header.jsp" %> 
	
<div class="container">
		<h1 class="join_title">회원가입</h1>	
	</div>
	
	<div class="wrapper">	
	<form id="join_form" method="post">

		<!-- 아이디 입력 칸 -->
		<div class="join_id">
			<label class="id_title">아이디</label>
			<div class="id_comment">영문, 숫자를 포함한 8자 이상의 아이디를 입력해주세요.</div>
			<label>
				<input type="text" class="id_input" name="memberId" placeholder="아이디" id="id">
			</label>
			<span class="final_id_ck">아이디는 영문,숫자로 구성된 6자리 이상 12자리 이내로 작성하세요</span>  
				<span class="id_input_re_1">사용 가능한 아이디입니다.</span>
		      <span class="id_input_re_2">아이디가 이미 존재합니다.</span>
		</div>
		<!-- 아이디 입력 종료 -->
		

		<!-- 비밀번호 입력 칸 -->
		<div class="join_password">
			<label class="password_title">비밀번호</label>
			<div class="password_comment">영문,숫자,특수문자를 포함한 8자 이상의 비밀번호를 입력해주세요.</div>
			<label>
				<input type="password" class="password_input" name="memberPw" placeholder="비밀번호" id="pw">
			</label>
			<span class="essential_pw_ck">필수항목입니다!</span>
			<span class="final_pw_ck">비밀번호는 영문,숫자,특수기호를 포함하여 8자 이상이어야 합니다!</span>
		</div>
		<!-- 비밀번호 입력 종료 -->


		<!-- 비밀번호 확인 입력 칸 -->
			<div class="join_password_ck">
				<label class="password_ck_title">비밀번호 확인</label>
				<label>
					<input type="password" class="password_ck_input" name="passwordCk" placeholder="비밀번호 확인" id="pwck">
				</label>
				  <span class="final_pwck_ck">비밀번호 확인을 입력해주세요.</span>
			       <span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
			      <span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
			</div>
		<!-- 비밀번호 확인 입력칸 종료 -->


		<!-- 이름 입력 칸-->
		<div class="join_name">
			<label class="name_title">이름</label>
			<label>
				<input type="text" class="name_input" name="memberName" placeholder="이름">
			</label>
		</div>
        <!-- 닉네임 입력 칸 종료-->

		<!-- 닉네임 입력 칸-->
		   <div class="join_nickname">
			<label class="nickname_title">닉네임</label>
			<div class="nickname_comment">다른 유저와 겹치지 않도록 입력해주세요(2~15자)</div>
			<label>
				<input type="text" class="nickname_input" name="memberNickName" placeholder="별명 (2~15자)" id="nickname">
			</label>
		      <span class="nickname_input_re_1">별명이 이미 존재합니다.</span>
		      <span class="final_nickname_ck">잘못된 형식입니다!</span>
		</div>
        <!-- 닉네임 입력 칸 종료-->



		<!-- 이메일 입력 칸 -->
		<div class="join_email">
			<label class="email_title">이메일</label>
			<div class="email_input">
				<span class="email_input_local">
					<label>
						<input type="text" class="form-control" placeholder="이메일" name="memberEmail" id="email">
					</label>
					<span class="final_email_ck">잘못된 형식입니다!</span>
				</span>
				<span class="email_input_separator">@</span>
				<span class="email_input_domain">
					<label>
						<select class="form_control_empty">
							<option value="선택">선택</option>
							<option value="naver.com">naver.com</option>
							<option value="daum.net">daum.net</option>
						</select>
					</label>
				</span>
			</div>
			<input type="hidden" id="totalemail" name="mail" value="">
		</div>
			<div class="email_button">
			<button class="email_submit" type="button">이메일 인증하기</button>
			</div>
		<!-- 이메일 입력칸 종료 -->

		<div class="open_expand">
			<div class="open_expand_container">
				<div class="comment">이메일로 전송된 인증코드를 입력해주세요.</div>
					<div class="open_expand_wrapper">
						<div class="open_expand_main">
							<input type="text" placeholder="인증코드 6자리 입력" class="email_code">
							<button class="email_code_button" type="button" disabled>확인</button>
						</div>
					</div>
			<span id="email_check_input_box_warn"></span>
			</div>
		</div>
		
		<button class="join_submit" type="submit">회원가입하기</button>
	</form>
	
	</div>
	
	
	
		<script>
		
		var idCheck = false; // 아이디 정규표현식 검사
		var idckCheck = false; // 아이디 중복확인 검사
		var pwCheck = false;  // 비밀번호 검사
		var pwckCheck = false; // 비밀번호 확인 일치 검사
		var nameCheck = false;  // 이름 검사
		var nickNameCheck = false; // 닉네임 정규표현식 검사
		var nickNameckCheck = false; // 닉네임 중복확인 검사
		var emailCheck = false; // 이메일 인증번호 일치 여부 검사
		var emailckCheck = false // 이메일 정규표현식 검사
		let id_regex = /^[a-z0-9]{6,12}$/;
		let pw_regex = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
		let nickname_regex = /^[a-zA-Z0-9가-힣]{2,15}$/;
		let name_regex = /^[가-힣][2,6]$/	;
		let email_regex = /^[a-zA-z0-9]{5,15}$/;
		
		
			
			/* 회원가입 유효성 검사 */
			$(document).ready(function(){
				$(".join_submit").click(function(){
					
					var id = $('#id').val();
					var pw = $('#pw').val();
					var pwck = $('#pwck').val();
		
					
				
					
					if(pwck == ""){
						$('.final_pwck_ck').css('display','block');
						pwckheck = false;
					}else{
						$('.final_pwck_ck').css('display','none');
						pwckCheck = true;
					}
					
					
					
				//	if(idCheck&&idckCheck&&pwCheck&&pwckCheck&&nickNameCheck&&emailCheck&&emailckCheck){
					$("#join_form").attr("action","/member/join");
					$("#join_form").submit();
			//	}
					
				//	return false;
				});
		
			
			
			/* 이메일 컬럼 합치기 */
			$("#email").blur(function(){
				email();
			});
			
			$(".form_control_empty").change(function(){
				email();
			});
			
			function email(){
				const email = $("#email").val();
				const middle = $(".email_input_separator").text();
				const address = $(".form_control_empty").val();
				if(email != "" && address != ""){
					$("#totalemail").val(email+middle+address);
				}
			}; /* 이메일 컬럼 합치기 종료 */
			
			
			/* 비밀번호 일치 여부 체크 */
			$("#pwck").on("propertychange change keyup paste input",function(){
				
				var pw = $('#pw').val();
				var pwck = $('#pwck').val();
				$('.final_pwck_ck').css('display','none');
				
				if(pw == pwck){
					$('.pwck_input_re_1').css('display','block');
					$('.pwck_input_re_2').css('display','none');
					pwckCheck = true;
				}else{
					$('.pwck_input_re_1').css('display','none');
					$('.pwck_input_re_2').css('display','block');
					pwckCheck = false;
				}
			});
			
			/* 아이디 중복검사 */
			$("#id").on("propertychange change keyup paste input",function(){
				
				var memberId = $('#id').val();
				var data = {memberId : memberId};
				
				$.ajax({
					type:"post",
					url:"memberIdChk",
					data:data,
					success:function(result){
						if(result != 'fail'){
							$('.id_input_re_1').css('display','none');
							$('.id_input_re_2').css('display','none');
							idckCheck = true;
						}else{
							$('.id_input_re_1').css('display','none');
							$('.id_input_re_2').css('display','inline-block');
							idckCheck = false;
						}
					}
				});
			});
			
			/* 닉네임 중복검사 */
			$("#nickname").on("propertychange change keyup paste input",function(){
				
				var memberNickName = $('#nickname').val();
				var data = {memberNickName : memberNickName};
				
				$.ajax({
					type:"post",
					url:"memberNickNameChk",
					data:data,
					success:function(result){
						if(result != 'fail'){
							$('.nickname_input_re_1').css('display','none');
							nickNameckCheck = true;
						}else{
							$('.nickname_input_re_1').css('display','inline-block');
							nickNameckCheck = false;
						}
					}
				});
			});
			
			
			
			/* 아이디 정규표현식 검사 */
			$("#id").on("propertychange change keyup paste input", function(){
				
				var id= $('#id').val();
				
				if(!id_regex.test(id)){
					$('.final_id_ck').css('display','block');
					idCheck = false;
				}else{
					$('.final_id_ck').css('display','none');
					idCheck = true;
				}
			});
			
			/* 비밀번호 정규표현식 검사 */
			$('#pw').on("propertychange change keyup paste input",function(){
				
				var pw = $('#pw').val();
				
				if(!pw_regex.test(pw)){
					$('.final_pw_ck').css('display','block');
					pwCheck = false;
				}else{
					$('.final_pw_ck').css('display','none');
					pwCheck = true;
				}
	
			});
			
			/* 닉네임 정규표현식 검사 */
			$('#nickname').on("propertychange change keyup paste input",function(){
				
				var nickname = $('#nickname').val();
				
				if(!nickname_regex.test(nickname)){
					$('.final_nickname_ck').css('display','block');
					nickNameCheck = false;
				}else{
					$('.final_nickname_ck').css('display','none');
					nickNameCheck = true;
				}
	
			});
			
			
			/* 이메일 정규표현식 검사 */
			$('#email').on("propertychange change keyup paste input",function(){
				
				var email = $('#email').val();
				
				if(!email_regex.test(email)){
					$('.final_email_ck').css('display','block');
					emailckCheck = false;
				}else{
					$('.final_email_ck').css('display','none');
					emailckCheck = true;
				}
	
			});
			
			// 인증번호 이메일 전송
			$('.email_submit').click(function(){
				var email = $("#totalemail").val(); // 입력한 이메일
				var checkBox =$(".email_code").val(); // 인증번호 입력란
				
				if(emailckCheck){
					$('.open_expand').css('display','block');
				$.ajax({
					type: "GET",
					url : "/mailCheck?email="+email,
					success : function(data){
					console.log("data : " +data);
					code = data;
						
					}
				});
			}
				
				
			});
			
		// 인증번호 확인 버튼을 통한 유효성 검사
		$(".email_code_button").click(function(){
			
			var inputCode = $(".email_code").val(); // 입력코드
			var checkResult = $("#email_check_input_box_warn"); // 비교결과
			
			if(inputCode == code){
				checkResult.html("인증되었습니다.");
				checkResult.css("color","green");
				emailCheck = true;
			}else{
				checkResult.html("인증번호가 틀립니다.");
				checkResult.css("color","red");
				emailCheck = false;
			}
		});
		
		
		
		// 인증번호가 공백이 아닐시 버튼 disabled 해제
		$('.email_code').on("propertychange change keyup paste input",function(){
			
			var inputCode = $(".email_code").val(); // 입력코드
			var checkResult = $("#email_check_input_box_warn"); // 비교결과
			var button = $('.email_code_button');
			
			if(inputCode != ""){
				button.attr("disabled",false);
				button.css("background-color","#35c5f0");
				button.css("border-color","#35c5f0");
				button.css("color","#fff");
			}
		});
		
			
			});		
		
		</script>
	
</body>
</html>