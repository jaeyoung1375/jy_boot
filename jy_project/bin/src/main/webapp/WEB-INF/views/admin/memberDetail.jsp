<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
		
	
	<div class="container">
		<h2>회원 조회</h2>

		<span>모든 항목은 필수 입력입니다.</span><br><br><br><br>
		<div class="row text-center">
			<div class="col-sm-12" align="center">
			<form action="updateMovieOk">		
			<table class="table col-sm-12">
				<tr>
					<td><label class="control-label col-sm-12">아이디</label></td>
					<td><input type="text" class="form-control" id="fname" name="memberId" value="${memberInfo.memberId }" readonly="readonly"></td>
				</tr>
				<tr>
					<td><label class="control-label col-sm-12">비밀번호</label></td>
					<td><input type="text" class="form-control" id="lname" name="memberPw" value="${memberInfo.memberPw }" readonly="readonly"></td>
				</tr>
				<tr>
					<td><label class="control-label col-sm-12">이름</label></td>
					<td><input type="text" class="form-control" id="email" name="memberName" value="${memberInfo.memberName }" readonly="readonly"></td>
				</tr>
				<tr>
					<td><label class="control-label col-sm-12">닉네임</label></td>
					<td><input type="text" class="form-control" name="memberNickName" id="memberNickName" value="${memberInfo.memberNickName }" readonly="readonly"></td>
				</tr>			
				<tr>
					<td><label class="control-label col-sm-12">가입일자</label></td>
					<td><input type="text" class="form-control" name="createDt" value="<fmt:formatDate value="${memberInfo.createDt}" pattern="yyyy-MM-dd"/>" readonly="readonly"></td>
				</tr>
			
			</table>
	
			<button type="button" class="btn btn-outline-danger" onclick="location.href='/admin/memberManage'">목록</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="button" class="btn btn-outline-dark" onclick="location.href='/admin/memberUpdate?memberId=${memberInfo.memberId}'">수정하기</button>
		</form>
	</div>
	</div>
	</div>
</body>
</html>