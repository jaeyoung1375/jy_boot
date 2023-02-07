<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

	<div class="container">
		<h2>회원 수정</h2>

		<span>모든 항목은 필수 입력입니다.</span><br><br><br><br>
		<div class="row text-center">
			<div class="col-sm-12" align="center">
			<form id = "updateForm" action="/admin/memberUpdate" method="post">
			<table class="table col-sm-12">
				<tr>
					<td><label class="control-label col-sm-12">아이디</label></td>
					<td><input type="text" class="form-control" id="fname" name="memberId" value="${memberInfo.memberId }" readonly="readonly"></td>
				</tr>
				<tr>
					<td><label class="control-label col-sm-12">비밀번호</label></td>
					<td><input type="text" class="form-control" id="lname" name="memberPw" value="${memberInfo.memberPw }"></td>
				</tr>
				<tr>
					<td><label class="control-label col-sm-12">이름</label></td>
					<td><input type="text" class="form-control" id="email" name="memberName" value="${memberInfo.memberName }" readonly="readonly"></td>
				</tr>
				<tr>
					<td><label class="control-label col-sm-12">닉네임</label></td>
					<td><input type="text" class="form-control" name="memberNickName" id="memberNickName" value="${memberInfo.memberNickName }"></td>
				</tr>			
				<tr>
					<td><label class="control-label col-sm-12">가입일자</label></td>
					<td><input type="text" class="form-control" name="createDt" value="<fmt:formatDate value="${memberInfo.createDt}" pattern="yyyy-MM-dd"/>" readonly="readonly"></td>
				</tr>
			</table>
			<!-- 
			<img class="card-img-top" src="../resources/upload/${list.mov_poster}" style="width:300px; height:300px;">
			<img class="card-img-top" src="../resources/upload/${list.mov_still1}" style="width:300px; height:300px;">
			<img class="card-img-top" src="../resources/upload/${list.mov_still2}" style="width:300px; height:300px;">
			<img class="card-img-top" src="../resources/upload/${list.mov_still3}" style="width:300px; height:300px;"><br>
			 -->
			<button type="button" class="btn btn-outline-danger" onclick="location.href='/admin/memberDetail?memberId=${memberInfo.memberId}'">취소</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="button" class="btn btn-outline-dark" id="modify_btn">수정</button>
		</form>
	</div>
	</div>
	</div>
	
	<script>
let mForm = $("#updateForm")

$("#modify_btn").on("click",function(e){
	mForm.submit();
});

</script>
	

</body>
</html>