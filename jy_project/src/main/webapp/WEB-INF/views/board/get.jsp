<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<!DOCTYPE html>
<html>
<head>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
  <style>
<style type="text/css">
.input_wrap{
	padding: 5px 20px;
}
label{
    display: block;
    margin: 10px 0;
    font-size: 20px;	
}
input{
	padding: 5px;
    font-size: 17px;
}
textarea{
	width: 800px;
    height: 200px;
    font-size: 15px;
    padding: 10px;
}
.btn{
  	display: inline-block;
    font-size: 22px;
    padding: 6px 12px;
    background-color: #fff;
    border: 1px solid #ddd;
    font-weight: 600;
    width: 140px;
    height: 41px;
    line-height: 39px;
    text-align : center;
    margin-left : 30px;
    cursor : pointer;
}
.btn_wrap{
	padding-left : 80px;
	margin-top : 50px;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<h1>조회 페이지</h1>
			<div class="input_wrap">
				<label>게시판 번호</label>		 
				<input type="text" name="bno" value='<c:out value="${pageInfo.bno}"/>' readonly>
			</div>
			<div class="input_wrap">
				<label>게시판 제목</label>
				<input type="text" name="title" value='<c:out value="${pageInfo.title}"/>' readonly>
			</div>
			<div class="input_wrap">
				<label>게시판 내용</label>
				<textarea rows="3" name="content" readonly="readonly"><c:out value="${pageInfo.content}"/></textarea>
			</div>
			<div class="input_wrap">
				<label>게시판 작성자</label>
				<input type="text" name="writer" value='<c:out value="${pageInfo.writer}"/>' readonly>
			</div>
			<div class="input_wrap">
				<label>게시판 등록일</label>
				<input type="text" name="regdate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${pageInfo.regdate}"/>' readonly>
			</div>
			<div class="input_wrap">
				<label>게시판 수정일</label>
				<input type="text" name="updateDate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${pageInfo.updateDate}"/>' readonly>
			</div>
			<div class="btn_wrap">
				<a class="btn" id="list_btn">목록 페이지</a>
				<a class="btn" id="modify_btn">수정 하기</a>
			</div>
			
			<form id="infoForm" action="/board/modify" method="get">
				<input type="hidden" id="bno" name="bno" value='<c:out value="${pageInfo.bno}"/>'>
			</form>
			
			
			
			<script>
			
				let form = $("#infoForm");
			
				$("#list_btn").click(function(){
					form.find("#bno").remove();
					form.attr("action","/board/list");
					form.submit();
				});
				
				$("#modify_btn").click(function(){
					form.attr("action","/board/modify");
					form.submit();
				});
			
			</script>
		
			

</body>
</html>